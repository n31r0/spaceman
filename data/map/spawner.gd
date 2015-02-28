
extends Node2D

var level_status = true
var stars_3 
var stars_2 
var stars_1 
var pos_x = [5, 15, 25, 35, 45, 55, 65, 75, 85, 95]
var orb_type = ["health", "speed"]
var rand_pos
var rand_orb
var loop_speed = 0
func _ready():
	set_process(true)

func _process(delta):
	rand_pos = int(rand_range(0,10))
	rand_orb = int(rand_range(0,2))

func spawn(x_offset, speed):
	var rock_scn = load("res://rock.scn")
	var rock = rock_scn.instance()
	rock.set_pos(Vector2(x_offset, -10))
	rock.speed = speed
	rock.add_to_group("enemies")
	add_child(rock)

func spawn_cloud(speed, y_offset):
	var clouds_scn = load("res://clouds.scn")
	var cloud = clouds_scn.instance()
	cloud.speed = speed
	cloud.set_pos(Vector2(-50,y_offset))
	add_child(cloud)

func orb(type, x_offset, speed):
	var orb_scn = preload("res://data/containers/orb.scn")
	var orb = orb_scn.instance()
	orb.type = type
	orb.speed = speed
	orb.set_pos(Vector2(x_offset, -10))
	orb.add_to_group("powerups")
	add_child(orb)

func lvl_status(status):
	 level_status = status

func high_score(h_score,m_score,l_score):
	stars_3 = h_score
	stars_2 = m_score
	stars_1 = l_score

func survival(num):
	var i = 0
	get_node("survival").set_speed(rand_range(1,3))
	if(rand_pos == 8):
		rand_pos = int(rand_range(0,10))
		orb(orb_type[rand_orb], pos_x[rand_pos], 50+get_node("../game").time)
	else:
		while(i<rand_pos):
			rand_pos = int(rand_range(0,10))
			spawn(pos_x[rand_pos], 50+(get_node("../game").time/2))
			i += 1