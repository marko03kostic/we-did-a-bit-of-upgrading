extends RigidBody3D

# Gravity constant
@export var gravity = -9.8
@export var lose_height = 3.0

func _ready():
	# Set the initial gravity force
	set_gravity_scale(1)
	#freeze = true
	#print(position)

func _integrate_forces(state):
	# Apply gravity to the block
	var gravity_force = Vector3(0, gravity, 0) * mass * state.step
	apply_force(gravity_force, Vector3())

func _process(delta: float) -> void:
	#print(position)
	if check_lose_condition():
		Globals.lose()

func check_lose_condition():
	return position.y <= lose_height

		
