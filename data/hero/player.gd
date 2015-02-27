
extends AnimatedSprite

var speed = 40
var reverse = 1

var direction = 0
var player_movement
var anim
var anim_new
var anim_state
var body
var game_status
var health = 3
var bonus_score = 0

func _ready():
	body = get_node("body")
	anim = get_node("anim")
	set_process(true)
	set_process_input(true)

func _process(deltatime):
	game_status = get_node("../game").status
	if anim_state != anim_new:
		anim_new = anim_state
		anim.play(anim_state)
	
	if (health > 0 && game_status == "play"):
		if Input.is_action_pressed("go_right") or player_movement == "right":
			go_right()
		elif Input.is_action_pressed("go_left") or player_movement == "left":
			go_left()
		else:
			anim_state = "idle"
			direction = 0
	if (game_status == "menu"):
		speed = 0
	
	var pos = get_pos()
	pos.x += speed * deltatime * direction * reverse
	pos = bound_pos(pos)
	set_pos(pos)
	
	var things = body.get_overlapping_bodies()
	if (things.size() != 0):
		for thing in things:
			if (thing.is_in_group("powerups") && thing.is_destroyed == false):
				if (thing.type == "health"):
					bonus_score -= 20
					thing.blast()
					if(health < 3):
						health += 1
				if (thing.type == "speed"):
					bonus_score += 30
					thing.blast()
					get_node("speed").play("speed")
				if (thing.type == "reverse"):
					bonus_score += 100
					thing.blast()
					get_node("reverse").play("reverse")
			if (thing.is_in_group("enemies") && thing.is_destroyed == false):
				thing.blast()
				health -= 1
				if (anim_state == "idle"):
					anim.play("hit")

func powerup_speed(s):
	speed = s

func powerup_reverse(r):
	reverse *= r
	if (reverse == -1):
		get_node("../game/sounds").play("moonwalk")

func bound_pos(pos):
	if pos.x > 91:
		pos.x = 91
	if pos.x < 5:
		pos.x = 5
	return pos

func go_right():
	set_flip_h(false)
	anim_state = "walk"
	direction = 1.0

func go_left():
	set_flip_h(true)
	anim_state = "walk"
	direction = -1.0

func _input(event):
	if (event.type==InputEvent.SCREEN_TOUCH || event.type==InputEvent.MOUSE_BUTTON || event.type==InputEvent.SCREEN_DRAG):
		
		if (event.pressed and get_pos().x < event.x/5):
			player_movement = "right"
		elif (event.pressed and get_pos().x > event.x/5):
			player_movement = "left"
		else:
			player_movement = "stay"