extends Control
@onready var player = get_node("../../player")

func resume():
	get_tree().paused = false
	hide()
	
func pause():
	show()
	get_tree().paused = true
	
func testEsc():
	if Input.is_action_just_pressed("escape"):
		if get_tree().paused == false:
			pause()
		else: resume()

func _on_resume_pressed() -> void:
	resume()
	
func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _process(delta: float) -> void:
	if player.player_HP <= 0: return
	testEsc()
