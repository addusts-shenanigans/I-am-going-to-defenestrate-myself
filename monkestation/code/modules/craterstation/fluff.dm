// Fluff objects relating to CraterStation

/obj/item/paper/crumpled/craterstation

/obj/item/paper/crumpled/craterstation/workers_camp
	default_raw_text = "Alright, if you stop by for supplies after the main base is set up; it's southwest. I left a spare set of winter gear in the locker. Make sure to go on the surface, we're not sure what's underground."

/obj/item/paper/crumpled/craterstation/mulebot_lost
	default_raw_text = "One of the whiteouts knocked out the Mulebot sent to keep the worker's camp supplied. We were planning to move them to the bunkhouse inside the base anyway, and they have enough food to last until then, but someone should go and retrieve the bot before it breaks down for good."

/obj/item/paper/crumpled/craterstation/medbay_stasis
	default_raw_text = "Sorry we couldn't finish the stasis unit during fitting-out. We got the boards late since RnD still isn't up, and we're pretty strained out here."

/obj/item/paper/crumpled/craterstation/remember_us
	default_raw_text = "Everything's ready. Finally. Command crews, if you read this, remember our labours well. We fought to build this place against the cold, and we won."

/obj/item/paper/crumpled/craterstation/generator_blowout
	default_raw_text = "John noticed some pressure irregularities in the generator's main burn chamber, so we're preparing to reduce power in order to do a maintenance check. Hopefully we'll- *The writing past here is practically unreadable, seemingly affected by some sort of seismic event - or an explosion.*"

//custom corpse - Constructor

/obj/effect/mob_spawn/corpse/human/crater_constructor
	name = "Construction Worker"
	outfit = /datum/outfit/constructor

/datum/outfit/constructor
	name = "Frozen Construction Worker (Empty Internals)"
	ears = /obj/item/radio/headset
	uniform = /obj/item/clothing/under/rank/engineering/engineer/hazard
	suit = /obj/item/clothing/suit/hooded/wintercoat
	shoes = /obj/item/clothing/shoes/workboots
	neck = /obj/item/flashlight/lantern/rayne //haha frostpunk go brrrrrrrrrrrrrrrr
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/crater_engi
	back = /obj/item/storage/backpack/industrial/frontier_colonist
	l_pocket = /obj/item/pocket_heater/loaded
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double/empty //why do you think they're dead, doofus
	belt = /obj/item/storage/belt/utility/full
	head = /obj/item/clothing/head/hooded/winterhood
	box = /obj/item/storage/box/survival
	mask = /obj/item/clothing/mask/gas/explorer
	gloves = /obj/item/clothing/gloves/color/black

/datum/outfit/constructor/internals_full
	name = "Craterstation Construction Worker"
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double //for events and testing

/datum/id_trim/crater_engi
	access = list(ACCESS_EXTERNAL_AIRLOCKS, ACCESS_MAINT_TUNNELS)
	assignment = "Construction Worker"
	trim_state = "trim_stationengineer"
	department_color = CIRCUIT_COLOR_SUPPLY

/obj/structure/sign/plaques/kiddie/crater_memorial
	name = "Memorial Plaque"
	desc = "A plaque listing the names of those who died building Crater outpost. May their sacrifice forever be rememebered by those who tread its paths."


// dirt but COLD

/turf/open/misc/dirt/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

// terminals and other whatnot

/obj/machinery/computer/terminal/craterstation
	name = "control terminal"
	desc = "A terminal used to monitor certain pieces of equipment."
	tguitheme = "nanotrasen"
	content = list("No connection.")
	upperinfo = "Property of Nanotrasen."

/obj/machinery/computer/terminal/craterstation/ptl_reflector
	name = "PTL reflector control terminal"
	desc = "A terminal used to control the power transmission laser's reflector. Needs to be unlocked by Central Command; and that isn't happening while you're down here."
	tguitheme = "nanotrasen"
	content = list("<center><b>PTL CONTROL SYSTEM</b></center> <BR> Control systems are locked. Please contact Central Command if alteration is required. <BR> <BR> Laser reflector tracking relay node Eta-8, holding 33 degrees L/R and 29 degrees F/B offset.")
	upperinfo = "LASER REFLECTOR MK. 8 REMOTE CONTROL UNIT - RESTRICTED ACCESS"
