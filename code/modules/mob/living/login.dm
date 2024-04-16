/mob/living/Login()
	. = ..()
	if(!. || !client)
		return FALSE

	//Mind updates
	sync_mind()

	update_damage_hud()
	update_health_hud()


	var/virtual_z = virtual_z()
	LAZYADDASSOCLIST(SSmobs.players_by_virtual_z, "[virtual_z]", src)
	SSidlenpcpool.try_wakeup_virtual_z(virtual_z)

	//Vents
	notify_ventcrawler_on_login()

	med_hud_set_status()

	update_fov_client()
