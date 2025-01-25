extends Node3D
class_name Level
@export var randomStrength = 4
@export var noise: Noise
@export var intensity_factor := 0.5
var shake_fade := 2.0
var shake_strength := 0
var shake_toggle = false

@export var kurv:CurveTexture

@onready var timer:Timer = $ShakeTimer

func _ready() -> void:
	#apply_shake()
	pass # Replace with function body.

func apply_shake():
	shake_toggle = true
	timer.start(timer.wait_time)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var intensity = kurv.curve.sample(timer.time_left / timer.wait_time) * intensity_factor
	var x_noise = noise.get_noise_1d(float(Time.get_ticks_msec()/100)) * intensity
	$RigidBody3D.translate(Vector3(x_noise, 0, 0))
	
