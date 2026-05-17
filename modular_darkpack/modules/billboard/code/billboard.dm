/obj/structure/billboard/darkpack
	name = "billboard"
	desc = "A billboard, displaying a large advertisement."
	icon = 'modular_darkpack/modules/billboard/icons/billboards.dmi'
	icon_state = "billboard_blank"

/obj/structure/billboard/darkpack/random

/obj/structure/billboard/darkpack/random/Initialize(mapload)
	. = ..()
	icon_state = "billboard_[rand(1, 11)]"
