/datum/trader_data/policereq
	shop_spot_type = /obj/structure/chair/office/darkpack/blue
	sign_type = null
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

//tome
	initial_wanteds = list(
		/obj/item/fake_items/time_stopper/no_anchor = list(PAYCHECK_CREW * 40, INFINITY, "Good work killing that wizard"),
		/obj/item/fake_items/wabbajack/no_anchor = list(PAYCHECK_CREW * 40, INFINITY, "Good work killing that wizard"),
		/obj/item/fake_items/abductor_win_stick/no_anchor = list(PAYCHECK_CREW * 40, INFINITY, "Good work killing that wizard"),
		/obj/item/clothing/head/collectable/paper = list(PAYCHECK_CREW * 40, INFINITY, "Good work killing that wizard"),
		/obj/item/clothing/suit/wizrobe/paper = list(PAYCHECK_CREW * 40, INFINITY, "Good work killing that wizard"),
		/obj/item/gun/magic/wand/disabler = list(PAYCHECK_CREW * 40, INFINITY, "Good work retriving the relic"),
		/obj/item/boulder/true_boulder = list(PAYCHECK_CREW * 40, INFINITY, "Good work retriving the relic"),
		/obj/item/gun/magic/wand/fireball/inert = list(PAYCHECK_CREW * 40, INFINITY, "Good work retriving the relic"),
		/obj/item/scanner_wand = list(PAYCHECK_CREW * 40, INFINITY, "Good work retriving the relic"),
		/obj/item/gun/magic/wand/resurrection/inert = list(PAYCHECK_CREW * 40, INFINITY, "Good work retriving the relic"),
		/obj/item/soulstone = list(PAYCHECK_CREW * 40, INFINITY, "Good work retriving the relic"),
		/obj/item/soulstone/anybody = list(PAYCHECK_CREW * 5, 1, "Good work retriving the con- oh, i recognize this, ill see if i can scramble a team for the station"),//to-do, spawn a red alert security ert if this item is sold
		/obj/item/soulstone/anybody/chaplain = list(PAYCHECK_CREW * 5, INFINITY, "Good work retriving the relic"),
		/obj/item/soulstone/anybody/chaplain/sparring = list(PAYCHECK_CREW * 5, INFINITY, "Good work retriving the relic"),
		/obj/item/soulstone/anybody/mining = list(PAYCHECK_CREW * 5, INFINITY, "Good work retriving the relic"),
		/obj/item/soulstone/anybody/purified = list(PAYCHECK_CREW * 10, INFINITY, "Good work retriving the relic"),
		/obj/item/soulstone/anybody/revolver = list(PAYCHECK_CREW * 5, INFINITY, "Good work retriving the relic"),
		/obj/item/soulstone/mystic = list(PAYCHECK_CREW * 5, INFINITY, "Good work retriving the relic"),
		/obj/item/guardian_creator/miner = list(PAYCHECK_CREW * 5, INFINITY, "Good work retriving the relic"),
		/obj/item/guardian_creator/wizard = list(PAYCHECK_CREW * 5, INFINITY, "Good work retriving the relic"),
		/obj/item/guardian_creator/carp = list(PAYCHECK_CREW * 5, INFINITY, "Good work retriving the relic"),
		/obj/item/card/emag = list(PAYCHECK_CREW * 20, INFINITY, "Good work retriving the contraband"),
		/obj/item/card/emag/doorjack = list(PAYCHECK_CREW * 20, INFINITY, "Good work retriving the contraband"),
		/obj/item/card/emag/battlecruiser = list(PAYCHECK_CREW * 20, INFINITY, "Good work retriving the con- oh, i recognize this, ill see if i can scramble a team for the station"),//to-do, spawn a red alert security ert if this item is sold
		/obj/item/disk/nuclear/fake = list(PAYCHECK_CREW * 20, INFINITY, "Good work retriving the contraband, hard to tell these apart."),
		/obj/item/gun/ballistic/revolver/badass = list(PAYCHECK_CREW * 20, INFINITY, "Good work retriving the contraband"),
		/obj/item/crowbar/power/syndicate = list(PAYCHECK_CREW * 20, INFINITY, "Good work retriving the contraband"),
		/obj/item/documents/syndicate = list(PAYCHECK_CREW * 5, INFINITY, "sorry but these are out-dated, we cant gleem much from this"),
		/obj/item/documents/syndicate/blue = list(PAYCHECK_CREW * 50, INFINITY, "hope you didnt look over these, here take some extra"),
		/obj/item/documents/syndicate/red = list(PAYCHECK_CREW * 50, INFINITY, "hope you didnt look over these, here take some extra"),
		/obj/item/documents/syndicate/mining = list(PAYCHECK_CREW * 5, INFINITY, "sorry but these are out-dated, we cant gleem much from this"),
		/obj/item/gun/ballistic/rifle/sniper_rifle/syndicate = list(PAYCHECK_CREW * 60, INFINITY, "Well ho-lee-shit *whistles* a nice point fifty sniper rifle, ill be- taking that."),//to-do, make it appear on his back after purchasing this
		/obj/item/mod/control/pre_equipped/empty/syndicate = list(PAYCHECK_CREW * 20, INFINITY, "Good work retriving the contraband"),
		/obj/item/storage/toolbox/syndicate = list(PAYCHECK_CREW * 5, INFINITY, "Good work retriving the contraband"),
		/obj/item/toy/cards/deck/syndicate = list(PAYCHECK_CREW * 1, INFINITY, "this is not- really contraband, but ill take it anyhow"),
		/obj/item/syndicate_teleporter = list(PAYCHECK_CREW * 5, INFINITY, "Good work retriving the contraband"),
		/obj/item/encryptionkey/syndicate = list(PAYCHECK_CREW * 5, INFINITY, "Good work retriving the contraband"),
		/obj/item/clothing/suit/space/syndicate/black/red = list(PAYCHECK_CREW * 5, INFINITY, "Good work retriving the contraband"),
		/obj/item/clothing/head/helmet/space/syndicate/black/red = list(PAYCHECK_CREW * 5, INFINITY, "Good work retriving the contraband"),
		/obj/item/gun/ballistic/automatic/pistol/contraband = list(PAYCHECK_CREW * 10, INFINITY, "Good work retriving the contraband"),
		/obj/item/gun/ballistic/rifle/rebarxbow/syndie = list(PAYCHECK_CREW * 10, INFINITY, "Good work retriving the contraband"),
		/obj/item/mod/control/pre_equipped/traitor = list(PAYCHECK_CREW * 10, INFINITY, "Good work retriving the contraband"),
		/obj/item/mod/control/pre_equipped/traitor_elite = list(PAYCHECK_CREW * 20, INFINITY, "Good work retriving the contraband"),
		/obj/item/melee/energy/sword = list(PAYCHECK_CREW * 20, INFINITY, "Good work retriving the contraband"),
		/obj/item/melee/energy/axe = list(PAYCHECK_CREW * 100, INFINITY, "How the fuck- whatever, here is your money"),
		/obj/item/dualsaber = list(PAYCHECK_CREW * 20, INFINITY, "Good work retriving the contraband"),
		/obj/item/dualsaber/red = list(PAYCHECK_CREW * 20, INFINITY, "Good work retriving the contraband"),
		/obj/effect/fun_balloon = list(PAYCHECK_CREW * 0, INFINITY, "Why would i care about a red balloon with an S on it?!"),
		/obj/item/nuke_core = list(PAYCHECK_CREW * 40, INFINITY, "*he puts his hands up shielding himself from the plutonium rock* OH MY GOD WHY DID YOU BRING ME THIS THING?! *he then seems to remember that his suit is radiation proof to which he snatches it out of your hand*"),
		/obj/item/melee/supermatter_sword = list(PAYCHECK_CREW * 200, INFINITY, "*he stares at you completely silent for what feels like two minutes* W-Well- that is, an interesting product of your stations rnd- ill just be taking that."),
		/obj/item/melee/cultblade/haunted = list(PAYCHECK_CREW * 20, 1, "Good work retriving the cont- oh, this is specialized nar'si equipment... ill send a team over to the station"),//to-do, spawn a red alert inquisition ert if this item is sold
		/obj/item/seeds/kudzu = list(PAYCHECK_CREW * 20, INFINITY, "Good work retriving the contraband"),
	)

	say_phrases = list(
		ITEM_REJECTED_PHRASE = list(
			"Sorry, I'm not a fan of anything you're showing me. Give me something better and we'll talk.",
		),
		ITEM_SELLING_CANCELED_PHRASE = list(
			"What a shame, tell me if you changed your mind.",
		),
		ITEM_SELLING_ACCEPTED_PHRASE = list(
			"Pleasure doing business with you, if you give me enough i could talk to some people, maybe get you a promotion.",
		),
		INTERESTED_PHRASE = list(
			"Hey, you've got an item that interests me, I'd like to buy it, I'll give you some cash for it, deal?",
		),
		BUY_PHRASE = list(
			"Enjoy the extra credits sl- i mean, valued and appriciated employee",
		),
		NO_CASH_PHRASE = list(
			"Sorry wagie, Come back when you're a little mmmmm... richer!",
		),
		NO_STOCK_PHRASE = list(
			"I'm only giving out one of each of these things, thats all im permitted to do- except whetstones.",
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
			"Hello valuable employee, to the north of us we have located a large concentration of wizards! I'm not gonna sugarcoat it, go kill them, and when one of them drops something magical, bring it to me, or bring me any contraband station side and ill buy it off ya.",
			"Hello valuable employee, to the north of us we have located a large concentration of wizards! I'm not gonna sugarcoat it, go kill them, and when one of them drops something magical, bring it to me, or bring me any contraband station side and ill buy it off ya.",
			"Hello wagie, to the north of us we have located a large concentration of wizards! I'm not gonna sugarcoat it, go kill them, and when one of them drops something magical, bring it to me, or bring me any contraband station side and ill buy it off ya.",
			"Hello SLAVE, to the north of us we have located a large concentration of wizards! I'm not gonna sugarcoat it, go kill them, and when one of them drops something magical, bring it to me, or bring me any contraband station side and ill buy it off ya.",
		),
		TRADER_NOT_BUYING_ANYTHING = list(
			"You got nothing i can pay for.",
		),
		TRADER_NOT_SELLING_ANYTHING = list(
			"I'm currently selling nothing at the moment.",
		),
		TRADER_BATTLE_START_PHRASE = list(
			"IM GOING TO DEMOTE YOU OVER THIS!",
		),
		TRADER_BATTLE_END_PHRASE = list(
			"Eh whatever, theyll just be cloned again and forget this, im putting this on their internal record however.",
		),
		TRADER_SHOP_OPENING_PHRASE = list(
			"Its simple, go north, get artifacts, sell them to me, go to the station, get contraband, sell it to me.",
		),
	)
