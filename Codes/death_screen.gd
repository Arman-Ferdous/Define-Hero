extends Control

func _ready() -> void:
	hide()

func player_died():
	show()
	get_tree().paused = true
	#$AnimationPlayer.play("new_animation")
	
func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()
