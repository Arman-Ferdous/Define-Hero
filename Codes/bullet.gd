extends Area2D

@export var from = Vector2.ZERO
@export var to = Vector2.ZERO
var SPEED = 800

func _physics_process(delta: float) -> void:
	if from != Vector2.ZERO or to != Vector2.ZERO:
		position += (to - from).normalized() * SPEED * delta
	#move_and_slide()

func _on_body_entered(body: Node2D) -> void:
	#print(body.name, " on bullet")
	if body == null:
		return
	if "guard" in body.name or "minion" in body.name or "boss" in body.name:
		return
	if body.name == "player":
		body.take_damage(20)
	queue_free()
