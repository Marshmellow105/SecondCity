
/mob/living/carbon/human/canBeHandcuffed()
	if(num_hands < 2)
		return FALSE
	return TRUE

//gets assignment from ID or ID inside PDA or PDA itself
//Useful when player do something with computers
/mob/living/carbon/human/proc/get_assignment(if_no_id = "No id", if_no_job = "No job", hand_first = TRUE)
	var/obj/item/card/id/id = get_idcard(hand_first)
	if(HAS_TRAIT(src, TRAIT_UNKNOWN_APPEARANCE))
		return if_no_id
	if(id)
		. = id.assignment
	else
		var/obj/item/modular_computer/pda = wear_id
		if(istype(pda))
			. = pda.saved_job
		else
			return if_no_id
	if(!.)
		return if_no_job

//gets name from ID or ID inside PDA or PDA itself
//Useful when player do something with computers
/mob/living/carbon/human/proc/get_authentification_name(if_no_id = "Unknown")
	var/obj/item/card/id/id = get_idcard(FALSE)
	if(HAS_TRAIT(src, TRAIT_UNKNOWN_APPEARANCE))
		return if_no_id
	if(id)
		return id.registered_name
	var/obj/item/modular_computer/pda = wear_id
	if(istype(pda))
		return pda.saved_identification
	return if_no_id

/mob/living/carbon/human/get_visible_name()
	if(name_override)
		return name_override
	return get_generic_name(lowercase = TRUE)

//Returns "Unknown" if facially disfigured and real_name if not. Useful for setting name when Fluacided or when updating a human's name variable
/mob/living/carbon/human/proc/get_face_name(if_no_face = get_generic_name(lowercase = TRUE))
	if(wear_mask && (wear_mask.flags_inv & HIDEFACE)) //Wearing a mask which hides our face, use id-name if possible
		return if_no_face
	if(head && (head.flags_inv & HIDEFACE))
		return if_no_face //Likewise for hats
	var/obj/item/bodypart/O = get_bodypart(BODY_ZONE_HEAD)
	if(!O || (HAS_TRAIT(src, TRAIT_DISFIGURED)) || (O.brutestate+O.burnstate)>2 || cloneloss>50 || !real_name) //disfigured. use id-name if possible
		return if_no_face
	return real_name

/**
 * Gets whatever name is in our ID or PDA
 *
 * * if_no_id - What to return if we have no ID or PDA
 * * honorifics - Whether to include honorifics in the returned name (if the found ID has any set)
 */
/mob/living/carbon/proc/get_id_name(if_no_id = "Unknown", honorifics = FALSE)
	return

/mob/living/carbon/human/get_id_name(if_no_id = "Unknown", honorifics = FALSE)
	if(HAS_TRAIT(src, TRAIT_UNKNOWN_APPEARANCE))
		var/list/identity = list(null, null, null)
		SEND_SIGNAL(src, COMSIG_HUMAN_GET_FORCED_NAME, identity)
		return identity[VISIBLE_NAME_FORCED] ? identity[VISIBLE_NAME_FACE] : if_no_id

	// either results in an ID card, a generic card, or null
	var/obj/item/card/id = wear_id?.GetID() || astype(wear_id, /obj/item/card)
	return id?.get_displayed_name(honorifics) || if_no_id

/mob/living/carbon/human/get_idcard(hand_first = TRUE)
	. = ..()
	if(. && hand_first)
		return
	//Check inventory slots
	return (wear_id?.GetID() || belt?.GetID())

/mob/living/carbon/human/can_use_guns(obj/item/G)
	. = ..()
	if(G.trigger_guard == TRIGGER_GUARD_NORMAL)
		if(check_chunky_fingers())
			balloon_alert(src, "fingers are too big!")
			return FALSE
	if(HAS_TRAIT(src, TRAIT_NOGUNS))
		to_chat(src, span_warning("You can't bring yourself to use a ranged weapon!"))
		return FALSE

/mob/living/carbon/human/proc/check_chunky_fingers()
	if(HAS_TRAIT_NOT_FROM(src, TRAIT_CHUNKYFINGERS, RIGHT_ARM_TRAIT) && HAS_TRAIT_NOT_FROM(src, TRAIT_CHUNKYFINGERS, LEFT_ARM_TRAIT))
		return TRUE
	return IS_LEFT_INDEX(active_hand_index) ? HAS_TRAIT_FROM(src, TRAIT_CHUNKYFINGERS, LEFT_ARM_TRAIT) : HAS_TRAIT_FROM(src, TRAIT_CHUNKYFINGERS, RIGHT_ARM_TRAIT)

/mob/living/carbon/human/get_policy_keywords()
	. = ..()
	. += "[dna.species.type]"

/mob/living/carbon/human/proc/get_eye_scars()
	var/obj/item/organ/eyes/eyes = get_organ_slot(ORGAN_SLOT_EYES)
	if (!isnull(eyes))
		return eyes.scarring

/// When we're joining the game in [/mob/dead/new_player/proc/create_character], we increment our scar slot then store the slot in our mind datum.
/mob/living/carbon/human/proc/increment_scar_slot()
	var/check_ckey = ckey || client?.ckey
	if(!check_ckey || !mind || !client?.prefs.read_preference(/datum/preference/toggle/persistent_scars))
		return

	var/path = "data/player_saves/[check_ckey[1]]/[check_ckey]/scars.sav"
	var/index = mind.current_scar_slot_index
	if(!index)
		if(fexists(path))
			var/savefile/F = new /savefile(path)
			index = F["current_scar_index"] || 1
		else
			index = 1

	mind.current_scar_slot_index = (index % PERSISTENT_SCAR_SLOTS) + 1 || 1

/// For use formatting all of the scars this human has for saving for persistent scarring, returns a string with all current scars/missing limb amputation scars for saving or loading purposes
/mob/living/carbon/human/proc/format_scars()
	var/list/missing_bodyparts = get_missing_limbs()
	if(!all_scars && !length(missing_bodyparts))
		return
	var/scars = ""
	for(var/i in missing_bodyparts)
		var/datum/scar/scaries = new
		scars += "[scaries.format_amputated(i)]"
	for(var/datum/scar/iter_scar as anything in all_scars)
		if(!iter_scar.fake)
			scars += "[iter_scar.format()];"
	return scars

/// Takes a single scar from the persistent scar loader and recreates it from the saved data
/mob/living/carbon/human/proc/load_scar(scar_line, specified_char_index)
	var/list/scar_data = splittext(scar_line, "|")
	if(LAZYLEN(scar_data) != SCAR_SAVE_LENGTH)
		return // invalid, should delete
	var/version = text2num(scar_data[SCAR_SAVE_VERS])
	if(!version || version != SCAR_CURRENT_VERSION) // get rid of scars using a incompatable version
		return
	if(specified_char_index && (mind?.original_character_slot_index != specified_char_index))
		return
	if (isnull(text2num(scar_data[SCAR_SAVE_BIOLOGY])))
		return
	var/obj/item/bodypart/the_part = get_bodypart("[scar_data[SCAR_SAVE_ZONE]]")
	var/datum/scar/scaries = new
	return scaries.load(the_part, scar_data[SCAR_SAVE_VERS], scar_data[SCAR_SAVE_DESC], scar_data[SCAR_SAVE_PRECISE_LOCATION], text2num(scar_data[SCAR_SAVE_SEVERITY]), text2num(scar_data[SCAR_SAVE_BIOLOGY]), text2num(scar_data[SCAR_SAVE_CHAR_SLOT]), text2num(scar_data[SCAR_SAVE_CHECK_ANY_BIO]))

/// Read all the scars we have for the designated character/scar slots, verify they're good/dump them if they're old/wrong format, create them on the user, and write the scars that passed muster back to the file
/mob/living/carbon/human/proc/load_persistent_scars()
	if(!ckey || !mind?.original_character_slot_index || !client?.prefs.read_preference(/datum/preference/toggle/persistent_scars))
		return

	var/path = "data/player_saves/[ckey[1]]/[ckey]/scars.sav"
	var/loaded_char_slot = client.prefs.default_slot

	if(!loaded_char_slot || !fexists(path))
		return FALSE
	var/savefile/F = new /savefile(path)
	if(!F)
		return

	var/char_index = mind.original_character_slot_index
	var/scar_index = mind.current_scar_slot_index || F["current_scar_index"] || 1

	var/scar_string = F["scar[char_index]-[scar_index]"]
	var/valid_scars = ""

	for(var/scar_line in splittext(sanitize_text(scar_string), ";"))
		if(load_scar(scar_line, char_index))
			valid_scars += "[scar_line];"

	WRITE_FILE(F["scar[char_index]-[scar_index]"], sanitize_text(valid_scars))

/// Save any scars we have to our designated slot, then write our current slot so that the next time we call [/mob/living/carbon/human/proc/increment_scar_slot] (the next round we join), we'll be there
/mob/living/carbon/human/proc/save_persistent_scars(nuke = FALSE)
	if(!ckey || !mind?.original_character_slot_index || !client?.prefs.read_preference(/datum/preference/toggle/persistent_scars))
		return

	var/path = "data/player_saves/[ckey[1]]/[ckey]/scars.sav"
	var/savefile/F = new /savefile(path)
	var/char_index = mind.original_character_slot_index
	var/scar_index = mind.current_scar_slot_index || F["current_scar_index"] || 1

	if(nuke)
		WRITE_FILE(F["scar[char_index]-[scar_index]"], "")
		return

	for(var/k in all_wounds)
		var/datum/wound/iter_wound = k
		iter_wound.remove_wound() // so we can get the scars for open wounds

	var/valid_scars = format_scars()
	WRITE_FILE(F["scar[char_index]-[scar_index]"], sanitize_text(valid_scars))
	WRITE_FILE(F["current_scar_index"], sanitize_integer(scar_index))

///copies over clothing preferences like underwear to another human
/mob/living/carbon/human/proc/copy_clothing_prefs(mob/living/carbon/human/destination)
	destination.underwear = underwear
	destination.underwear_color = underwear_color
	destination.undershirt = undershirt
	destination.socks = socks
	destination.jumpsuit_style = jumpsuit_style

/mob/living/carbon/human/proc/get_age()
	var/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((obscured & ITEM_SLOT_ICLOTHING) && skipface || isipc(src))
		return ""
	switch(age)
		if(70 to INFINITY)
			return "Geriatric"
		if(60 to 70)
			return "Elderly"
		if(50 to 60)
			return "Old"
		if(40 to 50)
			return "Middle-Aged"
		if(24 to 40)
			return "" //not necessary because this is basically the most common age range
		if(18 to 24)
			return "Young"
		else
			return "Puzzling"

/mob/living/carbon/human/proc/get_generic_name(prefixed = FALSE, lowercase = FALSE)
	var/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	var/hide_features = (obscured & ITEM_SLOT_ICLOTHING) && skipface
	var/visible_adjective
	if(generic_adjective && !hide_features)
		visible_adjective = "[generic_adjective] "
	var/visible_age = get_age()
	if(visible_age)
		visible_age = "[visible_age] "
	var/visible_gender = get_gender()
	var/final_string = "[visible_adjective][visible_age][dna.species.name] [visible_gender]"
	if(prefixed)
		final_string = "\A [final_string]"
	return lowercase ? lowertext(final_string) : final_string

/mob/living/carbon/human/proc/get_gender()
	var/visible_gender = p_they()
	switch(visible_gender)
		if("he")
			visible_gender = "Man"
		if("she")
			visible_gender = "Woman"
		if("they")
			if(ishuman(src))
				visible_gender = "Person"
			else
				visible_gender = "Creature"
		else
			visible_gender = "Thing"
	return visible_gender
