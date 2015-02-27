
extends Node2D
var rand = int(rand_range(1,4))
var speed

func _ready():
	get_node("cloud" + str(rand)).show()
	set_process(true)

func _process(delta):
	var pos = get_pos()
	pos.x += speed * delta
	set_pos(pos)



