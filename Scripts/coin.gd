extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var canvas_layer: CanvasLayer = %CanvasLayer



func _on_body_entered(body: Node2D) -> void:
		canvas_layer.add_point()
		animation_player.play("pickup")
