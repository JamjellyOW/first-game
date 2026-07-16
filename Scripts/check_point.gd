extends Area2D

#@onready var checkpoint_manager: Node = %CheckpointManager
var is_activated: bool = false



func _on_body_entered(body: Node2D) -> void:
	#checkpoint_manager.last_location = $RespawnPoint.global_position
	
	if is_activated or body.name != "Player":
		return
	
	is_activated = true
	
	if body.name == "Player":
		# Update the global Autoload directly
		CheckpointManager.last_location = $RespawnPoint.global_position
		
