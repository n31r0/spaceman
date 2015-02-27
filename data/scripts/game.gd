
extends Node2D
var time = 0
var best_score=0
var rockets 
var score
var status = "menu"
var old_level = "level1"

# For score saving
var level1 = [0,0]
var level2 = [0,0]
var level3 = [0,0]
var level4 = [0,0]
var level5 = [0,0]
var level6 = [0,0]
var level7 = [0,0]
var level8 = [0,0]
var level9 = [0,0]

var save_file = "res://save.dat"
#var save_settings = "usr://spaceman_settings.dat"

func _ready():
	get_node("music").play("background_intro")
	load_stats()
	set_process(true)
	get_node("../gui/menu_btn").connect("pressed",self,"_on_menu_pressed")
	get_node("../gui/game_over/restart_btn").connect("pressed",self,"_on_restart_pressed")
	get_node("../gui/game_over/menu_btn").connect("pressed",self,"_on_menu_pressed")
	get_node("../gui/game_over/next_btn").connect("pressed",self,"_on_next_pressed")
	get_node("../gui/level_complete/restart_btn").connect("pressed",self,"_on_restart_pressed")
	get_node("../gui/level_complete/menu_btn").connect("pressed",self,"_on_menu_pressed")
	get_node("../gui/level_complete/next_btn").connect("pressed",self,"_on_next_pressed")
	get_node("../gui/game_start/start_btn").connect("pressed",self,"_on_menu_pressed")
	
func _process(delta):
	if(get_node("../spawner").level_status == false && get_node("../player").health > 0):
		get_node("../spawner").level_status = true
		level_complete()
	if(get_node("../player").health <=0):
		game_over()

func game_over():
	status = "menu"
	get_node("timer").stop()
	score = time + (get_node("../player").health * 50)
	if( best_score < score):
		best_score = score
	get_node("../player/anim").play("death")
	get_node("../spawner/anim").stop()
	get_node("../gui/game_over").show()
	get_tree().call_group(0, "in_game_gui", "hide")
	get_node("../gui/game_over/best_score").set_text(str(best_score))
	get_node("../gui/game_over/score").set_text(str(score))
	
func game_start(level):
	status = "play"
	best_score = get_level_score(level)[1]
	rockets = get_level_score(level)[0]
	time = 0
	score = 0
	old_level = level
	get_tree().set_pause(false)
	get_node("../gui/level_selector").hide()
	get_node("../gui/help").hide()
	get_tree().call_group(0, "in_game_gui", "show")
	destroy_old_level()
	get_node("timer").start()
	get_node("../gui/level_complete").hide()
	get_node("../gui/game_over").hide()
	get_node("../gui/menu_btn").show()
	get_node("../gui/life").show()
	get_node("../spawner/anim").play(level)
	get_node("../player").set_pos(Vector2(50,142))
	get_node("../player").health = 3
	get_node("../player").speed = 40
	get_node("../player").direction = 1
	get_node("../player").show()
	get_node("../player/anim").play("idle")

func level_complete():
	status = "menu"
	get_node("timer").stop()
	score = time + (get_node("../player").health * 50) + get_node("../player").bonus_score
	if( best_score < score):
		best_score = score
	get_node("../gui/level_complete/rockets").draw_rockets()
	get_node("../player/anim").play("idle")
	get_node("../spawner/anim").stop()
	get_node("../gui/level_complete").show()
	get_tree().call_group(0, "in_game_gui", "hide")
	get_node("../gui/level_complete/best_score").set_text(str(best_score))
	get_node("../gui/level_complete/score").set_text(str(score))
	update_level_score(old_level, rockets, best_score)
	save_stats()

func level_select():
	get_tree().call_group(0, "in_game_gui", "hide")
	get_tree().set_pause(true)
	get_node("../gui/level_selector").show()

func show_menu():
	get_tree().call_group(0, "in_game_gui", "hide")
	get_tree().call_group(0, "menu_gui", "hide")
	get_tree().set_pause(true)
	get_node("../gui/level_selector").show()

func destroy_old_level():
	get_node("../gui/help").hide()
	get_tree().call_group(0, "enemies", "queue_free")
	get_tree().call_group(0, "powerups", "queue_free")

func _on_menu_pressed():
	show_menu()

func _on_restart_pressed():
	game_start(old_level)

func _on_start_pressed():
	get_node("../gui/game_start").hide()
	level_select()

func _on_next_pressed():
	game_start(get_next_level(old_level))

func _on_timer_timeout():
	time +=1

func get_level_score(level):
	if(level == "level1"):
		return level1
	if(level == "level2"):
		return level2
	if(level == "level3"):
		return level3
	if(level == "level4"):
		return level4
	if(level == "level5"):
		return level5
	if(level == "level6"):
		return level6
	if(level == "level7"):
		return level7
	if(level == "level8"):
		return level8
	if(level == "level9"):
		return level9

func get_next_level(level):
	var num = level.substr(5,10)
	var next_num = int(num) + 1
	var new_level
	if(next_num <= get_node("../spawner/anim").get_animation_list().size()):
		new_level = level.substr(0,5) + str(next_num)
	else:
		new_level = "level1"
	return new_level

func update_score(level, rocket, score):
	if(level[0] < rocket):
		level[0] = rocket
	if(level[1] < score):
		level[1] = score

func update_level_score(level, rocket, score):
	if(level == "level1"):
		update_score(level1, rocket, score)
	if(level == "level2"):
		update_score(level2, rocket, score)
	if(level == "level3"):
		update_score(level3, rocket, score)
	if(level == "level4"):
		update_score(level4, rocket, score)
	if(level == "level5"):
		update_score(level5, rocket, score)
	if(level == "level6"):
		update_score(level6, rocket, score)
	if(level == "level7"):
		update_score(level7, rocket, score)
	if(level == "level8"):
		update_score(level8, rocket, score)
	if(level == "level9"):
		update_score(level9, rocket, score)

func save_stats():
	var file = File.new()
	file.open_encrypted_with_pass(save_file, File.WRITE, OS.get_unique_ID())
	if(file.is_open()):
		file.store_var(level1)
		file.store_var(level2)
		file.store_var(level3)
		file.store_var(level4)
		file.store_var(level5)
		file.store_var(level6)
		file.store_var(level7)
		file.store_var(level8)
		file.store_var(level9)
		file.close()
	else:
		print("Can't open " + str(save_file))

func load_stats():
	var file = File.new()
	file.open_encrypted_with_pass(save_file, File.READ, OS.get_unique_ID())
	if(file.is_open()):
		level1 = file.get_var()
		level2 = file.get_var()
		level3 = file.get_var()
		level4 = file.get_var()
		level5 = file.get_var()
		level6 = file.get_var()
		level7 = file.get_var()
		level8 = file.get_var()
		level9 = file.get_var()
		file.close()
	else:
		print("Can't open " + str(save_file))