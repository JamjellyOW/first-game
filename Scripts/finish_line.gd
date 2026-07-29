extends Area2D

@onready var finish_screen: CanvasLayer = $FinishScreen
@onready var hud: CanvasLayer = %CanvasLayer

func _on_body_entered(body: Node2D) -> void:
	#Stop the HUD timer
	hud.is_timer_active = false
	
	finish_screen.update_display(hud.score, hud.format_time(hud.time_elapsed))
	
	get_tree().paused = true
	finish_screen.visible = true
	
	%PauseMenu.can_pause = false
