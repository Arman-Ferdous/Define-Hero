extends Area2D

func appear():
	visible = true
	$CollisionShape2D.disabled = false
	
func goto_next_level():
	var lev = str(get_parent().name)
	var next_lev = "level_" + str(int(lev) + 1)
	if next_lev == "level_9": next_lev = "Menu"
	print(lev, " -> ", next_lev)
	get_tree().change_scene_to_file("res://Scenes/" + str(next_lev) + ".tscn")
	
func restart_level():
	var lev = str(get_parent().name)
	lev = "level_" + str(int(lev))
	print("Restart level: " + lev)
	get_tree().change_scene_to_file("res://Scenes/" + str(lev) + ".tscn")
	
func _on_body_entered(body: Node2D) -> void:
	goto_next_level()
