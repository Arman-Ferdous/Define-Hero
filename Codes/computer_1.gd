extends Area2D

@onready var help_2: Label = $"../../help2"
@onready var lasers: Node = $"../../Lasers"
@onready var end_level: Area2D = $"../../end_level"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	if $AnimatedSprite2D.frame == 1: return
	if body.name == "player":
		$Timer.start()
		audio_stream_player_2d.play()
	
func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		$Timer.stop()
		audio_stream_player_2d.stop()

func _on_timer_timeout() -> void:
	if $AnimatedSprite2D.frame == 1:
		return
	audio_stream_player_2d.stop()
	print("Hacked!!")
	$AnimatedSprite2D.frame += 1
	var count = int(help_2.text[26]) + 1
	help_2.text = "Hack computers to disable\n" + str(count) + "/5"
	if count == 5:
		lasers.queue_free()
		end_level.appear()
		
