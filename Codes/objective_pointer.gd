extends AnimatedSprite2D

@onready var player = get_node("../player")

var now = 0
var locs = [Vector2(908, -156)]

func objective_complete():
	now += 1
	if now >= len(locs):
		queue_free()

func _physics_process(delta: float) -> void:
	var v = (locs[now] - player.position).normalized() * 20
	position = player.position + v
