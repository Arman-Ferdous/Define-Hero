extends Area2D

@onready var boss: CharacterBody2D = $"../boss"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		boss.position = Vector2(736, -128)
		queue_free()
		
