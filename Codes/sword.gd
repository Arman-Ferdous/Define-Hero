extends Area2D

#@onready var game_manager: Node = %GameManager
#@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body):
	if body.name != "player": return
	print(body.name, " touched ", name)
	body.hasSword = true
	#queue_free()
	$sprite2d.visible = false
	$CollisionShape2D.disabled = true
	$AudioStreamPlayer2D.play()
	#game_manager.add_point()
	animation_player.play("pickup")
