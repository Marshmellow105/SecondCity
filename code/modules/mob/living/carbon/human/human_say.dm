
/mob/living/carbon/human/GetVoice(if_no_voice = get_generic_name())
	if(istype(wear_mask, /obj/item/clothing/mask/chameleon))
		var/obj/item/clothing/mask/chameleon/chameleon_mask = wear_mask
		if(chameleon_mask.voice_change && wear_id)
			var/obj/item/card/id/idcard = wear_id.GetID()
			if(istype(idcard))
				return idcard.registered_name
	else if(istype(wear_mask, /obj/item/clothing/mask/gas/syndicate/voicechanger))
		var/obj/item/clothing/mask/gas/syndicate/voicechanger/V = wear_mask
		if(V.voice_change && wear_id)
			var/obj/item/card/id/idcard = wear_id.GetID()
			if(istype(idcard))
				return idcard.registered_name
			else
				return real_name
		else
			return real_name
	else if(istype(wear_mask, /obj/item/clothing/mask/infiltrator))
		var/obj/item/clothing/mask/infiltrator/infiltrator_mask = wear_mask
		if(infiltrator_mask.voice_unknown)
			return if_no_voice
	if(mind)
		var/datum/antagonist/changeling/changeling = mind.has_antag_datum(/datum/antagonist/changeling)
		if(changeling && changeling.mimicing)
			return changeling.mimicing
	var/special_voice = GetSpecialVoice()
	if(special_voice)
		return special_voice
	return real_name

/mob/living/carbon/human/get_message_voice(visible_name)
	. = ..()
	if(. != name)
		. += " (as [get_id_name("Unknown", honorifics = TRUE)])"

/mob/living/carbon/human/binarycheck()
	if(stat >= SOFT_CRIT)
		return FALSE
	var/area/our_area = get_area(src)
	if(our_area.area_flags & BINARY_JAMMING)
		return FALSE
	var/obj/item/organ/brain/cybernetic/ai/brain = get_organ_slot(ORGAN_SLOT_BRAIN)
	if(istype(brain))
		return TRUE
	var/obj/item/radio/headset/dongle = ears
	if(!istype(dongle))
		return FALSE
	return dongle.special_channels & RADIO_SPECIAL_BINARY

/mob/living/carbon/human/radio(message, list/message_mods = list(), list/spans, language) //Poly has a copy of this, lazy bastard
	. = ..()
	if(.)
		return

	if(message_mods[MODE_HEADSET])
		if(ears)
			ears.talk_into(src, message, , spans, language, message_mods)
		return ITALICS | REDUCE_RANGE
	else if(message_mods[RADIO_EXTENSION] == MODE_DEPARTMENT)
		if(ears)
			ears.talk_into(src, message, message_mods[RADIO_EXTENSION], spans, language, message_mods)
		return ITALICS | REDUCE_RANGE
	else if(GLOB.default_radio_channels[message_mods[RADIO_EXTENSION]])
		if(ears)
			ears.talk_into(src, message, message_mods[RADIO_EXTENSION], spans, language, message_mods)
			return ITALICS | REDUCE_RANGE

	return FALSE
