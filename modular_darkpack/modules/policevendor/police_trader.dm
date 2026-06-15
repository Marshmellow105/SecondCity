/mob/living/basic/trader/policereq
	name = "Requisitions Dave"
	desc = "Good old Dave, the one stop shop for top cops."
	speak_emote = list("demands")
	mob_biotypes = MOB_UNDEAD|MOB_HUMANOID
	gender = MALE
	spawner_path = /obj/effect/mob_spawn/corpse/human/skeleton/policereq
	loot = list(/obj/effect/decal/remains/human)
	ranged_attack_casing = /obj/item/ammo_casing/a75
	held_weapon_visual = /obj/item/gun/ballistic/automatic/gyropistol
	trader_data_path = /datum/trader_data/policereq

/obj/effect/mob_spawn/corpse/human/skeleton/policereq
	mob_species = /datum/species/skeleton
	outfit = /datum/outfit/job/vampire/police_officer
