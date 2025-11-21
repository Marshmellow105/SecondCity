// FOUR LEGGED CHAIRS / OBJECTS

/obj/structure/chair/vampire
	icon = 'modular_darkpack/modules/chairs/icons/chairs.dmi'
	icon_state = "chair"

/obj/structure/chair/vampire/blue
	icon_state = "chair_blue"

/obj/structure/chair/vampire/green
	icon_state = "chair_green"

/obj/structure/chair/vampire/red
	icon_state = "chair_red"

// FOUR LEGGED CHAIRS / ITEMS

/obj/item/chair/vampire
	icon = 'modular_darkpack/modules/chairs/icons/chairs.dmi'
	icon_state = "chair_toppled"
	inhand_icon_state = "chair"

/obj/item/chair/vampire/blue
	icon_state = "chair_blue_toppled"

/obj/item/chair/vampire/green
	icon_state = "chair_green_toppled"

/obj/item/chair/vampire/red
	icon_state = "chair_red_toppled"

// PLASTIC CHAIR / OBJECTS

/obj/structure/chair/plastic/vampire
	icon = 'modular_darkpack/modules/chairs/icons/chairs.dmi'
	icon_state = "plastic_chair"
	name = "plastic chair"

// PLASTIC CHAIR / ITEMS

/obj/item/chair/plastic/vampire
	name = "plastic chair"
	icon = 'modular_darkpack/modules/chairs/icons/chairs.dmi'
	icon_state = "folded_chair"

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
