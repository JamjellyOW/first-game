extends CanvasLayer


func _on_start_button_pressed() -> void:
	#print("Start")
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_quit_button_pressed() -> void:
	#print("Quit")
	get_tree().quit() 
