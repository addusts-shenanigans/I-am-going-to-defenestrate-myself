//syndicate derelict dreadnought

//a cruiser of similar uses to the Starfury, basically a forgotten ship mk2

//only people left onboard are the Captain and a small crew, who are meant to try and re-secure the ship. this is impeded by a bunch of malfunctioning repair drones, major hull damage, and only one proper spacesuit
//explorers may decide to interfere either for better or worse

/obj/effect/mob_spawn/ghost_role/human/syndicate/dreadnought
	name = "syndicate stasis sleeper"
	desc = "A rugged stasis sleeper used by the Syndicate to protect against almost all hazards for long times."
	you_are_text = "You are a crew member aboard the Gorlex Marauders dreadnought 'Defiant'."
	flavour_text = "You vaguely recall fleeing into stasis as your ship was bombarded by fire from a Nanotrasen cruiser. With Nanotrasen presence in the system declining, it's time to pick up the pieces. Listen to your ship's Captain; for they will have a plan."
	important_text = "DO NOT approach Nanotrasen territory, lest you doom your entire ship! Follow orders from the Captain."
	prompt_name = "a dreadnought crewmember"
	spawner_job_path = /datum/job/lavaland_syndicate/space
	outfit = /datum/outfit/syndicate_empty/dreadnought

/obj/effect/mob_spawn/ghost_role/human/syndicate/dreadnought/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, TRUE, TRUE, LANGUAGE_MIND)

/datum/outfit/syndicate_empty/dreadnought
	name = "Syndicate Dreadnought Crew Member"
	uniform = /obj/item/clothing/under/syndicate/camo
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	mask = /obj/item/clothing/mask/gas/syndicate
	l_pocket = /obj/item/gun/ballistic/automatic/pistol
	box = /obj/item/storage/box/survival/syndie

/obj/effect/mob_spawn/ghost_role/human/syndicate/dreadnought/surgeon
	you_are_text = "You are the ship's surgeon of the Gorlex Marauders dreadnought 'Defiant'."
	flavour_text = "You volunteered to stay behind along with the Captain to rebuild the ship and help the crew when the coast was clear; and now, that time has arrived."
	important_text = "Keep the crew alive and well, follow the Captain's orders, and do not abandon ship!"
	prompt_name = "a dreadnought surgeon"
	outfit = /datum/outfit/syndicate_empty/dreadnought/surgeon

/datum/outfit/syndicate_empty/dreadnought/surgeon
	name = "Syndicate Dreadnought Surgeon"
	uniform = /obj/item/clothing/under/syndicate/scrubs
	suit = /obj/item/clothing/suit/toggle/labcoat/interdyne
	backpack_contents = list(
		/obj/item/storage/medkit/surgery = 1,
	)

/obj/effect/mob_spawn/ghost_role/human/syndicate/dreadnought/guard
	you_are_text = "You are the security guard of the Gorlex Marauders dreadnought 'Defiant'."
	flavour_text = "You were ordered to stay behind to enforce the Captain's rule when it was time to rebuild, and stay behind you did. Protect the ship and its crew, and enforce the Captain's will!"
	important_text = "Enforce the Captain's orders, and do not abandon ship!"
	prompt_name = "a dreadnought security guard"
	outfit = /datum/outfit/syndicate_empty/dreadnought/guard

/datum/outfit/syndicate_empty/dreadnought/guard
	name = "Syndicate Dreadnought Guard"
	suit = /obj/item/clothing/suit/armor/vest
	suit_store = /obj/item/gun/ballistic/shotgun/riot/sol/evil
	backpack_contents = list(
		/obj/item/storage/box/lethalshot = 1,
		/obj/item/storage/box/rubbershot = 2,
	)
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/swat

/obj/effect/mob_spawn/ghost_role/human/syndicate/dreadnought/engineer
	you_are_text = "You are an engineer onboard the Gorlex Marauders dreadnought 'Defiant'."
	flavour_text = "You chose to stay behind when the ship was going down in order to rebuild at a later date. Now, it's time to get to work."
	important_text = "Obey the orders of the Captain, and DO NOT approach Nanotrasen territory under any circumstances!"
	prompt_name = "a dreadnought engineer"
	outfit = /datum/outfit/syndicate_empty/dreadnought/engineer

/datum/outfit/syndicate_empty/dreadnought/engineer
	name = "Syndicate Dreadnought Engineer"
	suit = /obj/item/clothing/suit/hazardvest
	head = /obj/item/clothing/head/utility/hardhat
	belt = /obj/item/storage/belt/utility/syndicate

/obj/effect/mob_spawn/ghost_role/human/syndicate/dreadnought/salvager
	you_are_text = "You are a salvager onboard the Gorlex Marauders dreadnought 'Defiant'."
	flavour_text = "After helping most of the crew evacuate when the ship was going down, you stayed behind along with a small group of crew to rebuild the ship at a later date. Now, that time has come. Dismantle ruins and mine asteroids to repair the Dreadnought at any cost."
	important_text = "Obey the orders of the Captain, and DO NOT approach Nanotrasen territory under any circumstances!"
	prompt_name = "a dreadnought salvager"
	outfit = /datum/outfit/syndicate_empty/dreadnought/salvager

/datum/outfit/syndicate_empty/dreadnought/salvager
	name = "Syndicate Dreadnought Salvager"
	suit = /obj/item/clothing/suit/space/syndicate/black/engie
	head = /obj/item/clothing/head/helmet/space/syndicate/black/engie
	suit_store = /obj/item/tank/internals/oxygen
	back = /obj/item/storage/backpack/industrial/frontier_colonist
	belt = /obj/item/storage/belt/utility/syndicate
	backpack_contents = list(
		/obj/item/crowbar/power/syndicate = 1,
		/obj/item/gps/engineering = 1, //they're the DEDICATED ruin guy
	)

/obj/effect/mob_spawn/ghost_role/human/syndicate/dreadnought/captain
	name = "regal syndicate stasis sleeper"
	desc = "A rugged, heavily-reinforced stasis sleeper with some fancy engravings on it used by ranking Syndicate officers."
	you_are_text = "You are the captain of the Defiant, a dreadnought operated by the Gorlex Marauders."
	flavour_text = "Nanotrasen nearly destroyed your ship, but you managed to freeze some of the crew until Nanotrasen presence finally started to wane. Now, it's time to rebuild the Defiant."
	important_text = "The ship must survive. Do not allow anyone to go near Nanotrasen territory. Enforce your will with an iron fist; lest your ship rot in the void."
	prompt_name = "the captain of the Defiant"
	outfit = /datum/outfit/syndicate_empty/dreadnought/captain

/datum/outfit/syndicate_empty/dreadnought/captain
	name = "Syndicate Dreadnought Captain"
	uniform = /obj/item/clothing/under/syndicate/sniper
	head = /obj/item/clothing/head/hats/hos/cap/syndicate
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	ears = /obj/item/radio/headset/syndicate/alt/leader
	mask = /obj/item/clothing/mask/gas/chameleon
	l_pocket = /obj/item/melee/energy/sword/saber/red
	backpack_contents = list(
		/obj/item/folder/syndicate/red,
		/obj/item/gun/ballistic/revolver/mateba,
		/obj/item/megaphone/sec,
	)
	accessory = /obj/item/clothing/accessory/medal/gold
	id_trim = /datum/id_trim/chameleon/operative/nuke_leader //he needs the extra access


// areas
/area/shuttle/ruin/syndicate_dreadnought
	name = "Syndicate Dreadnought 'Defiant'"

/area/shuttle/ruin/syndicate_dreadnought/security
	name = "Syndicate Dreadnought 'Defiant' Security"

/area/shuttle/ruin/syndicate_dreadnought/bridge
	name = "Syndicate Dreadnought 'Defiant' Bridge"

/area/shuttle/ruin/syndicate_dreadnought/crew
	name = "Syndicate Dreadnought 'Defiant' Crew Quarters"

/area/shuttle/ruin/syndicate_dreadnought/engineering
	name = "Syndicate Dreadnought 'Defiant' Engineering"

/area/shuttle/ruin/syndicate_dreadnought/engineering/atmos
	name = "Syndicate Dreadnought 'Defiant' Life Support"

/area/shuttle/ruin/syndicate_dreadnought/engineering/engine
	name = "Syndicate Dreadnought 'Defiant' Engine Core"

/area/shuttle/ruin/syndicate_dreadnought/eva_locker
	name = "Syndicate Dreadnought 'Defiant' EVA Lockup"

/area/shuttle/ruin/syndicate_dreadnought/medical
	name = "Syndicate Dreadnought 'Defiant' Infirmary"

/area/shuttle/ruin/syndicate_dreadnought/mess_hall
	name = "Syndicate Dreadnought 'Defiant' Mess Hall"

/area/shuttle/ruin/syndicate_dreadnought/munitions
	name = "Syndicate Dreadnought 'Defiant' Munitions Bay"

/area/shuttle/ruin/syndicate_dreadnought/vault
	name = "Syndicate Dreadnought 'Defiant' Vault"

/area/shuttle/ruin/syndicate_dreadnought/mining
	name = "Syndicate Dreadnought 'Defiant' Salvage Bay"

/area/shuttle/ruin/syndicate_dreadnought/marine_launchbay
	name = "Syndicate Dreadnought 'Defiant' Boarder Launch Bay"

/area/shuttle/ruin/syndicate_dreadnought/hallway
	name = "Syndicate Dreadnought 'Defiant' Hallway"

/area/shuttle/ruin/syndicate_dreadnought/hallway/fore
	name = "Syndicate Dreadnought 'Defiant' Fore Hallway"

/area/shuttle/ruin/syndicate_dreadnought/hallway/aft
	name = "Syndicate Dreadnought 'Defiant' Aft Hallway"

/area/shuttle/ruin/syndicate_dreadnought/docking
	name = "Syndicate Dreadnought 'Defiant' Docking Bay"

/area/shuttle/ruin/syndicate_dreadnought/cargo
	name = "Syndicate Dreadnought 'Defiant' Cargo Bay"

/area/shuttle/ruin/syndicate_dreadnought/escape_pod
	name = "Syndicate Dreadnought 'Defiant' Escape Pod Bay"

/area/shuttle/ruin/syndicate_dreadnought/emergency_storage
	name = "Syndicate Dreadnought 'Defiant' Emergency Storage"

/obj/item/circuitboard/computer/syndicate_dreadnought_helm
	name = "Syndicate Dreadnought Helm circuitboard"
	build_path = /obj/machinery/computer/shuttle/syndicate_dreadnought

/obj/item/circuitboard/computer/syndicate_dreadnought_nav
	name = "Syndicate Dreadnought Navigation Computer circuitboard"
	build_path = /obj/machinery/computer/camera_advanced/shuttle_docker/syndicate_dreadnought

/obj/machinery/computer/shuttle/syndicate_dreadnought
	name = "Syndicate Dreadnought Helm Console"
	desc = "The primary helm console of the Gorlex Marauders dreadnought 'Defiant'."
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = COLOR_SOFT_RED
	req_access = list(ACCESS_SYNDICATE)
	circuit = /obj/item/circuitboard/computer/syndicate_dreadnought_helm
	shuttleId = "syndicate_dreadnought"
	possible_destinations = "syndicate_dreadnought_custom;syndicate_dreadnought_deepspace" //its a big fucking boat, its not gonna fit anywhere else

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate_dreadnought
	name = "Syndicate Dreadnought Navigation Computer"
	desc = "Used to designate a precise transit location for the Gorlex Marauders dreadnought 'Defiant'."
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	shuttleId = "syndicate_dreadnought"
	lock_override = NONE
	circuit = /obj/item/circuitboard/computer/syndicate_dreadnought_nav
	shuttlePortId = "syndicate_dreadnought_custom"
	jump_to_ports = list("syndicate_dreadnought_deepspace" = 1, "caravansyndicate1_ambush" = 1, "syndicate_listening_post" = 1, "whiteship_z4" = 1, "whiteship_waystation" = 1) //KC13 and the waystation are locations the syndicate would know about and contain valuable materials. if they want to get into a verbal argument with the drones so be it
	view_range = 10
	x_offset = 0
	y_offset = 0

/obj/item/circuitboard/computer/terminal/syndicate_dreadnought
	name = "Log Computer Circuitboard"
	build_path = /obj/machinery/computer/terminal/syndicate_dreadnought

/obj/machinery/computer/terminal/syndicate_dreadnought
	name = "'Defiant' log computer"
	desc = "The log computer of the Defiant. Error messages are burnt into most of its screen, but a small part remains readable."
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = COLOR_SYNDIE_RED
	upperinfo = "Dreadnought 'Defiant' Logs Computer"
	content = list("<center><b>Defiant<BR><BR><BR>CAPTAIN'S LOG</b><BR><BR>Showing entries 82 to 92.<BR><BR><BR><b>Due to system damage, new entries cannot be added at this time.</b></center> <br> <br> <b>ENTRY 92</b> <br> ill write this later <br> <br> <b>ENTRY 91</b> <br> ill write this later  <br> <br> <b>ENTRY 90</b> <br> ill write this later <br> <br> <b>ENTRY 89</b> <br> ill write this later <br> <br> <b>ENTRY 88</b> <br> ill write this later <br> <br> <b>ENTRY 87</b> <br> ill write this later <br> <br> <b>ENTRY 86</b> <br> ill write this later <br> <br> <b>ENTRY 85</b> <br> ill write this later <br> <br> <b>ENTRY 84</b> <br> ill write this later <br> <br> <b>ENTRY 83</b> <br> ill write this later <br> <br> <b>ENTRY 82</b> <br> ill write this later")

/datum/preset_holoimage/syndicate_comms
	outfit_type = /datum/outfit/syndicatecommandocorpse/lessenedgear/listeningpost

/datum/preset_holoimage/syndicate_dreadnought_surgeon
	outfit_type = /datum/outfit/syndicate_empty/dreadnought/surgeon

/datum/preset_holoimage/syndicate_dreadnought_captain
	outfit_type = /datum/outfit/syndicate_empty/dreadnought/captain

/datum/preset_holoimage/syndicate_marine
	outfit_type = /datum/outfit/syndicatecommandocorpse

/datum/preset_holoimage/syndicate_operative
	outfit_type = /datum/outfit/syndicatesoldiercorpse

/datum/preset_holoimage/syndicate_agent
	outfit_type = /datum/outfit/syndicate_empty //just a dude

/datum/preset_holoimage/syndicate_engineer
	outfit_type = /datum/outfit/syndicate_empty/dreadnought/engineer //we engineerin this bitch


/obj/item/disk/holodisk/ruin/syndicate_dreadnought
	name = "'Defiant' Blackbox Printout"
	desc = "A disk automatically printed out by the black-box system of the 'Defiant', a Syndicate dreadnought."
	preset_image_type = /datum/preset_holoimage/syndicate_agent
	preset_record_text = {"
		NAME Assistant Operative Petrov
		SAY We're taking some damage here, what's the situation boss?
		DELAY 25
		NAME Dreadnought Captain
		PRESET /datum/preset_holoimage/syndicate_dreadnought_captain
		SAY NT's got radar contact on us. We're being pounded by shells from every side.
		DELAY 40
		NAME Ship Computer
		PRESET /datum/preset_holoimage/ai
		SAY WARNING: RADAR LOCK DETECTED. EVACUATE THE BRIDGE.
		DELAY 20
		NAME First Officer Ivan
		PRESET /datum/preset_holoimage/syndicate_comms
		SAY SHIT! RUN!
		DELAY 15
		SOUND explosion
		DELAY 15
		NAME Syndicate Marine Johnson
		PRESET /datum/preset_holoimage/syndicate_marine
		SAY CAPTAIN! ARE YOU ALRIGHT?
		DELAY 30
		NAME Dreadnought Captain
		PRESET /datum/preset_holoimage/syndicate_dreadnought_captain
		SAY I... Think I am. Johnson, get unneeded crew to the pods. Ivan, call everyone else to the mess hall.
		DELAY 30
		NAME First Officer Ivan
		PRESET /datum/preset_holoimage/syndicate_comms
		SAY Will do. Johnson, get going.
		DELAY 10
		SOUND explosion_creaking
		DELAY 10
		NAME Syndicate Engineer Mcclymonds
		PRESET /datum/preset_holoimage/syndicate_engineer
		SAY SIR! THE SUPERMATTER GOT HIT!
		DELAY 20
		NAME Dreadnought Captain
		PRESET /datum/preset_holoimage/syndicate_dreadnought_captain
		SAY Go hit the bloody ejector! I'll get on the intercom!
		DELAY 10
		NAME Syndicate Engineer Mcclymonds
		PRESET /datum/preset/holoimage/syndicate_engineer
		SAY AYE AYE!
		DELAY 20
		NAME Ship Computer
		PRESET /datum/preset_holoimage/ai
		SAY Attention crew: Incoming announcement from the Captain.
		DELAY 20
		NAME Dreadnought Captain
		PRESET /datum/preset_holoimage/syndicate_dreadnought_captain
		SAY Alright gents, we've had it. However, the fight is not over. One of the medics, all marines, and one of the guards are authorised to flee via the escape pod, as well as any prisoners.
		DELAY 20
		SAY Everyone else is to head to their cryogenic sleepers in the crew quarters and freeze up as soon as evacuation is complete. I'll shut off the power and we'll pretend to be a derelict.
		DELAY 20
		SAY Your families will know you survived. Death to Nanotrasen.
		SOUND explosion_creaking
		SAY ...Shit, there goes munitions.
		DELAY 10
		SAY As I was saying, get everyone who isn't staying out then get into stasis.
		DELAY 20
		NAME Ship Computer
		PRESET /datum/preset_holoimage/ai
		SAY Escape pod launch authorised by order of the Captain.
		DELAY 50
		SAY Escape pod launch success.
		DELAY 15
		NAME Ship's Surgeon
		PRESET /datum/preset_holoimage/syndicate_dreadnought_surgeon
		SAY You know, these sleepers aren't designed for this.
		DELAY 25
		NAME Dreadnought Captain
		PRESET /datum/preset_holoimage/syndicate_dreadnought_captain
		SAY How come?
		DELAY 20
		NAME Ship's Surgeon
		PRESET /datum/preset_holoimage/syndicate_dreadnought_surgeon
		SAY These models don't have anything to account for memory loss.
		DELAY 10
		SAY We'll barely have half a clue where we were. You'll have to leave something useful in the log.
		DELAY 25
		NAME Dreadnought Captain
		PRESET /datum/preset_holoimage/syndicate_dreadnought_captain
		SAY I'll see about it. Go to your sleeper, I'll tell the system to start draining the batteries. Make sure they don't see us as a signature.
		DELAY 20
		NAME Ship's Surgeon
		PRESET /datum/preset_holoimage/syndicate_dreadnought_surgeon
		NAME Aye aye.
		DELAY 10
		NAME Ship Computer
		PRESET /datum/preset_holoimage/ai
		SAY Draining reserve power...
		DELAY 60
		SAY Reserve power at 15%. Preparing to freeze personnel...
		DELAY 10
		SAY Warning. Incoming signature detect-
		DELAY 5
		SOUND explosion_creaking
		DELAY 5
		SAY Hull breach detected in cargo bay. Hallway compromised.
		DELAY 25
		SAY Cryogenic stasis systems engaging. Release timer set to: 30 years.
		DELAY 30
		PRESET /datum/preset_holoimage/corgi
		NAME Blackbox Automated Message
		SAY Power depleted. Saving audio logs to disk...
		DELAY 50
	"}
