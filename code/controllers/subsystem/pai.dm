SUBSYSTEM_DEF(pai)
	name = "pAI"
	flags = SS_NO_INIT|SS_NO_FIRE

	/// List of pAI candidates, including those not submitted.
	var/list/candidates = list()
	/// All pAI cards on the map.
	var/list/pai_card_list = list()
	/// Prevents a pAI from submitting itself repeatedly and sounding an alert.
	var/submit_spam = FALSE

/datum/controller/subsystem/pai/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PaiSubmit")
		ui.open()
		ui.set_autoupdate(FALSE)

/datum/controller/subsystem/pai/Recover()
	. = ..()
	candidates = SSpai.candidates
	pai_card_list = SSpai.pai_card_list

/datum/controller/subsystem/pai/ui_state(mob/user)
	return GLOB.observer_state

/datum/controller/subsystem/pai/ui_static_data(mob/user)
	. = ..()
	var/list/data = list()
	var/datum/pai_candidate/candidate = candidates[user.ckey]
	if(isnull(candidate))
		return data
	data["comments"] = candidate.comments
	data["description"] = candidate.description
	data["name"] = candidate.name
	return data

/datum/controller/subsystem/pai/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return TRUE
	var/mob/user = ui.user
	var/datum/pai_candidate/candidate = candidates[user.ckey]
	if(is_banned_from(user.ckey, ROLE_PAI))
		to_chat(user, span_warning("You are banned from playing pAI!"))
		ui.close()
		return FALSE
	if(isnull(candidate))
		to_chat(user, span_warning("There was an error. Please resubmit."))
		ui.close()
		return FALSE
	switch(action)
		if("submit")
			candidate.comments = reject_bad_name(params["comments"], allow_numbers = TRUE, max_length = MAX_BROADCAST_LEN, strict = TRUE, cap_after_symbols = FALSE) || "Unknown"
			candidate.description = reject_bad_name(params["description"], allow_numbers = TRUE, max_length = MAX_BROADCAST_LEN, strict = TRUE, cap_after_symbols = FALSE) || "Unknown"
			candidate.name = reject_bad_name(params["name"], allow_numbers = TRUE, max_length = MAX_NAME_LEN, strict = TRUE, cap_after_symbols = FALSE) || "Unknown"
			candidate.ckey = user.ckey
			candidate.ready = TRUE
			ui.close()
			submit_alert(user)
			return TRUE
		if("save")
			candidate.comments = reject_bad_name(params["comments"], allow_numbers = TRUE, max_length = MAX_BROADCAST_LEN, strict = TRUE, cap_after_symbols = FALSE) || "Unknown"
			candidate.description = reject_bad_name(params["description"], allow_numbers = TRUE, max_length = MAX_BROADCAST_LEN, strict = TRUE, cap_after_symbols = FALSE) || "Unknown"
			candidate.name = reject_bad_name(params["name"], allow_numbers = TRUE, max_length = MAX_NAME_LEN, strict = TRUE, cap_after_symbols = FALSE) || "Unknown"
			candidate.savefile_save(user)
			return TRUE
		if("load")
			candidate.savefile_load(user)
			ui.send_full_update()
			return TRUE
		if("withdraw")
			if(!candidate.ready)
				to_chat(user, span_warning("You need to submit an application before you can withdraw one."))
				return FALSE
			candidate.ready = FALSE
			to_chat(user, span_notice("Your pAI candidacy has been withdrawn."))
			return TRUE
	return FALSE

/datum/controller/subsystem/pai/proc/findPAI(obj/item/paicard/p, mob/user)
	if(!ghost_spam)
		ghost_spam = TRUE
		for(var/mob/dead/observer/G in GLOB.player_list)
			if(!G.key)
				continue
			if(!(ROLE_PAI in G.client.prefs.be_special))
				continue
			to_chat(G, "<span class='ghostalert'>[user.real_name] is requesting a pAI personality! Use the pAI button to submit yourself as one.</span>")
		addtimer(CALLBACK(src, PROC_REF(spam_again)), spam_delay)
	var/list/available = list()
	for(var/datum/paiCandidate/c in SSpai.candidates)
		available.Add(check_ready(c))
	var/dat = ""

	dat += {"
			<style type="text/css">

			p.top {
				background-color: #AAAAAA; color: black;
			}

			tr.d0 td {
				background-color: #CC9999; color: black;
			}
			tr.d1 td {
				background-color: #9999CC; color: black;
			}
			tr.d2 td {
				background-color: #99CC99; color: black;
			}
			</style>
			"}
	dat += "<p class=\"top\">Requesting AI personalities from central database... If there are no entries, or if a suitable entry is not listed, check again later as more personalities may be added.</p>"

	dat += "<table>"

	for(var/datum/paiCandidate/c in available)
		dat += "<tr class=\"d0\"><td>Name:</td><td>[c.name]</td></tr>"
		dat += "<tr class=\"d1\"><td>Description:</td><td>[c.description]</td></tr>"
		dat += "<tr class=\"d0\"><td>Preferred Role:</td><td>[c.role]</td></tr>"
		dat += "<tr class=\"d1\"><td>OOC Comments:</td><td>[c.comments]</td></tr>"
		dat += "<tr class=\"d2\"><td><a href='byond://?src=[REF(src)];download=1;candidate=[REF(c)];device=[REF(p)]'>\[Download [c.name]\]</a></td><td></td></tr>"

	dat += "</table>"

	user << browse(dat, "window=findPai")

/datum/paiCandidate
	var/name
	var/key
	var/description
	var/role
	var/comments
	var/ready = 0
