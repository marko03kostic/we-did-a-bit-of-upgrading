extends Node3D

var block = preload("res://physics_test/block/block.tscn")

func _ready() -> void:
	for n in range(1,10):
		var block_instance = block.instantiate()
		add_child(block_instance)
		block_instance.position.y = n
		
	
	var block_instance = block.instantiate()
	add_child(block_instance)
	block_instance.position.y = 12

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		cast_ray_from_camera_to_mouse()

func cast_ray_from_camera_to_mouse():

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

	params.collision_mask = 1
	var result = space_state.intersect_ray(params)
	# Check if the ray hit something
	if result:
		print("Ray hit: ", result.position)
		print("Collider: ", result.collider)
		var block_instance = block.instantiate()
		block_instance.position = result.position
		add_child(block_instance)
	else:
		print("Ray did not hit anything.")
