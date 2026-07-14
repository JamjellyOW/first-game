extends Node

var last_location: Vector2
#var player

func _ready() -> void:
	#player = get_parent().get_node("Player")
	#last_location = player.global_position
	# Wait a frame or look up the player safely once the active scene is loaded
	await get_tree().process_frame
	
	var player = get_tree().current_scene.find_child("Player", true, false)
	if player:
		last_location = player.global_position
