
extends Area2D

func _ready():
	set_process(true)

func _process(delta):
	var things = get_overlapping_bodies()
	if things.size() != 0:
		for thing in things:
			if (thing.is_destroyed == false && thing.is_in_group("enemies")):
				get_node("../anim").play("quake")
				thing.blast()