
extends AnimatedSprite
var anim
var speed = 5
func _ready():
	set_process(true)

func _process(delta):
	var pos = get_pos()
	pos.x += speed * delta
	pos.y = 30 + sin(pos.x)
	if (pos.x > 120):
		pos.x = -250
	set_pos(pos)


