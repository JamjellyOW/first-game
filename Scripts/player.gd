extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var floor_ray_cast: RayCast2D = $floorRayCast

@export var ice_acceleration: float = 200.0
@export var ice_friction: float = 60.0

@export var ice_memory_time: float = 0.25 # Time in seconds to retain ice physics off ledges
var ice_timer: float = 0.0                # Counts down after leaving ice

var was_on_ice: bool = false

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
	# Check if standing on ice and refresh timer
	if is_on_floor() and _is_on_ice():
		ice_timer = ice_memory_time
	else:
		# Count down timer when off ice or in air
		ice_timer = max(0.0, ice_timer - delta)
	
	# If the ice timer is active, maintain ice physics
	if ice_timer > 0.0:
		_movement_on_ice(direction, delta)
	else:
		_normal_movement(direction)
	
	move_and_slide()

func _movement_on_ice(direction: float, delta: float) -> void:
		if direction != 0:
			velocity.x = move_toward(velocity.x, direction * SPEED, ice_acceleration * delta)
		else:
			velocity.x = move_toward(velocity.x, 0.0, ice_friction * delta)
		

func _normal_movement(direction):
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		# Only quickly decelerate if we are actually grounded
		if is_on_floor():
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
