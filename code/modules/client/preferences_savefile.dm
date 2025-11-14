/// Placeholder to check against the SAVE_DATA_EMPTY and SAVE_DATA_OBSOLETE values.
/// _Any_ generated save data version will be zero or a positive integer, so it's only necessary to check against this value for anything negative (error states).
#define SAVE_DATA_NO_ERROR 0
/// Typically signifies an empty list, where the savefile is not loaded or the character is new. Will just trigger a regeneration.
#define SAVE_DATA_EMPTY -1
/// The save data is below the accepted minimum and should be reset.
#define SAVE_DATA_OBSOLETE -2

/// This is the lowest supported version, anything below this is completely obsolete and the entire savefile will be wiped.
#define SAVEFILE_VERSION_MIN 32

/// This is the current version, anything below this will attempt to update (if it's not obsolete)
/// You do not need to raise this if you are adding new values that have sane defaults.
/// Only raise this value when changing the meaning/format/name/layout of an existing value
/// where you would want the updater procs below to run
#define SAVEFILE_VERSION_MAX 50

#define IS_DATA_OBSOLETE(version) (version == SAVE_DATA_OBSOLETE)
#define SHOULD_UPDATE_DATA(version) (version >= SAVE_DATA_NO_ERROR && version < SAVEFILE_VERSION_MAX)

/*
SAVEFILE UPDATING/VERSIONING - 'Simplified', or rather, more coder-friendly ~Carn
	This proc checks if the current directory of the savefile S needs updating
	It is to be used by the load_character and load_preferences procs.
	(S.cd == "/" is preferences, S.cd == "/character[integer]" is a character slot, etc)

	if the current directory's version is below SAVEFILE_VERSION_MIN it will simply wipe everything in that directory
	(if we're at root "/" then it'll just wipe the entire savefile, for instance.)

	if its version is below SAVEFILE_VERSION_MAX but above the minimum, it will load data but later call the
	respective update_preferences() or update_character() proc.
	Those procs allow coders to specify format changes so users do not lose their setups and have to redo them again.

	Failing all that, the standard sanity checks are performed. They simply check the data is suitable, reverting to
	initial() values if necessary.
*/
/datum/preferences/proc/check_savedata_version(list/save_data)
	if(!save_data)
		return SAVE_DATA_EMPTY
	var/save_version = save_data["version"]

	if(save_version < SAVEFILE_VERSION_MIN)
		return SAVE_DATA_OBSOLETE
	if(save_version < SAVEFILE_VERSION_MAX)
		return save_version
	return SAVE_DATA_EMPTY

//should these procs get fairly long
//just increase SAVEFILE_VERSION_MIN so it's not as far behind
//SAVEFILE_VERSION_MAX and then delete any obsolete if clauses
//from these procs.
//This only really meant to avoid annoying frequent players
//if your savefile is 3 months out of date, then 'tough shit'.

/datum/preferences/proc/update_preferences(current_version, datum/json_savefile/S)
	if(current_version < 34)
		write_preference(/datum/preference/toggle/auto_fit_viewport, TRUE)

	if(current_version < 35) //makes old keybinds compatible with #52040, sets the new default
		var/newkey = FALSE
		for(var/list/key in key_bindings)
			for(var/bind in key)
				if(bind == "quick_equipbelt")
					key -= "quick_equipbelt"
					key |= "quick_equip_belt"

				if(bind == "bag_equip")
					key -= "bag_equip"
					key |= "quick_equip_bag"

				if(bind == "quick_equip_suit_storage")
					newkey = TRUE
		if(!newkey && !key_bindings["ShiftQ"])
			key_bindings["ShiftQ"] = list("quick_equip_suit_storage")

	if(current_version < 36)
		if(key_bindings["ShiftQ"] == "quick_equip_suit_storage")
			key_bindings["ShiftQ"] = list("quick_equip_suit_storage")

	if(current_version < 37)
		if(read_preference(/datum/preference/numeric/fps) == 0)
			write_preference(GLOB.preference_entries[/datum/preference/numeric/fps], -1)

	if (current_version < 38)
		var/found_block_movement = FALSE

		for (var/list/key in key_bindings)
			for (var/bind in key)
				if (bind == "block_movement")
					found_block_movement = TRUE
					break
			if (found_block_movement)
				break

		if (!found_block_movement)
			LAZYADD(key_bindings["Ctrl"], "block_movement")

	if (current_version < 39)
		LAZYADD(key_bindings["F"], "toggle_combat_mode")
		LAZYADD(key_bindings["4"], "toggle_combat_mode")
	if (current_version < 40)
		LAZYADD(key_bindings["Space"], "hold_throw_mode")

	if (current_version < 41)
		migrate_preferences_to_tgui_prefs_menu()

	if (current_version < 44)
		update_tts_blip_prefs()

/datum/preferences/proc/update_character(current_version, list/save_data)
	if (current_version < 41)
		migrate_character_to_tgui_prefs_menu()

	if (current_version < 42)
		migrate_body_types(save_data)

	if (current_version < 43)
		migrate_legacy_sound_toggles(savefile)

	if (current_version < 45)
		migrate_quirk_to_loadout(
			quirk_to_migrate = "Pride Pin",
			new_typepath = /obj/item/clothing/accessory/pride,
			data_to_migrate = list(INFO_RESKIN = save_data?["pride_pin"]),
		)
	if (current_version < 46)
		migrate_boolean_sound_prefs_to_default_volume()
	if (current_version < 47)
		migrate_boolean_sound_prefs_to_default_volume_v2()
	if (current_version < 48)
		migrate_quirk_to_loadout(
			quirk_to_migrate = "Colorist",
			new_typepath = /obj/item/dyespray,
		)
	if(current_version < 49)
		migrate_quirk_to_loadout(
			quirk_to_migrate = "Cyborg Pre-screened dogtag",
			new_typepath = /obj/item/clothing/accessory/dogtag/borg_ready,
		)
	if(current_version < 50)
		migrate_quirk_to_personality(
			quirk_to_migrate = "Extrovert",
			new_typepath = /datum/personality/extrovert,
		)
		migrate_quirk_to_personality(
			quirk_to_migrate = "Introvert",
			new_typepath = /datum/personality/introvert,
		)
		migrate_quirk_to_personality(
			quirk_to_migrate = "Bad Touch",
			new_typepath = /datum/personality/aloof,
		)
		migrate_quirk_to_personality(
			quirk_to_migrate = "Apathetic",
			new_typepath = /datum/personality/apathetic,
		)
		migrate_quirk_to_personality(
			quirk_to_migrate = "Snob",
			new_typepath = /datum/personality/snob,
		)
		migrate_quirk_to_personality(
			quirk_to_migrate = "Spiritual",
			new_typepath = /datum/personality/spiritual,
		)

/// checks through keybindings for outdated unbound keys and updates them
/datum/preferences/proc/check_keybindings()
	if(!parent)
		return
	var/list/binds_by_key = get_key_bindings_by_key(key_bindings)
	var/list/notadded = list()
	for (var/name in GLOB.keybindings_by_name)
		var/datum/keybinding/kb = GLOB.keybindings_by_name[name]
		if(kb.name in key_bindings)
			continue // key is unbound and or bound to something

		var/addedbind = FALSE
		key_bindings[kb.name] = list()

		if(parent.hotkeys)
			for(var/hotkeytobind in kb.hotkey_keys)
				if(hotkeytobind == "Unbound")
					addedbind = TRUE
				else if(!length(binds_by_key[hotkeytobind])) //Only bind to the key if nothing else is bound
					key_bindings[kb.name] |= hotkeytobind
					addedbind = TRUE
		else
			for(var/classickeytobind in kb.classic_keys)
				if(classickeytobind == "Unbound")
					addedbind = TRUE
				else if(!length(binds_by_key[classickeytobind])) //Only bind to the key if nothing else is bound
					key_bindings[kb.name] |= classickeytobind
					addedbind = TRUE

		if(!addedbind)
			notadded += kb
	save_preferences() //Save the players pref so that new keys that were set to Unbound as default are permanently stored
	if(length(notadded))
		addtimer(CALLBACK(src, PROC_REF(announce_conflict), notadded), 5 SECONDS)

/datum/preferences/proc/announce_conflict(list/notadded)
	to_chat(parent, "<span class='warningplain'><b><u>Keybinding Conflict</u></b></span>\n\
					<span class='warningplain'><b>There are new <a href='byond://?src=[REF(src)];open_keybindings=1'>keybindings</a> that default to keys you've already bound. The new ones will be unbound.</b></span>")
	for(var/item in notadded)
		var/datum/keybinding/conflicted = item
		to_chat(parent, span_danger("[conflicted.category]: [conflicted.full_name] needs updating"))

/datum/preferences/proc/load_path(ckey, filename="preferences.json")
	if(!ckey || !load_and_save)
		return
	path = "data/player_saves/[ckey[1]]/[ckey]/[filename]"

/datum/preferences/proc/load_savefile()
	if(load_and_save && !path)
		CRASH("Attempted to load savefile without first loading a path!")
	savefile = new /datum/json_savefile(load_and_save ? path : null)

/datum/preferences/proc/load_preferences()
	if(!savefile)
		stack_trace("Attempted to load the preferences of [parent] without a savefile; did you forget to call load_savefile?")
		load_savefile()
		if(!savefile)
			stack_trace("Failed to load the savefile for [parent] after manually calling load_savefile; something is very wrong.")
			return FALSE

	var/data_validity_integer = check_savedata_version(savefile.get_entry())
	if(load_and_save && IS_DATA_OBSOLETE(data_validity_integer)) //fatal, can't load any data
		var/bacpath = PREFS_BACKUP_PATH(path) //todo: if the savefile version is higher then the server, check the backup, and give the player a prompt to load the backup
		if (fexists(bacpath))
			fdel(bacpath) //only keep 1 version of backup
		fcopy(savefile.path, bacpath) //byond helpfully lets you use a savefile for the first arg.
		return FALSE

	apply_all_client_preferences()

	//general preferences
	lastchangelog = savefile.get_entry("lastchangelog", lastchangelog)
	be_special = savefile.get_entry("be_special", be_special)
	default_slot = savefile.get_entry("default_slot", default_slot)
	chat_toggles = savefile.get_entry("chat_toggles", chat_toggles)
	toggles = savefile.get_entry("toggles", toggles)
	ignoring = savefile.get_entry("ignoring", ignoring)

	// OOC commendations
	hearted_until = savefile.get_entry("hearted_until", hearted_until)
	if(hearted_until > world.realtime)
		hearted = TRUE
	//favorite outfits
	favorite_outfits = savefile.get_entry("favorite_outfits", favorite_outfits)

	var/list/parsed_favs = list()
	for(var/typetext in favorite_outfits)
		var/datum/outfit/path = text2path(typetext)
		if(ispath(path)) //whatever typepath fails this check probably doesn't exist anymore
			parsed_favs += path
	favorite_outfits = unique_list(parsed_favs)

	// Custom hotkeys
	key_bindings = savefile.get_entry("key_bindings", key_bindings)

	//try to fix any outdated data if necessary
	if(SHOULD_UPDATE_DATA(data_validity_integer))
		var/bacpath = PREFS_BACKUP_PATH(path) //todo: if the savefile version is higher then the server, check the backup, and give the player a prompt to load the backup
		if (fexists(bacpath))
			fdel(bacpath) //only keep 1 version of backup
		fcopy(savefile.path, bacpath) //byond helpfully lets you use a savefile for the first arg.
		update_preferences(data_validity_integer, savefile)

	check_keybindings() // this apparently fails every time and overwrites any unloaded prefs with the default values, so don't load anything after this line or it won't actually save

	//Sanitize
	lastchangelog = sanitize_text(lastchangelog, initial(lastchangelog))
	default_slot = sanitize_integer(default_slot, 1, max_save_slots, initial(default_slot))
	toggles = sanitize_integer(toggles, 0, SHORT_REAL_LIMIT-1, initial(toggles))
	be_special = sanitize_be_special(SANITIZE_LIST(be_special))
	key_bindings = sanitize_keybindings(key_bindings)
	favorite_outfits = SANITIZE_LIST(favorite_outfits)

	key_bindings_by_key = get_key_bindings_by_key(key_bindings)

	if(SHOULD_UPDATE_DATA(data_validity_integer)) //save the updated version
		var/old_default_slot = default_slot
		var/old_max_save_slots = max_save_slots

		for (var/slot in savefile.get_entry()) //but first, update all current character slots.
			if (copytext(slot, 1, 10) != "character")
				continue
			var/slotnum = text2num(copytext(slot, 10))
			if (!slotnum)
				continue
			max_save_slots = max(max_save_slots, slotnum) //so we can still update byond member slots after they lose memeber status
			default_slot = slotnum
			if (load_character())
				save_character()
		default_slot = old_default_slot
		max_save_slots = old_max_save_slots
		save_preferences()

	return TRUE

/datum/preferences/proc/save_preferences()
	if(!savefile)
		CRASH("Attempted to save the preferences of [parent] without a savefile. This should have been handled by load_preferences()")
	if(path == DEV_PREFS_PATH)
		// Don't save over dev preferences
		return TRUE

	savefile.set_entry("version", SAVEFILE_VERSION_MAX) //updates (or failing that the sanity checks) will ensure data is not invalid at load. Assume up-to-date

	for (var/preference_type in GLOB.preference_entries)
		var/datum/preference/preference = GLOB.preference_entries[preference_type]
		if (preference.savefile_identifier != PREFERENCE_PLAYER)
			continue

		if (!(preference.type in recently_updated_keys))
			continue

		recently_updated_keys -= preference.type

		if (preference_type in value_cache)
			write_preference(preference, preference.serialize(value_cache[preference_type]))

	savefile.set_entry("lastchangelog", lastchangelog)
	savefile.set_entry("be_special", be_special)
	savefile.set_entry("default_slot", default_slot)
	savefile.set_entry("toggles", toggles)
	savefile.set_entry("chat_toggles", chat_toggles)
	savefile.set_entry("ignoring", ignoring)
	savefile.set_entry("key_bindings", key_bindings)
	savefile.set_entry("hearted_until", (hearted_until > world.realtime ? hearted_until : null))
	savefile.set_entry("favorite_outfits", favorite_outfits)
	savefile.save()
	return TRUE

/datum/preferences/proc/load_character(slot)
	SHOULD_NOT_SLEEP(TRUE)
	if(!slot)
		slot = default_slot
	slot = sanitize_integer(slot, 1, max_save_slots, initial(default_slot))
	if(slot != default_slot)
		default_slot = slot
		savefile.set_entry("default_slot", slot)

	var/tree_key = "character[slot]"
	var/list/save_data = savefile.get_entry(tree_key)
	var/data_validity_integer = check_savedata_version(save_data)
	if(IS_DATA_OBSOLETE(data_validity_integer)) //fatal, can't load any data
		return FALSE

	// Read everything into cache
	// Uses priority order as some values may rely on others for creating default values
	for (var/datum/preference/preference as anything in get_preferences_in_priority_order())
		if (preference.savefile_identifier != PREFERENCE_CHARACTER)
			continue

		value_cache -= preference.type
		read_preference(preference.type)

	//Character
	READ_FILE(S["real_name"], real_name)
	READ_FILE(S["gender"], gender)
	READ_FILE(S["age"], age)
	READ_FILE(S["hair_color"], hair_color)
	READ_FILE(S["facial_hair_color"], facial_hair_color)
	READ_FILE(S["eye_color"], eye_color)
	READ_FILE(S["skin_tone"], skin_tone)
	READ_FILE(S["hairstyle_name"], hairstyle)
	READ_FILE(S["facial_style_name"], facial_hairstyle)
	READ_FILE(S["feature_grad_style"], features["grad_style"])
	READ_FILE(S["feature_grad_color"], features["grad_color"])
	READ_FILE(S["underwear"], underwear)
	READ_FILE(S["underwear_color"], underwear_color)
	READ_FILE(S["undershirt"], undershirt)
	READ_FILE(S["undershirt_color"], undershirt_color)
	READ_FILE(S["socks"], socks)
	READ_FILE(S["socks_color"], socks_color)
	READ_FILE(S["backpack"], backpack)
	READ_FILE(S["jumpsuit_style"], jumpsuit_style)
	READ_FILE(S["uplink_loc"], uplink_spawn_loc)
	READ_FILE(S["phobia"], phobia)
	READ_FILE(S["generic_adjective"], generic_adjective)
	READ_FILE(S["randomise"],  randomise)
	READ_FILE(S["body_size"], features["body_size"])
	READ_FILE(S["prosthetic_limbs"], prosthetic_limbs)
	prosthetic_limbs ||= list(BODY_ZONE_L_ARM = PROSTHETIC_NORMAL, BODY_ZONE_R_ARM = PROSTHETIC_NORMAL, BODY_ZONE_L_LEG = PROSTHETIC_NORMAL, BODY_ZONE_R_LEG = PROSTHETIC_NORMAL)
	READ_FILE(S["feature_mcolor"], features["mcolor"])
	READ_FILE(S["feature_mcolor2"], features["mcolor2"])
	READ_FILE(S["feature_ethcolor"], features["ethcolor"])
	READ_FILE(S["feature_lizard_tail"], features["tail_lizard"])
	READ_FILE(S["feature_lizard_face_markings"], features["face_markings"])
	READ_FILE(S["feature_lizard_horns"], features["horns"])
	READ_FILE(S["feature_lizard_frills"], features["frills"])
	READ_FILE(S["feature_lizard_spines"], features["spines"])
	READ_FILE(S["feature_lizard_body_markings"], features["body_markings"])
	READ_FILE(S["feature_lizard_legs"], features["legs"])
	READ_FILE(S["feature_moth_wings"], features["moth_wings"])
	READ_FILE(S["feature_moth_markings"], features["moth_markings"])

	READ_FILE(S["jumpsuit_style"], jumpsuit_style)
	READ_FILE(S["exowear"], exowear)
	READ_FILE(S["feature_moth_fluff"], features["moth_fluff"])
	READ_FILE(S["feature_spider_legs"], features["spider_legs"])
	READ_FILE(S["feature_spider_spinneret"], features["spider_spinneret"])
	READ_FILE(S["feature_spider_mandibles"], features["spider_mandibles"])
	READ_FILE(S["feature_squid_face"], features["squid_face"])
	READ_FILE(S["feature_ipc_screen"], features["ipc_screen"])
	READ_FILE(S["feature_ipc_antenna"], features["ipc_antenna"])
	READ_FILE(S["feature_ipc_tail"], features["ipc_tail"])
	READ_FILE(S["feature_ipc_chassis"], features["ipc_chassis"])
	READ_FILE(S["feature_ipc_brain"], features["ipc_brain"])
	READ_FILE(S["feature_kepori_feathers"], features["kepori_feathers"])
	READ_FILE(S["feature_kepori_body_feathers"], features["kepori_body_feathers"])
	READ_FILE(S["feature_kepori_tail_feathers"], features["kepori_tail_feathers"])
	READ_FILE(S["feature_vox_head_quills"], features["vox_head_quills"])
	READ_FILE(S["feature_vox_neck_quills"], features["vox_neck_quills"])
	READ_FILE(S["feature_elzu_horns"], features["elzu_horns"])
	READ_FILE(S["feature_tail_elzu"], features["tail_elzu"])

	READ_FILE(S["equipped_gear"], equipped_gear)
	if(config) //This should *probably* always be there, but just in case.
		if(length(equipped_gear) > CONFIG_GET(number/max_loadout_items))
			to_chat(parent, "<span class='userdanger'>Loadout maximum items exceeded in loaded slot, Your loadout has been cleared! You had [length(equipped_gear)]/[CONFIG_GET(number/max_loadout_items)] equipped items!</span>")
			equipped_gear = list()
			WRITE_FILE(S["equipped_gear"]				, equipped_gear)

	READ_FILE(S["feature_human_tail"], features["tail_human"])
	READ_FILE(S["feature_human_ears"], features["ears"])

	READ_FILE(S["fbp"], fbp)

	//Custom names
	for(var/custom_name_id in GLOB.preferences_custom_names)
		var/savefile_slot_name = custom_name_id + "_name" //TODO remove this
		READ_FILE(S[savefile_slot_name], custom_names[custom_name_id])

	READ_FILE(S["preferred_ai_core_display"], preferred_ai_core_display)
	READ_FILE(S["prefered_security_department"], prefered_security_department)

	//Preview outfit selection
	READ_FILE(S["selected_outfit"], selected_outfit)

	//Quirks
	all_quirks = save_data?["all_quirks"]

	//try to fix any outdated data if necessary
	//preference updating will handle saving the updated data for us.
	if(SHOULD_UPDATE_DATA(data_validity_integer))
		update_character(data_validity_integer, save_data)

	//Sanitize
	randomise = SANITIZE_LIST(randomise)
	job_preferences = SANITIZE_LIST(job_preferences)
	all_quirks = SANITIZE_LIST(all_quirks)

	//Validate job prefs
	for(var/j in job_preferences)
		if(job_preferences[j] != JP_LOW && job_preferences[j] != JP_MEDIUM && job_preferences[j] != JP_HIGH)
			job_preferences -= j

	all_quirks = SSquirks.filter_invalid_quirks(SANITIZE_LIST(all_quirks))
	validate_quirks()

	return TRUE

/datum/preferences/proc/save_character()
	SHOULD_NOT_SLEEP(TRUE)
	if(!path)
		return FALSE
	var/tree_key = "character[default_slot]"
	if(!(tree_key in savefile.get_entry()))
		savefile.set_entry(tree_key, list())
	var/save_data = savefile.get_entry(tree_key)

	for (var/datum/preference/preference as anything in get_preferences_in_priority_order())
		if (preference.savefile_identifier != PREFERENCE_CHARACTER)
			continue

		if (!(preference.type in recently_updated_keys))
			continue

		recently_updated_keys -= preference.type

		if (preference.type in value_cache)
			write_preference(preference, preference.serialize(value_cache[preference.type]))

	save_data["version"] = SAVEFILE_VERSION_MAX //load_character will sanitize any bad data, so assume up-to-date.

	// This is the version when the random security department was removed.
	// When the minimum is higher than that version, it's impossible for someone to have the "Random" department.
	#if SAVEFILE_VERSION_MIN > 40
	#warn The prefered_security_department check in code/modules/client/preferences/security_department.dm is no longer necessary.
	#endif

	//Character
	WRITE_FILE(S["real_name"]					, real_name)
	WRITE_FILE(S["gender"]						, gender)
	WRITE_FILE(S["age"]							, age)
	WRITE_FILE(S["hair_color"]					, hair_color)
	WRITE_FILE(S["facial_hair_color"]			, facial_hair_color)
	WRITE_FILE(S["feature_grad_color"]			, features["grad_color"])
	WRITE_FILE(S["eye_color"]					, eye_color)
	WRITE_FILE(S["skin_tone"]					, skin_tone)
	WRITE_FILE(S["hairstyle_name"]				, hairstyle)
	WRITE_FILE(S["facial_style_name"]			, facial_hairstyle)
	WRITE_FILE(S["feature_grad_style"]			, features["grad_style"])
	WRITE_FILE(S["underwear"]					, underwear)
	WRITE_FILE(S["underwear_color"]				, underwear_color)
	WRITE_FILE(S["undershirt"]					, undershirt)
	WRITE_FILE(S["undershirt_color"]			, undershirt_color)
	WRITE_FILE(S["socks"]						, socks)
	WRITE_FILE(S["socks_color"]					, socks_color)
	WRITE_FILE(S["backpack"]					, backpack)
	WRITE_FILE(S["uplink_loc"]					, uplink_spawn_loc)
	WRITE_FILE(S["randomise"]					, randomise)
	WRITE_FILE(S["species"]						, pref_species.id)
	WRITE_FILE(S["phobia"]						, phobia)
	WRITE_FILE(S["generic_adjective"]			, generic_adjective)
	WRITE_FILE(S["body_size"]					, features["body_size"])
	WRITE_FILE(S["prosthetic_limbs"]			, prosthetic_limbs)
	WRITE_FILE(S["feature_mcolor"]				, features["mcolor"])
	WRITE_FILE(S["feature_mcolor2"]				, features["mcolor2"])
	WRITE_FILE(S["feature_ethcolor"]			, features["ethcolor"])
	WRITE_FILE(S["feature_lizard_tail"]			, features["tail_lizard"])
	WRITE_FILE(S["feature_human_tail"]			, features["tail_human"])
	WRITE_FILE(S["feature_lizard_face_markings"], features["face_markings"])
	WRITE_FILE(S["feature_lizard_horns"]		, features["horns"])
	WRITE_FILE(S["feature_human_ears"]			, features["ears"])
	WRITE_FILE(S["feature_lizard_frills"]		, features["frills"])
	WRITE_FILE(S["feature_lizard_spines"]		, features["spines"])
	WRITE_FILE(S["feature_lizard_body_markings"], features["body_markings"])
	WRITE_FILE(S["feature_lizard_legs"]			, features["legs"])
	WRITE_FILE(S["feature_moth_wings"]			, features["moth_wings"])
	WRITE_FILE(S["feature_moth_markings"]		, features["moth_markings"])
	WRITE_FILE(S["jumpsuit_style"]				, jumpsuit_style)
	WRITE_FILE(S["exowear"]						, exowear)
	WRITE_FILE(S["equipped_gear"]				, equipped_gear)
	WRITE_FILE(S["feature_moth_fluff"]			, features["moth_fluff"])
	WRITE_FILE(S["feature_spider_legs"]			, features["spider_legs"])
	WRITE_FILE(S["feature_spider_spinneret"]	, features["spider_spinneret"])
	WRITE_FILE(S["feature_spider_mandibles"]	, features["spider_mandibles"])
	WRITE_FILE(S["feature_squid_face"]			, features["squid_face"])
	WRITE_FILE(S["feature_ipc_screen"]			, features["ipc_screen"])
	WRITE_FILE(S["feature_ipc_antenna"]			, features["ipc_antenna"])
	WRITE_FILE(S["feature_ipc_tail"] 			, features["ipc_tail"])
	WRITE_FILE(S["feature_ipc_chassis"]			, features["ipc_chassis"])
	WRITE_FILE(S["feature_ipc_brain"]			, features["ipc_brain"])
	WRITE_FILE(S["feature_kepori_feathers"]		, features["kepori_feathers"])
	WRITE_FILE(S["feature_kepori_body_feathers"], features["kepori_body_feathers"])
	WRITE_FILE(S["feature_kepori_tail_feathers"], features["kepori_tail_feathers"])
	WRITE_FILE(S["feature_vox_head_quills"]		, features["vox_head_quills"])
	WRITE_FILE(S["feature_vox_neck_quills"]		, features["vox_neck_quills"])
	WRITE_FILE(S["feature_elzu_horns"]			, features["elzu_horns"])
	WRITE_FILE(S["feature_tail_elzu"]			, features["tail_elzu"])
	WRITE_FILE(S["fbp"]							, fbp)

	//Flavor text
	WRITE_FILE(S["feature_flavor_text"]			, features["flavor_text"])
	//Custom names
	for(var/custom_name_id in GLOB.preferences_custom_names)
		var/savefile_slot_name = custom_name_id + "_name" //TODO remove this
		WRITE_FILE(S[savefile_slot_name]		,custom_names[custom_name_id])
	//AI cores
	WRITE_FILE(S["preferred_ai_core_display"]	, preferred_ai_core_display)
	//Deprecated department security stuff
	WRITE_FILE(S["prefered_security_department"], prefered_security_department)
	//Preview outfit selection
	WRITE_FILE(S["selected_outfit"]				, selected_outfit)
	//Quirks
	save_data["all_quirks"] = all_quirks

	return TRUE

/datum/preferences/proc/switch_to_slot(new_slot)
	// SAFETY: `load_character` performs sanitization on the slot number
	if (!load_character(new_slot))
		tainted_character_profiles = TRUE
		randomise_appearance_prefs()
		save_character()

	for (var/datum/preference_middleware/preference_middleware as anything in middleware)
		preference_middleware.on_new_character(usr)

	character_preview_view.update_body()

/datum/preferences/proc/remove_current_slot()
	PRIVATE_PROC(TRUE)

	var/closest_slot
	for (var/other_slot in default_slot - 1 to 1 step -1)
		var/save_data = savefile.get_entry("character[other_slot]")
		if (!isnull(save_data))
			closest_slot = other_slot
			break

	if (isnull(closest_slot))
		for (var/other_slot in default_slot + 1 to max_save_slots)
			var/save_data = savefile.get_entry("character[other_slot]")
			if (!isnull(save_data))
				closest_slot = other_slot
				break

	if (isnull(closest_slot))
		stack_trace("remove_current_slot() being called when there are no slots to go to, the client should prevent this")
		return

	savefile.remove_entry("character[default_slot]")
	tainted_character_profiles = TRUE
	switch_to_slot(closest_slot)

/datum/preferences/proc/sanitize_be_special(list/input_be_special)
	var/list/output = list()

	for (var/role in input_be_special)
		if (role in get_all_antag_flags())
			output += role

	return output.len == input_be_special.len ? input_be_special : output

/proc/sanitize_keybindings(value)
	var/list/base_bindings = sanitize_islist(value,list())
	for(var/keybind_name in base_bindings)
		if (!(keybind_name in GLOB.keybindings_by_name))
			base_bindings -= keybind_name
	return base_bindings

#undef SAVEFILE_VERSION_MAX
#undef SAVEFILE_VERSION_MIN
#undef SAVE_DATA_NO_ERROR
#undef SAVE_DATA_EMPTY
#undef SAVE_DATA_OBSOLETE
#undef IS_DATA_OBSOLETE
#undef SHOULD_UPDATE_DATA
