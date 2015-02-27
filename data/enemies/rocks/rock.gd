
extends Node2D
var speed = 40
var anim
var is_destroyed = false
var explosions = ["explosion1", "explosion2", "explosion3", "explosion4"]

func _ready():
	anim = get_node("anim")
	anim.play("fall")
	set_process(true)

func _process(delta):
	var pos = get_pos()
	pos.y += speed*delta
	set_pos(pos)
	
func blast():
	randomize()
	var rand = rand_range(0, explosions.size())
	get_node("sound").play(explosions[rand])
	anim.play("blast")
	get_node("Sprite").hide()
	is_destroyed = true