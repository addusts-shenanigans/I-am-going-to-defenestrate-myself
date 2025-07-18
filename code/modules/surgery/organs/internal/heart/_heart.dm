/obj/item/organ/internal/heart
	name = "heart"
	desc = "I feel bad for the heartless bastard who lost this."
	icon_state = "heart-on"
	base_icon_state = "heart"
	visual = FALSE
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_HEART

	healing_factor = STANDARD_ORGAN_HEALING
	decay_factor = 2.5 * STANDARD_ORGAN_DECAY //designed to fail around 6 minutes after death

	low_threshold_passed = "<span class='info'>Prickles of pain appear then die out from within your chest...</span>"
	high_threshold_passed = "<span class='warning'>Something inside your chest hurts, and the pain isn't subsiding. You notice yourself breathing far faster than before.</span>"
	now_fixed = "<span class='info'>Your heart begins to beat again.</span>"
	high_threshold_cleared = "<span class='info'>The pain in your chest has died down, and your breathing becomes more relaxed.</span>"

	// Heart attack code is in code/modules/mob/living/carbon/human/life.dm
	var/beating = TRUE
	attack_verb_continuous = list("beats", "thumps")
	attack_verb_simple = list("beat", "thump")
	var/beat = BEAT_NONE//is this mob having a heatbeat sound played? if so, which?
	var/failed = FALSE //to prevent constantly running failing code
	var/operated = FALSE //whether the heart's been operated on to fix some of its damages

	var/datum/blood_type/heart_bloodtype

/obj/item/organ/internal/heart/update_icon_state()
	icon_state = "[base_icon_state]-[beating ? "on" : "off"]"
	return ..()

/obj/item/organ/internal/heart/Insert(mob/living/carbon/receiver, special, drop_if_replaced)
	. = ..()
	if(heart_bloodtype)
		receiver.dna?.human_blood_type = heart_bloodtype

/obj/item/organ/internal/heart/Remove(mob/living/carbon/heartless, special = 0)
	. = ..()
	if(heart_bloodtype)
		heartless.dna?.human_blood_type = random_human_blood_type()
	if(!special)
		addtimer(CALLBACK(src, PROC_REF(stop_if_unowned)), 120)

/obj/item/organ/internal/heart/proc/stop_if_unowned()
	if(!owner)
		Stop()

/obj/item/organ/internal/heart/attack_self(mob/user)
	..()
	if(!beating)
		user.visible_message("<span class='notice'>[user] squeezes [src] to \
			make it beat again!</span>",span_notice("You squeeze [src] to make it beat again!"))
		Restart()
		addtimer(CALLBACK(src, PROC_REF(stop_if_unowned)), 80)

/obj/item/organ/internal/heart/proc/Stop()
	beating = FALSE
	update_appearance()
	return TRUE

/obj/item/organ/internal/heart/proc/Restart()
	beating = TRUE
	update_appearance()
	return TRUE

/obj/item/organ/internal/heart/OnEatFrom(eater, feeder)
	. = ..()
	beating = FALSE
	update_appearance()

/obj/item/organ/internal/heart/proc/get_heart_rate()
	if(!beating)
		return 0

	var/base_amount = 0

	if(owner.has_status_effect(/datum/status_effect/jitter))
		base_amount = 100 + rand(0, 25)
	else if(owner.stat == SOFT_CRIT || owner.stat == HARD_CRIT)
		base_amount = 60 + rand(-15, -10)
	else
		base_amount = 80 + rand(-10, 10)
	base_amount += round(owner.getOxyLoss() / 5)
	base_amount += ((BLOOD_VOLUME_NORMAL - owner.blood_volume) / 25)
	base_amount += owner.pain_controller?.get_heartrate_modifier()
	if(owner.has_status_effect(/datum/status_effect/determined)) // adrenaline
		base_amount += 10

	if(owner.has_reagent(/datum/reagent/consumable/coffee)) // funny
		base_amount += 10

	return round(base_amount * clamp(1.5 * ((maxHealth - damage) / maxHealth), 0.5, 1)) // heart damage puts a multiplier on it

/obj/item/organ/internal/heart/get_status_text(advanced, add_tooltips)
	if(!beating && !(organ_flags & ORGAN_FAILING) && owner.needs_heart() && owner.stat != DEAD)
		return conditional_tooltip("<font color='#cc3333'>Cardiac Arrest</font>", "Apply defibrillation immediately. Similar electric shocks may work in emergencies.", add_tooltips)
	return ..()

/obj/item/organ/internal/heart/show_on_condensed_scans()
	// Always show if the guy needs a heart (so its status can be monitored)
	return ..() || owner.needs_heart()

/obj/item/organ/internal/heart/on_life(seconds_per_tick, times_fired)
	..()

	// If the owner doesn't need a heart, we don't need to do anything with it.
	if(!owner.needs_heart())
		return

	if(owner.client && beating)
		failed = FALSE
		var/sound/slowbeat = sound('sound/health/slowbeat.ogg', repeat = TRUE)
		var/sound/fastbeat = sound('sound/health/fastbeat.ogg', repeat = TRUE)

		if(owner.health <= owner.crit_threshold && beat != BEAT_SLOW)
			beat = BEAT_SLOW
			owner.playsound_local(get_turf(owner), slowbeat, 40, 0, channel = CHANNEL_HEARTBEAT, use_reverb = FALSE)
			to_chat(owner, span_notice("You feel your heart slow down..."))

		if(beat == BEAT_SLOW && owner.health > owner.crit_threshold)
			owner.stop_sound_channel(CHANNEL_HEARTBEAT)
			beat = BEAT_NONE

		if(owner.has_status_effect(/datum/status_effect/jitter))
			if(owner.health > HEALTH_THRESHOLD_FULLCRIT && (!beat || beat == BEAT_SLOW))
				owner.playsound_local(get_turf(owner), fastbeat, 40, 0, channel = CHANNEL_HEARTBEAT, use_reverb = FALSE)
				beat = BEAT_FAST

		else if(beat == BEAT_FAST)
			owner.stop_sound_channel(CHANNEL_HEARTBEAT)
			beat = BEAT_NONE

	if((organ_flags & ORGAN_FAILING) || !beating) //heart broke, stopped beating, death imminent... unless you have veins that pump blood without a heart
		if(owner.can_heartattack() && !(HAS_TRAIT(src, TRAIT_STABLEHEART)))
			if(owner.stat == CONSCIOUS && beating) // monkestation edit: antispam
				owner.visible_message(span_danger("[owner] clutches at [owner.p_their()] chest as if [owner.p_their()] heart is stopping!"), \
					span_userdanger("You feel a terrible pain in your chest, as if your heart has stopped!"))
			owner.set_heartattack(TRUE)
			failed = TRUE
		owner.adjust_pain_shock(1 * seconds_per_tick)

/obj/item/organ/internal/heart/get_availability(datum/species/owner_species, mob/living/owner_mob)
	return owner_species.mutantheart

/obj/item/organ/internal/heart/cursed
	name = "cursed heart"
	desc = "A heart that, when inserted, will force you to pump it manually."
	icon_state = "cursedheart-off"
	base_icon_state = "cursedheart"
	decay_factor = 0
	actions_types = list(/datum/action/item_action/organ_action/cursed_heart)
	var/last_pump = 0
	var/add_colour = TRUE //So we're not constantly recreating colour datums
	/// How long between needed pumps; you can pump one second early
	var/pump_delay = 3 SECONDS
	/// How much blood volume you lose every missed pump, this is a flat amount not a percentage!
	var/blood_loss = (BLOOD_VOLUME_NORMAL / 5) // 20% of normal volume, missing five pumps is instant death

	//How much to heal per pump, negative numbers would HURT the player
	var/heal_brute = 0
	var/heal_burn = 0
	var/heal_oxy = 0


/obj/item/organ/internal/heart/cursed/attack(mob/living/carbon/human/accursed, mob/living/carbon/human/user, obj/target)
	if(accursed == user && istype(accursed))
		playsound(user,'sound/effects/singlebeat.ogg',40,TRUE)
		user.temporarilyRemoveItemFromInventory(src, TRUE)
		Insert(user)
	else
		return ..()

/// Worker proc that checks logic for if a pump can happen, and applies effects/notifications from doing so
/obj/item/organ/internal/heart/cursed/proc/on_pump(mob/owner)
	var/next_pump = last_pump + pump_delay - (1 SECONDS) // pump a second early
	if(world.time < next_pump)
		to_chat(owner, span_userdanger("Too soon!"))
		return

	last_pump = world.time
	playsound(owner,'sound/effects/singlebeat.ogg', 40, TRUE)
	to_chat(owner, span_notice("Your heart beats."))

	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/accursed = owner

	if(HAS_TRAIT(accursed, TRAIT_NOBLOOD) || !accursed.dna)
		return
	accursed.blood_volume = min(accursed.blood_volume + (blood_loss * 0.5), BLOOD_VOLUME_MAXIMUM)
	accursed.remove_client_colour(/datum/client_colour/cursed_heart_blood)
	add_colour = TRUE
	accursed.adjustBruteLoss(-heal_brute)
	accursed.adjustFireLoss(-heal_burn)
	accursed.adjustOxyLoss(-heal_oxy)

/obj/item/organ/internal/heart/cursed/on_life(seconds_per_tick, times_fired)
	if(!owner.client || !ishuman(owner)) // Let's be fair, if you're not here to pump, you're not here to suffer.
		last_pump = world.time
		return

	if(world.time <= (last_pump + pump_delay))
		return

	var/mob/living/carbon/human/accursed = owner
	if(HAS_TRAIT(accursed, TRAIT_NOBLOOD) || !accursed.dna)
		return

	accursed.blood_volume = max(accursed.blood_volume - blood_loss, 0)
	to_chat(accursed, span_userdanger("You have to keep pumping your blood!"))
	if(add_colour)
		accursed.add_client_colour(/datum/client_colour/cursed_heart_blood) //bloody screen so real
		add_colour = FALSE

/obj/item/organ/internal/heart/cursed/on_insert(mob/living/carbon/accursed)
	. = ..()
	last_pump = world.time // give them time to react
	to_chat(accursed, span_userdanger("Your heart has been replaced with a cursed one, you have to pump this one manually otherwise you'll die!"))

/obj/item/organ/internal/heart/cursed/Remove(mob/living/carbon/accursed, special = FALSE)
	. = ..()
	accursed.remove_client_colour(/datum/client_colour/cursed_heart_blood)

/datum/action/item_action/organ_action/cursed_heart
	name = "Pump your blood"
	check_flags = NONE

//You are now brea- pumping blood manually
/datum/action/item_action/organ_action/cursed_heart/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return

	var/obj/item/organ/internal/heart/cursed/cursed_heart = target
	if(!istype(cursed_heart))
		CRASH("Cursed heart pump action created on non-cursed heart!")
	cursed_heart.on_pump(owner)

/datum/client_colour/cursed_heart_blood
	priority = 100 //it's an indicator you're dying, so it's very high priority
	colour = "red"

/obj/item/organ/internal/heart/cybernetic
	name = "basic cybernetic heart"
	desc = "A basic electronic device designed to mimic the functions of an organic human heart."
	icon_state = "heart-c-on"
	base_icon_state = "heart-c"
	organ_flags = ORGAN_ROBOTIC
	maxHealth = STANDARD_ORGAN_THRESHOLD*0.75 //This also hits defib timer, so a bit higher than its less important counterparts

	var/dose_available = FALSE
	var/rid = /datum/reagent/medicine/epinephrine
	var/ramount = 10
	var/emp_vulnerability = 80 //Chance of permanent effects if emp-ed.

/obj/item/organ/internal/heart/cybernetic/tier2
	name = "cybernetic heart"
	desc = "An electronic device designed to mimic the functions of an organic human heart. Also holds an emergency dose of epinephrine, used automatically after facing severe trauma."
	icon_state = "heart-c-u-on"
	base_icon_state = "heart-c-u"
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	dose_available = TRUE
	emp_vulnerability = 40

/obj/item/organ/internal/heart/cybernetic/tier3
	name = "upgraded cybernetic heart"
	desc = "An electronic device designed to mimic the functions of an organic human heart. Also holds an emergency dose of epinephrine, used automatically after facing severe trauma. This upgraded model can regenerate its dose after use."
	icon_state = "heart-c-u2-on"
	base_icon_state = "heart-c-u2"
	maxHealth = 2 * STANDARD_ORGAN_THRESHOLD
	dose_available = TRUE
	emp_vulnerability = 20

/obj/item/organ/internal/heart/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	// If the owner doesn't need a heart, we don't need to do anything with it.
	if(!owner?.needs_heart())
		return
	if(!COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		owner.set_dizzy_if_lower(20 SECONDS)
		owner.losebreath += 10
		COOLDOWN_START(src, severe_cooldown, 20 SECONDS)
	if(prob(emp_vulnerability/severity)) //Chance of permanent effects
		organ_flags |= ORGAN_EMP //Starts organ faliure - gonna need replacing soon
		// monkestation edit: antispam
		if(beating)
			owner.visible_message(span_danger("[owner] clutches at [owner.p_their()] chest as if [owner.p_their()] heart is stopping!"), \
									span_userdanger("You feel a terrible pain in your chest, as if your heart has stopped!"))
			Stop()
			addtimer(CALLBACK(src, PROC_REF(Restart)), 10 SECONDS)
		// monkestation end

/obj/item/organ/internal/heart/cybernetic/on_life(seconds_per_tick, times_fired)
	. = ..()
	if(dose_available && owner.health <= owner.crit_threshold && !owner.reagents.has_reagent(rid))
		used_dose()

/obj/item/organ/internal/heart/cybernetic/proc/used_dose()
	owner.reagents.add_reagent(rid, ramount)
	dose_available = FALSE

/obj/item/organ/internal/heart/cybernetic/tier3/used_dose()
	. = ..()
	addtimer(VARSET_CALLBACK(src, dose_available, TRUE), 5 MINUTES)

/obj/item/organ/internal/heart/freedom
	name = "heart of freedom"
	desc = "This heart pumps with the passion to give... something freedom."
	organ_flags = ORGAN_ROBOTIC  //the power of freedom prevents heart attacks
	/// The cooldown until the next time this heart can give the host an adrenaline boost.
	COOLDOWN_DECLARE(adrenaline_cooldown)

/obj/item/organ/internal/heart/freedom/on_life(seconds_per_tick, times_fired)
	. = ..()
	if(owner.health < 5 && COOLDOWN_FINISHED(src, adrenaline_cooldown))
		COOLDOWN_START(src, adrenaline_cooldown, rand(25 SECONDS, 1 MINUTES))
		to_chat(owner, span_userdanger("You feel yourself dying, but you refuse to give up!"))
		owner.heal_overall_damage(brute = 15, burn = 15, required_bodytype = BODYTYPE_ORGANIC)
		if(owner.reagents.get_reagent_amount(/datum/reagent/medicine/ephedrine) < 20)
			owner.reagents.add_reagent(/datum/reagent/medicine/ephedrine, 10)

/obj/item/organ/internal/heart/ethereal
	name = "crystal core"
	icon_state = "ethereal_heart" //Welp. At least it's more unique in functionaliy.
	visual = TRUE //This is used by the ethereal species for color
	desc = "A crystal-like organ that functions similarly to a heart for Ethereals. It can revive its owner."
	heart_bloodtype = /datum/blood_type/crew/ethereal

	///Cooldown for the next time we can crystalize
	COOLDOWN_DECLARE(crystalize_cooldown)
	///Timer ID for when we will be crystalized, If not preparing this will be null.
	var/crystalize_timer_id
	///The current crystal the ethereal is in, if any
	var/obj/structure/ethereal_crystal/current_crystal
	///Damage taken during crystalization, resets after it ends
	var/crystalization_process_damage = 0
	///Color of the heart, is set by the species on gain
	var/ethereal_color = "#9c3030"

/obj/item/organ/internal/heart/ethereal/Initialize(mapload)
	. = ..()
	add_atom_colour(ethereal_color, FIXED_COLOUR_PRIORITY)

/obj/item/organ/internal/heart/ethereal/Insert(mob/living/carbon/heart_owner, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
	if(!.)
		return
	RegisterSignal(heart_owner, COMSIG_MOB_STATCHANGE, PROC_REF(on_stat_change))
	RegisterSignal(heart_owner, COMSIG_LIVING_POST_FULLY_HEAL, PROC_REF(on_owner_fully_heal))
	RegisterSignal(heart_owner, COMSIG_QDELETING, PROC_REF(owner_deleted))

/obj/item/organ/internal/heart/ethereal/Remove(mob/living/carbon/heart_owner, special = FALSE)
	UnregisterSignal(heart_owner, list(COMSIG_MOB_STATCHANGE, COMSIG_LIVING_POST_FULLY_HEAL, COMSIG_QDELETING))
	REMOVE_TRAIT(heart_owner, TRAIT_CORPSELOCKED, SPECIES_TRAIT)
	stop_crystalization_process(heart_owner)
	QDEL_NULL(current_crystal)
	return ..()

/obj/item/organ/internal/heart/ethereal/update_overlays()
	. = ..()
	var/mutable_appearance/shine = mutable_appearance(icon, icon_state = "[icon_state]_shine")
	shine.appearance_flags = RESET_COLOR //No color on this, just pure white
	. += shine


/obj/item/organ/internal/heart/ethereal/proc/on_owner_fully_heal(mob/living/carbon/healed, heal_flags)
	SIGNAL_HANDLER

	QDEL_NULL(current_crystal) //Kicks out the ethereal

///Ran when examined while crystalizing, gives info about the amount of time left
/obj/item/organ/internal/heart/ethereal/proc/on_examine(mob/living/carbon/human/examined_human, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(!crystalize_timer_id)
		return

	switch(timeleft(crystalize_timer_id))
		if(0 to CRYSTALIZE_STAGE_ENGULFING)
			examine_list += span_warning("Crystals are almost engulfing [examined_human]! ")
		if(CRYSTALIZE_STAGE_ENGULFING to CRYSTALIZE_STAGE_ENCROACHING)
			examine_list += span_notice("Crystals are starting to cover [examined_human]. ")
		if(CRYSTALIZE_STAGE_SMALL to INFINITY)
			examine_list += span_notice("Some crystals are coming out of [examined_human]. ")

///On stat changes, if the victim is no longer dead but they're crystalizing, cancel it, if they become dead, start the crystalizing process if possible
/obj/item/organ/internal/heart/ethereal/proc/on_stat_change(mob/living/victim, new_stat)
	SIGNAL_HANDLER

	if(new_stat != DEAD)
		if(crystalize_timer_id)
			stop_crystalization_process(victim)
		return

	if(QDELETED(victim) || HAS_TRAIT(victim, TRAIT_SUICIDED))
		return //lol rip

	if(!COOLDOWN_FINISHED(src, crystalize_cooldown))
		return //lol double rip

	if(HAS_TRAIT(victim, TRAIT_CANNOT_CRYSTALIZE) || HAS_TRAIT(victim, TRAIT_DEFIB_BLACKLISTED))
		return // no reviving during mafia, or other inconvenient times.

	to_chat(victim, span_nicegreen("Crystals start forming around your dead body."))
	victim.visible_message(span_notice("Crystals start forming around [victim]."), ignored_mobs = victim)

	ADD_TRAIT(victim, TRAIT_CORPSELOCKED, SPECIES_TRAIT)

	crystalize_timer_id = addtimer(CALLBACK(src, PROC_REF(crystalize), victim), CRYSTALIZE_PRE_WAIT_TIME, TIMER_STOPPABLE)

	RegisterSignal(victim, COMSIG_HUMAN_DISARM_HIT, PROC_REF(reset_crystalizing))
	RegisterSignal(victim, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine), override = TRUE)
	RegisterSignal(victim, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_take_damage))

///Ran when disarmed, prevents the ethereal from reviving
/obj/item/organ/internal/heart/ethereal/proc/reset_crystalizing(mob/living/defender, mob/living/attacker, zone)
	SIGNAL_HANDLER
	defender.visible_message(
		span_notice("The crystals on [defender] are gently broken off."),
		span_notice("The crystals on your corpse are gently broken off, and will need some time to recover."),
	)
	deltimer(crystalize_timer_id)
	crystalize_timer_id = addtimer(CALLBACK(src, PROC_REF(crystalize), defender), CRYSTALIZE_DISARM_WAIT_TIME, TIMER_STOPPABLE) //Lets us restart the timer on disarm


///Actually spawns the crystal which puts the ethereal in it.
/obj/item/organ/internal/heart/ethereal/proc/crystalize(mob/living/ethereal)

	var/location = ethereal.loc

	if(!COOLDOWN_FINISHED(src, crystalize_cooldown) || ethereal.stat != DEAD)
		return //Should probably not happen, but lets be safe.

	//Monkestation Edit Begin
	if(IS_BLOODSUCKER(ethereal) && SSsol.sunlight_active)
		to_chat(ethereal, span_warning("You were unable to finish your crystallization as Sol has halted your attempt to crystallize."))
		stop_crystalization_process(ethereal, FALSE)
		return
	//Monkestation Edit End

	if(ismob(location) || isitem(location) || iseffect(location) || HAS_TRAIT_FROM(src, TRAIT_HUSK, CHANGELING_DRAIN)) //Stops crystallization if they are eaten by a dragon, turned into a legion, consumed by his grace, etc.
		to_chat(ethereal, span_warning("You were unable to finish your crystallization, for obvious reasons."))
		stop_crystalization_process(ethereal, FALSE)
		return

	COOLDOWN_START(src, crystalize_cooldown, INFINITY) //Prevent cheeky double-healing until we get out, this is against stupid admemery
	current_crystal = new(get_turf(ethereal), src)
	stop_crystalization_process(ethereal, TRUE)

///Stop the crystalization process, unregistering any signals and resetting any variables.
/obj/item/organ/internal/heart/ethereal/proc/stop_crystalization_process(mob/living/ethereal, succesful = FALSE)
	UnregisterSignal(ethereal, COMSIG_HUMAN_DISARM_HIT)
	UnregisterSignal(ethereal, COMSIG_ATOM_EXAMINE)
	UnregisterSignal(ethereal, COMSIG_MOB_APPLY_DAMAGE)

	crystalization_process_damage = 0 //Reset damage taken during crystalization

	if(!succesful)
		REMOVE_TRAIT(ethereal, TRAIT_CORPSELOCKED, SPECIES_TRAIT)
		QDEL_NULL(current_crystal)

	if(crystalize_timer_id)
		deltimer(crystalize_timer_id)
		crystalize_timer_id = null

/obj/item/organ/internal/heart/ethereal/proc/owner_deleted(datum/source)
	SIGNAL_HANDLER

	stop_crystalization_process(owner)
	return

///Lets you stop the process with enough brute damage
/obj/item/organ/internal/heart/ethereal/proc/on_take_damage(datum/source, damage, damagetype, def_zone)
	SIGNAL_HANDLER
	if(damagetype != BRUTE)
		return

	crystalization_process_damage += damage

	if(crystalization_process_damage < BRUTE_DAMAGE_REQUIRED_TO_STOP_CRYSTALIZATION)
		return

	var/mob/living/carbon/human/ethereal = source

	ethereal.visible_message(
		span_notice("The crystals on [ethereal] are completely shattered and stopped growing."),
		span_warning("The crystals on your body have completely broken."),
	)

	stop_crystalization_process(ethereal)

/obj/structure/ethereal_crystal
	name = "ethereal resurrection crystal"
	desc = "It seems to contain the corpse of an ethereal mending its wounds."
	icon = 'icons/obj/ethereal_crystal.dmi'
	icon_state = "ethereal_crystal"
	damage_deflection = 0
	max_integrity = 100
	resistance_flags = FIRE_PROOF
	density = TRUE
	anchored = TRUE
	///The organ this crystal belongs to
	var/obj/item/organ/internal/heart/ethereal/ethereal_heart
	///Timer for the healing process. Stops if destroyed.
	var/crystal_heal_timer
	///Is the crystal still being built? True by default, gets changed after a timer.
	var/being_built = TRUE

/obj/structure/ethereal_crystal/Initialize(mapload, obj/item/organ/internal/heart/ethereal/ethereal_heart)
	. = ..()
	if(!ethereal_heart)
		stack_trace("Our crystal has no related heart")
		return INITIALIZE_HINT_QDEL
	src.ethereal_heart = ethereal_heart
	ethereal_heart.owner.visible_message(span_notice("The crystals fully encase [ethereal_heart.owner]!"))
	to_chat(ethereal_heart.owner, span_notice("You are encased in a huge crystal!"))
	playsound(get_turf(src), 'sound/effects/ethereal_crystalization.ogg', 50)
	var/atom/movable/possible_chair = ethereal_heart.owner.buckled
	possible_chair?.unbuckle_mob(ethereal_heart.owner, force = TRUE)
	ethereal_heart.owner.forceMove(src) //put that ethereal in
	add_atom_colour(ethereal_heart.ethereal_color, FIXED_COLOUR_PRIORITY)
	crystal_heal_timer = addtimer(CALLBACK(src, PROC_REF(heal_ethereal)), CRYSTALIZE_HEAL_TIME, TIMER_STOPPABLE)
	set_light(l_outer_range = 4, l_power = 10, l_color = ethereal_heart.ethereal_color)
	update_icon()
	flick("ethereal_crystal_forming", src)
	addtimer(CALLBACK(src, PROC_REF(start_crystalization)), 1 SECONDS)

/obj/structure/ethereal_crystal/proc/start_crystalization()
	being_built = FALSE
	update_icon()


/obj/structure/ethereal_crystal/atom_destruction(damage_flag)
	playsound(get_turf(ethereal_heart.owner), 'sound/effects/ethereal_revive_fail.ogg', 100)
	return ..()


/obj/structure/ethereal_crystal/Destroy()
	if(!ethereal_heart)
		return ..()
	ethereal_heart.current_crystal = null
	COOLDOWN_START(ethereal_heart, crystalize_cooldown, CRYSTALIZE_COOLDOWN_LENGTH)
	ethereal_heart.owner.forceMove(get_turf(src))
	REMOVE_TRAIT(ethereal_heart.owner, TRAIT_CORPSELOCKED, SPECIES_TRAIT)
	deltimer(crystal_heal_timer)
	visible_message(span_notice("The crystals shatters, causing [ethereal_heart.owner] to fall out."))
	return ..()

/obj/structure/ethereal_crystal/update_overlays()
	. = ..()
	if(!being_built)
		var/mutable_appearance/shine = mutable_appearance(icon, icon_state = "[icon_state]_shine")
		shine.appearance_flags = RESET_COLOR //No color on this, just pure white
		. += shine

/obj/structure/ethereal_crystal/proc/heal_ethereal()
	var/datum/brain_trauma/picked_trauma
	if(prob(10)) //10% chance for a severe trauma
		picked_trauma = pick(subtypesof(/datum/brain_trauma/severe))
	else
		picked_trauma = pick(subtypesof(/datum/brain_trauma/mild))

	// revive will regenerate organs, so our heart refence is going to be null'd. Unreliable
	var/mob/living/carbon/regenerating = ethereal_heart.owner

	playsound(get_turf(regenerating), 'sound/effects/ethereal_revive.ogg', 100)
	to_chat(regenerating, span_notice("You burst out of the crystal with vigour... </span><span class='userdanger'>But at a cost."))
	regenerating.gain_trauma(picked_trauma, TRAUMA_RESILIENCE_ABSOLUTE)
	regenerating.revive(HEAL_ALL & ~HEAL_REFRESH_ORGANS)
	// revive calls fully heal -> deletes the crystal.
	// this qdeleted check is just for sanity.
	if(!QDELETED(src))
		qdel(src)

/obj/item/organ/internal/heart/lizard
	name = "lizard heart"
	heart_bloodtype = /datum/blood_type/crew/lizard

/obj/item/organ/internal/heart/pod
	name = "plant heart"
	heart_bloodtype = /datum/blood_type/water

/obj/item/organ/internal/heart/spider
	name = "spider heart"
	heart_bloodtype = /datum/blood_type/spider
