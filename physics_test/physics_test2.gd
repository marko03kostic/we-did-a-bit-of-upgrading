extends Node3D

var block = preload("res://physics_test/block/block.tscn")
var is_mouse_button_down : bool = false
var spawn_block = false
var block_instance
@onready var placement_collision: CollisionShape3D = $StaticBody3D2/placement_collision
@export var placement_spacing : float = 1.0 #how much it moves each step

func _ready() -> void:
	placement_collision.position.y = 3.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	#if mouse_left_down:
		##cast_ray_from_camera_to_mouse()
		#print("mouse down")
	#print(mouse_left_down)
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Mouse button is pressed, set the flag
				is_mouse_button_down = true
				#print("Mouse button pressed")
				block_instance = block.instantiate()
				block_instance.freeze = true
				add_child(block_instance)

			else:
				# Mouse button is released, unset the flag
				is_mouse_button_down = false
				block_instance.freeze = false
				placement_collision.position.y += placement_spacing
				#print("Mouse button released")
	
	# Handle mouse motion events (dragging)
	if event is InputEventMouseMotion and is_mouse_button_down:
		# Perform actions while dragging with the mouse button down
		#print("Dragging with mouse button down")
		cast_ray_from_camera_to_mouse()

func cast_ray_from_camera_to_mouse() -> void:

	# Get the mouse position within the viewport
	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()
	# Convert the mouse position to a 3D ray origin and direction
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 1000  # Length of the ray

	# Perform the raycast
	var space_state = get_world_3d().get_direct_space_state()
	var params = PhysicsRayQueryParameters3D.new()
	params.from = from
	params.to = to
	params.exclude = []

	params.collision_mask = 2 #raycast collision layer
	var result = space_state.intersect_ray(params)
	# Check if the ray hit something
	if result:
		block_instance.position.x = result.position.x
		block_instance.position.z = result.position.z
		block_instance.position.y = placement_collision.position.y
	else:
		print("Ray did not hit anything.")
