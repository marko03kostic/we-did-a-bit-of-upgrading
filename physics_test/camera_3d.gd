extends Camera3D

@export var x_sensitivity = 0.01
@export var radius = 10
@export var center_node: Node3D
@export var upper_tilt_limit  := 60
@export var lower_tilt_limit  := 20
@export var height_limit := 10
@export var height_tick:= 1
@export var zoom_step:= 1

@onready var pivot := %Pivot
@onready var arm := %Arm

var lastMouseMove: Vector2 = Vector2.ONE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		arm.spring_length -= zoom_step
	if event.is_action_pressed("zoom_out"):
		arm.spring_length += zoom_step
			
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if event is InputEventMouseMotion:
			pivot.rotation.x -= event.relative.y * x_sensitivity
			pivot.rotation_degrees.x = clampf(pivot.rotation_degrees.x, -upper_tilt_limit, lower_tilt_limit)
			pivot.rotation.y += -event.relative.x * x_sensitivity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_down"):
		pivot.position.y -= height_tick * delta
	if Input.is_action_pressed("ui_down"):
		pivot.position.y += height_tick * delta;
	
	
