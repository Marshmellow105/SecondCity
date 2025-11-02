// NORMAL CHAIRS

/obj/structure/chair
	icon = 'modular_darkpack/modules/chairs/icons/vampchairs.dmi'
	icon_state = "chair"
	post_init_icon_state = "chair"
	greyscale_colors = "#D4D4D4"
	greyscale_config = /datum/greyscale_config/darkpack_chair

/datum/greyscale_config/darkpack_chair
    name = "Darkpack Chair"
    icon_file = 'modular_darkpack/modules/chairs/icons/vampchairs.dmi'
    json_config = 'code/datums/greyscale/json_configs/darkpack_chairs.json'

/obj/structure/chair/red
	greyscale_colors = "#843330"

/obj/structure/chair/blue
	greyscale_colors = "#394c65"

/obj/structure/chair/green
	greyscale_colors = "#314e4b"

// OFFICE CHAIRS

/obj/structure/chair/office
	icon = 'modular_darkpack/modules/chairs/icons/vampchairs.dmi'
	icon_state = "office"
	post_init_icon_state = "office"
	greyscale_colors = "#D4D4D4"
	greyscale_config = /datum/greyscale_config/darkpack_chair_office

/datum/greyscale_config/darkpack_chair_office
    name = "Darkpack Office Chair"
    icon_file = 'modular_darkpack/modules/chairs/icons/vampchairs.dmi'
    json_config = 'code/datums/greyscale/json_configs/darkpack_chairs_office.json'

/obj/structure/chair/office/red
	greyscale_colors = "#843330"

/obj/structure/chair/office/blue
	greyscale_colors = "#394c65"

/obj/structure/chair/office/green
	greyscale_colors = "#314e4b"

// STOOLS

/obj/structure/chair/stool/bar
	icon = 'modular_darkpack/modules/chairs/icons/vampchairs.dmi'
	icon_state = "bar"
	post_init_icon_state = "bar"
	greyscale_colors = "#D4D4D4"
	greyscale_config = /datum/greyscale_config/darkpack_chair_bar

/datum/greyscale_config/darkpack_chair_bar
    name = "Darkpack Bar Stool"
    icon_file = 'modular_darkpack/modules/chairs/icons/vampchairs.dmi'
    json_config = 'code/datums/greyscale/json_configs/darkpack_chairs_bar.json'

/obj/structure/chair/stool/bar/red
	greyscale_colors = "#843330"

/obj/structure/chair/stool/bar/blue
	greyscale_colors = "#394c65"

/obj/structure/chair/stool/bar/green
	greyscale_colors = "#314e4b"
