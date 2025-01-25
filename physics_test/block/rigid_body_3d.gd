extends RigidBody3D

# Gravity constant
var gravity = -9.8

func _ready():
	# Set the initial gravity force
	set_gravity_scale(1)

func _integrate_forces(state):
	# Apply gravity to the block
	var gravity_force = Vector3(0, gravity, 0) * mass * state.step
	apply_force(gravity_force, Vector3())
