// FOUR LEGGED CHAIRS / OBJECTS

/obj/structure/chair/vampire
	icon = 'modular_darkpack/modules/chairs/icons/chairs.dmi'
	icon_state = "chair"
	item_chair = /obj/item/chair/vampire

/obj/structure/chair/vampire/blue
	icon_state = "chair_blue"
	item_chair = /obj/item/chair/vampire/blue

/obj/structure/chair/vampire/green
	icon_state = "chair_green"
	item_chair = /obj/item/chair/vampire/green

/obj/structure/chair/vampire/red
	icon_state = "chair_red"
	item_chair = /obj/item/chair/vampire/red

// FOUR LEGGED CHAIRS / ITEMS

/obj/item/chair/vampire
	icon = 'modular_darkpack/modules/chairs/icons/chairs.dmi'
	icon_state = "chair_toppled"
	inhand_icon_state = "chair"
	origin_type = /obj/structure/chair/vampire

/obj/item/chair/vampire/blue
	icon_state = "chair_blue_toppled"
	origin_type = /obj/structure/chair/vampire/blue

/obj/item/chair/vampire/green
	icon_state = "chair_green_toppled"
	origin_type = /obj/structure/chair/vampire/green

/obj/item/chair/vampire/red
	icon_state = "chair_red_toppled"
	origin_type = /obj/structure/chair/vampire/red

// PLASTIC CHAIR / OBJECTS

/obj/structure/chair/plastic/vampire
	icon = 'modular_darkpack/modules/chairs/icons/chairs.dmi'
	icon_state = "plastic_chair"
	name = "plastic chair"
	item_chair = /obj/item/chair/plastic/vampire

// PLASTIC CHAIR / ITEMS

/obj/item/chair/plastic/vampire
	name = "plastic chair"
	icon = 'modular_darkpack/modules/chairs/icons/chairs.dmi'
	icon_state = "folded_chair"
	origin_type = /obj/structure/chair/plastic/vampire

// OFFICE CHAIRS / OBJECTS

/obj/structure/chair/office/vampire
	icon_state = "officechair"
	icon = 'modular_darkpack/modules/chairs/icons/chairs.dmi'

/obj/structure/chair/office/vampire/blue
	icon_state = "officechair_blue"

/obj/structure/chair/office/vampire/green
	icon_state = "officechair_green"

/obj/structure/chair/office/vampire/red
	icon_state = "officechair_red"

// BARSTOOLS / OBJECTS

/obj/structure/chair/stool/bar/vampire
	icon = 'modular_darkpack/modules/chairs/icons/chairs.dmi'
	icon_state = "bar"
	item_chair = /obj/item/chair/stool/bar/vampire

/obj/structure/chair/stool/bar/vampire/red
	icon_state = "bar_red"
	item_chair = /obj/item/chair/stool/bar/vampire/red

// BARSTOOLS / ITEMS

/obj/item/chair/stool/bar/vampire
	icon = 'modular_darkpack/modules/chairs/icons/chairs.dmi'
	icon_state = "bar_toppled"
	origin_type = /obj/structure/chair/stool/bar/vampire

/obj/item/chair/stool/bar/vampire/red
	icon_state = "bar_red_toppled"
	origin_type = /obj/structure/chair/stool/bar/vampire/red

// WOODEN CHAIRS / OBJECTS

/obj/structure/chair/wood/vampire
	icon = 'modular_darkpack/modules/chairs/icons/chairs.dmi'
	icon_state = "wooden_chair"
	resistance_flags = FLAMMABLE
	item_chair = /obj/item/chair/wood/vampire

/obj/structure/chair/wood/vampire/red
	icon = 'modular_darkpack/modules/chairs/icons/chairs.dmi'
	icon_state = "wooden_chair_red"
	resistance_flags = FLAMMABLE
	item_chair = /obj/item/chair/wood/vampire/red

// WOODEN CHAIRS / ITEMS

/obj/item/chair/wood/vampire
	icon = 'modular_darkpack/modules/chairs/icons/chairs.dmi'
	icon_state = "wooden_chair_toppled"
	inhand_icon_state = "woodenchair"
	origin_type = /obj/structure/chair/wood/vampire

/obj/item/chair/wood/vampire/red
	icon_state = "wooden_chair_red_toppled"
	inhand_icon_state = "woodenchair"
	origin_type = /obj/structure/chair/wood/vampire/red

// COMFY CHAIRS / OBJECTS

/obj/structure/chair/comfy/vampire
	icon_state = "comfy"

/obj/structure/chair/comfy/vampire/dark
	icon_state = "comfy_dark"

/obj/structure/chair/comfy/vampire/blue
	icon_state = "comfy_blue"

/obj/structure/chair/comfy/vampire/green
	icon_state = "comfy_green"

/obj/structure/chair/comfy/vampire/red
	icon_state = "comfy_red"
