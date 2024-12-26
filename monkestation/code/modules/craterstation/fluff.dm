// Fluff objects relating to CraterStation

/obj/item/paper/crumpled/craterstation

/obj/item/paper/crumpled/craterstation/workers_camp
	default_raw_text = "Alright, if you stop by for supplies after the main base is set up; it's southwest. I left a spare set of winter gear in the locker. Make sure to go on the surface, we're not sure what's underground. -A.J."

/obj/item/paper/crumpled/craterstation/mulebot_lost
	default_raw_text = "One of the whiteouts knocked out the Mulebot sent to keep the worker's camp supplied. We were planning to move them to the bunkhouse inside the base anyway, and they have enough food to last until then, but someone should go and retrieve the bot before it breaks down for good."

/obj/item/paper/crumpled/craterstation/medbay_stasis
	default_raw_text = "Sorry we couldn't finish the stasis unit during fitting-out. We got the boards late since RnD still isn't up, and we're pretty strained out here."

//custom corpse - Constructor

/obj/effect/mob_spawn/corpse/human/crater_constructor
	name = "Construction Worker"
	outfit = /datum/outfit/constructor

/datum/outfit/constructor
	name = "Construction Worker"
	ears = /obj/item/radio/headset
	uniform = /obj/item/clothing/under/rank/engineering/engineer/hazard
	suit = /obj/item/clothing/suit/hooded/wintercoat
	shoes = /obj/item/clothing/shoes/workboots
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
	name = "Construction Worker (With Internals)"
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double //for events and testing

/datum/id_trim/crater_engi
	access = list(ACCESS_EXTERNAL_AIRLOCKS, ACCESS_MAINT_TUNNELS)
	assignment = "Construction Worker"
	trim_state = "trim_stationengineer"
	department_color = CIRCUIT_COLOR_SUPPLY
