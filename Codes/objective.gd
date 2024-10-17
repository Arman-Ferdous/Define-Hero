extends Area2D
@onready var end_level: Area2D = $"../end_level"

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "player":
		end_level.goto_next_level()
