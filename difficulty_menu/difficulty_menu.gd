extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_choice_1_pressed() -> void:
	Globals.money = 150_000
	Globals.start_a_level()
	get_tree().change_scene_to_file("res://physics_test/physics_test2.tscn")

func _on_choice_2_pressed() -> void:
	Globals.money = 500_000
	Globals.start_a_level()
	get_tree().change_scene_to_file("res://physics_test/physics_test2.tscn")
func _on_choice_3_pressed() -> void:
	Globals.money = 1_300_000
	Globals.start_a_level()
	get_tree().change_scene_to_file("res://physics_test/physics_test2.tscn")
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
