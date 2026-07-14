extends Area2D

#@onready var checkpoint_manager: Node = %CheckpointManager
#@onready var player: CharacterBody2D = $"../Player"


func _on_body_entered(body: Node2D) -> void:
	# Check if the object entering the zone is actually the player
	#However, check might be unnecessary cause player only thing with collision layer 2 
	if body.name == "Player":
		print("You died!")
		# Use 'body' directly to move the player, and the global Autoload name (Capitalized)
		body.global_position = CheckpointManager.last_location
