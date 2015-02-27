
extends Node2D

var speed = 40
var type
var is_destroyed = false

func _ready():
	set_process(true)
	if (type == "health"):
		get_node("H").show()
	elif(type == "reverse"):
		get_node("R").show()
	elif(type == "speed"):
		get_node("S").show()

func _process(delta):
	var pos = get_pos()
	pos.y += speed*delta
	set_pos(pos)
	
func blast():
	get_node("sound").play("powerup1")
	get_node(".").hide()
	is_destroyed = true