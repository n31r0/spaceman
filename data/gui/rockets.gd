
extends Node2D
var rockets

func _ready():
	pass
	
func draw_rockets():
	if(get_node("../../../game").best_score >= get_node("../../../spawner").stars_3):
		get_node("anim").play("rockets_full")
		get_node("../../../game").rockets = 3
		rockets = 3
	elif(get_node("../../../game").best_score >= get_node("../../../spawner").stars_2 && get_node("../../../game").score < get_node("../../../spawner").stars_3):
		get_node("anim").play("rockets_2")
		get_node("../../../game").rockets = 2
		rockets = 2
		#print(rockets)
	elif(get_node("../../../game").best_score >= get_node("../../../spawner").stars_1 && get_node("../../../game").score < get_node("../../../spawner").stars_2):
		get_node("anim").play("rockets_1")
		get_node("../../../game").rockets = 1
		rockets = 1
		#print(rockets)
	elif(get_node("../../../game").score < get_node("../../../spawner").stars_1):
		get_node("anim").play("rockets_null")
		get_node("../../../game").rockets = 0
		rockets = 0
		#print(rockets)