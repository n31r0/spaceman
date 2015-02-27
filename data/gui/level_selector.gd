
extends Control

var levels_sum = 9
var level_count = 1

var x_offset = 0
var y_offset = 0

func _ready():
	levels_sum = get_node("../../spawner/anim").get_animation_list().size()
	set_process(true)
	while(level_count <= levels_sum):
		x_offset = 0
		for level in range(3):
			draw_node(x_offset,y_offset, level_count)
			x_offset += 150
			level_count += 1
			if(level_count > levels_sum):
				break
		y_offset += 150

func draw_node(x_offset, y_offset, level_number):
	var level = get_node("level").duplicate()
	level.set_pos(Vector2(x_offset, y_offset))
	level.get_node("label").set_text(str(level_number))
	level.show()
	add_child(level)
	