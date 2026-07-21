extends Area2D

@onready var finish_screen: CanvasLayer = $FinishScreen


func _on_body_entered(body: Node2D) -> void:
	get_tree().paused = true
	finish_screen.visible = true
	
	%PauseMenu.can_pause = false
