extends AnimationPlayer

#@onready var cutscene: AnimationPlayer = $"../cutscene"
@onready var player = get_node("../player")
@onready var timer: Timer = $Timer

var isPlayedAlready = false

func _on_cutscene_enter_body_entered(_body: Node2D) -> void:
	if !isPlayedAlready:
		isPlayedAlready = true
		player.animationPlaying = true
		
		print(player.animationPlaying)
		print("play cutscene 1")
		timer.start()
		play("cutscene")
		
func _on_timer_timeout() -> void:
	player.animationPlaying = false
	print("Done playing!")
	timer.stop()
	#queue_free()
