
extends Node2D

var anim
var anim_new
var anim_state

func _ready():
	add_to_group("in_game_gui")
	anim = get_node("anim")
	set_process(true)
	
func _process(deltatime):
	if anim_state != anim_new:
		anim_new = anim_state
		anim.play(anim_state)
	
	if(get_node("../../player").health == 3):
		anim_state = "life_full"
	elif(get_node("../../player").health == 2):
		anim_state = "life_half"
	elif(get_node("../../player").health == 1):
		anim_state = "life_low"


