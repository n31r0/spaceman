
extends Node2D

var level_status = true
var stars_3 
var stars_2 
var stars_1 

func _ready():
	pass
	
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