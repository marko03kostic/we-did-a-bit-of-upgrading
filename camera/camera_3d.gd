extends Node3D

@export var x_sensitivity = 0.01
@export var radius = 10
@export var center_node: Node3D
@export var upper_tilt_limit  := 60
@export var lower_tilt_limit  := 20
@export var height_limit := 8
@export var height_tick:= 2
@export var zoom_step:= 1

@onready var arm := %Arm
@onready var initial_y_pivot: int = position.y

var lastMouseMove: Vector2 = Vector2.ONE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		arm.spring_length -= zoom_step
	if event.is_action_pressed("zoom_out"):
		arm.spring_length += zoom_step
			
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		if event is InputEventMouseMotion:
			rotation.x -= event.relative.y * x_sensitivity
			rotation_degrees.x = clampf(rotation_degrees.x, -upper_tilt_limit, lower_tilt_limit)
			rotation.y += -event.relative.x * x_sensitivity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("camera_down") and position.y >= height_limit:
		position.y -= height_tick * delta
		#position.y = clamp(position.y, initial_y_pivot, height_limit)
		
		print("down")
	if Input.is_action_pressed("camera_up"):
		position.y += height_tick * delta;
		#position.y = clamp(position.y, initial_y_pivot, height_limit)
		print("up")
	
	
