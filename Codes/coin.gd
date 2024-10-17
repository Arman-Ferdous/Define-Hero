extends Area2D

#@onready var game_manager: Node = %GameManager
#@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body):
	#print(body.name, " touched ", name)
	#game_manager.add_point()
	animation_player.play("pickup")
	audio_stream_player_2d.play()
