extends CanvasLayer

var can_pause: bool = true

func _ready() -> void:
	visible = false
	get_tree().paused = false


func _input(event: InputEvent) -> void:
		if not can_pause: return #Prevents pause if pause disabled
		
		if Input.is_action_just_pressed("pause"):
			if get_tree().paused:
				visible = false
				get_tree().paused = false
			else:
				visible = true
				get_tree().paused = true


func _on_button_pressed() -> void:
	visible = false
	get_tree().paused = false
