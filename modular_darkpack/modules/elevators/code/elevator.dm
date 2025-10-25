/obj/machinery/door/airlock/elevator //I know this is fucked up but I think this is the only door/airlock without overlays/panels
	name = "Elevator Door"
	icon = 'modular_darkpack/modules/elevators/icons/doorleft.dmi'
	icon_state = "closed"
	doorOpen = 'modular_darkpack/modules/elevators/sounds/elevatoropen.ogg'
	doorClose = 'modular_darkpack/modules/elevators/sounds/elevatorclose.ogg'
	doorDeni = null
	boltUp = null
	boltDown = null


	elevator_mode = TRUE
	overlays_file = null

/obj/machinery/door/airlock/elevator/left
	icon = 'modular_darkpack/modules/elevators/icons/doorleft.dmi'
	assemblytype = /obj/structure/door_assembly/elevator/left

/obj/machinery/door/airlock/elevator/right
	icon = 'modular_darkpack/modules/elevators/icons/doorright.dmi'
	assemblytype = /obj/structure/door_assembly/elevator/right

/obj/machinery/door/airlock/elevator/multi_tile
	icon = 'modular_darkpack/modules/elevators/icons/doordouble.dmi'
	assemblytype = /obj/structure/door_assembly/elevator/multi_tile
	multi_tile = TRUE

/obj/machinery/door/airlock/elevator/multi_tile/setDir(newdir)
	. = ..()
	set_bounds()

/obj/structure/door_assembly/elevator/
	name = "door assembly"
	base_name = "Elevator Door"
	icon = 'modular_darkpack/modules/elevators/icons/doorleft.dmi'
	icon_state = "construction"
	overlays_file = null
	anchored = FALSE
	density = TRUE

/obj/structure/door_assembly/elevator/left
	icon = 'modular_darkpack/modules/elevators/icons/doorleft.dmi'

/obj/structure/door_assembly/elevator/left
	icon = 'modular_darkpack/modules/elevators/icons/doorright.dmi'

/obj/structure/door_assembly/elevator/multi_tile
	name = "door assembly"
	icon = 'modular_darkpack/modules/elevators/icons/doordouble.dmi'
	airlock_type = /obj/machinery/door/airlock/elevator/multi_tile
	dir = EAST
	multi_tile = TRUE
