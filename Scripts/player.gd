extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var floor_ray_cast: RayCast2D = $floorRayCast

#for faster acceleration increase val
@export var accelerationVal = 0.01
# for longer sliding time reduce value
@export var slideValue = 0.01
@export var fullStopValue = 15


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# Get input direction, -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	#Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	#Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	#on ice
	if _is_on_ice():
		_movement_on_ice(direction)
	else:
		_normal_movement(direction)
	
	move_and_slide()

func _movement_on_ice(direction):
	if direction:
		velocity.x = lerp(velocity.x, direction * SPEED, accelerationVal)
	else:
		velocity.x = lerp(velocity.x, 0.0, slideValue)
		
		if velocity.x < fullStopValue and velocity.x > -fullStopValue:
			velocity.x = 0
		

func _normal_movement(direction):
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func _is_on_ice() -> bool:
	if not floor_ray_cast.is_colliding():
		return false
	
	var collider = floor_ray_cast.get_collider()
	
	if collider is TileMapLayer:
	# Get the exact global coordinates where the raycast hit
		var collision_point = floor_ray_cast.get_collision_point()
		# Adjust slightly inward along the ray direction to ensure we target the right cell
		var local_point = collider.to_local(collision_point + floor_ray_cast.target_position.normalized() * 0.1)
		var cell_coords = collider.local_to_map(local_point)
		
		# Get the data container for that specific tile
		var tile_data = collider.get_cell_tile_data(cell_coords)
		
		if tile_data:
			# Read the custom data layer we created
			return tile_data.get_custom_data("is_ice")
			
	return false
