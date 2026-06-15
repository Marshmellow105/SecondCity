/mob/living/basic/trader/policereq
	name = "Requisitions Dave"
	desc = "Good old Dave, the one stop shop for top cops."
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	gender = MALE
	ai_controller = /datum/ai_controller/basic_controller/trader/jumpscare
	sell_sound = 'sound/items/equip/headset_equip2.ogg'
	species_path = /datum/species/human
	spawner_path = /obj/effect/mob_spawn/corpse/human/policereq
	loot = list(/obj/effect/decal/remains/human)

	trader_data_path = /datum/trader_data/policereq

/datum/trader_data/policereq
	shop_spot_type = /obj/structure/chair/office/darkpack/blue
	sign_type = /obj/structure/trader_sign/policereq
	sell_sound = 'sound/items/equip/headset_equip2.ogg'

	initial_products = list(
		/obj/item/clothing/under/vampire/police = list(PAYCHECK_CREW, INFINITY),
		/obj/item/clothing/under/vampire/police/long = list(PAYCHECK_CREW, INFINITY),
		/obj/item/clothing/under/vampire/police/turtleneck = list(PAYCHECK_CREW, INFINITY),
		/obj/item/clothing/under/vampire/police/pants = list(PAYCHECK_CREW, INFINITY),
		/obj/item/clothing/under/vampire/police/utility = list(PAYCHECK_CREW, INFINITY),
		/obj/item/clothing/head/vampire/police = list(PAYCHECK_CREW, INFINITY),
		/obj/item/clothing/head/vampire/helmet = list(PAYCHECK_CREW, INFINITY),
		/obj/item/clothing/suit/vampire/vest/police = list(PAYCHECK_CREW, INFINITY),
		/obj/item/storage/belt/holster/detective/darkpack = list(PAYCHECK_CREW, INFINITY),
		/obj/item/storage/belt/security/police = list(PAYCHECK_CREW, INFINITY),

		/obj/item/camera/detective = list(PAYCHECK_CREW, INFINITY),
		/obj/item/taperecorder = list(PAYCHECK_CREW, INFINITY),
		/obj/item/toy/crayon/white = list(PAYCHECK_CREW, INFINITY),
		/obj/item/storage/box/evidence = list(PAYCHECK_CREW, INFINITY),
		/obj/item/flashlight/seclite = list(PAYCHECK_CREW, INFINITY),
		/obj/item/detective_scanner/darkpack = list(PAYCHECK_CREW, INFINITY),
		/obj/item/binoculars = list(PAYCHECK_CREW, INFINITY),
		/obj/item/storage/box/bodybags = list(PAYCHECK_CREW, INFINITY),
		/obj/item/restraints/handcuffs = list(PAYCHECK_CREW, INFINITY),
		/obj/item/storage/medkit/darkpack/ifak = list(PAYCHECK_CREW, INFINITY),

		/obj/item/radio/headset/darkpack/police = list(PAYCHECK_CREW, INFINITY),

		/obj/item/gun/energy/taser/darkpack = list(PAYCHECK_CREW, INFINITY),
		/obj/item/reagent_containers/spray/pepper = list(PAYCHECK_CREW, INFINITY),
		/obj/item/melee/baton/vamp = list(PAYCHECK_CREW, INFINITY),
		/obj/item/gun/ballistic/automatic/pistol/darkpack/glock19 = list(PAYCHECK_CREW, INFINITY),
		/obj/item/ammo_box/magazine/glock9mm = list(PAYCHECK_CREW, INFINITY),
	)

	initial_wanteds = list(
		/obj/item/reagent_containers/condiment/milk = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/stack/sheet/bone = list(PAYCHECK_CREW * 8.4, INFINITY, ", per sheet of bone"),
	)

	say_phrases = list(
		ITEM_REJECTED_PHRASE = list(
			"Sorry, I'm not a fan of anything you're showing me. Give me something better and we'll talk.",
		),
		ITEM_SELLING_CANCELED_PHRASE = list(
			"What a shame, tell me if you changed your mind.",
		),
		ITEM_SELLING_ACCEPTED_PHRASE = list(
			"Pleasure doing business with you.",
		),
		INTERESTED_PHRASE = list(
			"Hey, you've got an item that interests me, I'd like to buy it, I'll give you some cash for it, deal?",
		),
		BUY_PHRASE = list(
			"Bone appetit!",
		),
		NO_CASH_PHRASE = list(
			"Sorry adventurer, I can't give credit! Come back when you're a little mmmmm... richer!",
		),
		NO_STOCK_PHRASE = list(
			"Sorry adventurer, but that item is not in stock at the moment.",
		),
		NOT_WILLING_TO_BUY_PHRASE = list(
			"I don't want to buy that item for the time being, check back another time.",
		),
		ITEM_IS_WORTHLESS_PHRASE = list(
			"This item seems to be worthless on a closer look, I won't buy this.",
		),
		TRADER_HAS_ENOUGH_ITEM_PHRASE = list(
			"I already bought enough of this for the time being.",
		),
		TRADER_LORE_PHRASE = list(
			"Hello, I am Mr. Bones!",
			"The ride never ends!",
			"I'd really like a refreshing carton of milk!",
			"I'm willing to play big prices for BONES! Need materials to make merch, eh?",
			"It's a beautiful day outside. Birds are singing, Flowers are blooming... On days like these, kids like you... Should be buying my wares!",
		),
		TRADER_NOT_BUYING_ANYTHING = list(
			"I'm currently buying nothing at the moment.",
		),
		TRADER_NOT_SELLING_ANYTHING = list(
			"I'm currently selling nothing at the moment.",
		),
		TRADER_BATTLE_START_PHRASE = list(
			"The ride ends for you!",
		),
		TRADER_BATTLE_END_PHRASE = list(
			"Mr. Bones never misses!",
		),
		TRADER_SHOP_OPENING_PHRASE = list(
			"My wild ride is open!",
		),
	)

// trader sign
/obj/structure/trader_sign/policereq
	icon_state = "sign"

// spawner for outfit
/obj/effect/mob_spawn/corpse/human/policereq
	mob_species = /datum/species/human
	outfit = /datum/outfit/job/vampire/police_officer
