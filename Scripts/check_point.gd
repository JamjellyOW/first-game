extends Area2D

#@onready var checkpoint_manager: Node = %CheckpointManager

func _on_body_entered(body: Node2D) -> void:
	#checkpoint_manager.last_location = $RespawnPoint.global_position
	if body.name == "Player":
		# Update the global Autoload directly
		CheckpointManager.last_location = $RespawnPoint.global_position
		
