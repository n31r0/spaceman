
extends Control
var level_number = 0

func _ready():
	level_number = "level" + get_node("label").get_text()
	get_node("level_btn").connect("pressed",self,"_on_level_pressed")
	set_process(true)

func _process(delta):
	load_score(level_number)

func _on_level_pressed():
	get_node("../../../game").game_start(level_number)

func load_score(level):
	if(level == "level1"):
		play_anim(get_node("../../../game").level1[0])
	if(level == "level2"):
		play_anim(get_node("../../../game").level2[0])
	if(level == "level3"):
		play_anim(get_node("../../../game").level3[0])
	if(level == "level4"):
		play_anim(get_node("../../../game").level4[0])
	if(level == "level5"):
		play_anim(get_node("../../../game").level5[0])
	if(level == "level6"):
		play_anim(get_node("../../../game").level6[0])
	if(level == "level7"):
		play_anim(get_node("../../../game").level7[0])
	if(level == "level8"):
		play_anim(get_node("../../../game").level8[0])
	if(level == "level9"):
		play_anim(get_node("../../../game").level9[0])

func play_anim(score):
	if(score == 3):
		get_node("rocket1").set_modulate(Color(1,1,1,1))
		get_node("rocket2").set_modulate(Color(1,1,1,1))
		get_node("rocket3").set_modulate(Color(1,1,1,1))
	elif(score == 2):
		get_node("rocket1").set_modulate(Color(1,1,1,1))
		get_node("rocket2").set_modulate(Color(0,0,0,0.33))
		get_node("rocket3").set_modulate(Color(1,1,1,1))

	elif(score == 1):
		get_node("rocket1").set_modulate(Color(1,1,1,1))
		get_node("rocket2").set_modulate(Color(0,0,0,0.33))
		get_node("rocket3").set_modulate(Color(0,0,0,0.33))
	else:
		get_node("rocket1").set_modulate(Color(0,0,0,0.33))
		get_node("rocket2").set_modulate(Color(0,0,0,0.33))
		get_node("rocket3").set_modulate(Color(0,0,0,0.33))