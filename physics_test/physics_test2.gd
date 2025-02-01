extends Node3D

@onready var block:PackedScene = Globals.get_selected_block().scene
var is_mouse_button_down : bool = false
var spawn_block = false
var block_instance
@onready var placement_collision: CollisionShape3D = $StaticBody3D2/placement_collision
@export var placement_height : float = 3.0
@export var placement_spacing : float = 1.0 #how much it moves each step
@onready var placement_ray: ShapeCast3D = $placement_ray
@export var placement_offset : float = 5.0
@onready var finish_line: CollisionShape3D = $finish_area/finish_line
@onready var finish_area: Area3D = $finish_area
@export var win_time : float = 5.0
@export var rot_speed: float = 0.1

@export var level_win_height : float = 20

signal win
signal lose

func _ready() -> void:
	Globals.block_changed.connect(block_changed)
	placement_collision.position.y = placement_height
	finish_line.position.y = level_win_height
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if not is_mouse_button_down:
		move_placement_collision()
	if is_mouse_button_down:
		get_input_for_rotating()
	
func block_changed (scene: PackedScene):
	#print_debug("changed")
	block = scene
func _input(event: InputEvent) -> void:
	if(Globals.money < Globals.get_selected_block().price):
		return
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Mouse button is pressed, set the flag
				is_mouse_button_down = true
				#print("Mouse button pressed")
				if ray_cast_check():
					block_instance = block.instantiate()
					if "freeze" in block_instance:
						block_instance.freeze = true
					add_child(block_instance)
					Globals.block_placed()
			else:
				# Mouse button is released, unset the flag
				is_mouse_button_down = false
				#print("Mouse button released")
				if ray_cast_check():
					if block_instance:
						if "freeze" in block_instance:
							block_instance.freeze = false
							block_instance = null
				
	
	# Handle mouse motion events (dragging)
	if event is InputEventMouseMotion and is_mouse_button_down:
		# Perform actions while dragging with the mouse button down
		#print("Dragging with mouse button down")
		#get_input_for_rotating()
		if ray_cast_check():
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
		if block_instance:
			block_instance.position.x = result.position.x
			block_instance.position.z = result.position.z
			block_instance.position.y = placement_collision.position.y
	else:
		print("Ray did not hit anything.")

func ray_cast_check():
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
	return result.size()

func move_placement_collision():
	if placement_ray.is_colliding():
		var point = placement_ray.get_collision_point(0)
		placement_collision.position.y = point.y + placement_offset

func finish_line_check():
	pass
		
func _on_finish_area_body_entered(body: Node3D) -> void:
	
	await get_tree().create_timer(win_time).timeout# removes this node from scene
	if finish_area.get_overlapping_bodies():
		Globals.win()
	
func get_input_for_rotating():
	if Input.is_action_pressed("ui_up"):
		block_instance.rotation.x += rot_speed
	if Input.is_action_pressed("ui_down"):
		block_instance.rotation.x -= rot_speed
	if Input.is_action_pressed("ui_left"):
		block_instance.rotation.y += rot_speed
	if Input.is_action_pressed("ui_right"):
		block_instance.rotation.y -= rot_speed

func _on_area_3d_body_entered(body: Node3D) -> void:
	Globals.lose()
