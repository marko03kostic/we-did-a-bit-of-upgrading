extends Node

var money: int = 0
var number_of_blocks: int = 0

@onready var earthquake_timer = Timer.new() 

signal no_more_money;
var ICON = preload("res://icon.svg")
func _ready() -> void:
	MainGui.visible = false;
	
	add_child(earthquake_timer)
	earthquake_timer.one_shot = false
	earthquake_timer.autostart = false
	earthquake_timer.wait_time = randi_range(5, 6)
	earthquake_timer.timeout.connect(apply_shake)
	
func start_a_level():
	MainGui.visible = true;
	print_debug(ICON)
	MainGui.set_blocks(1,  ICON, 2, ICON, 3, ICON)
	
func enable_rng():
	earthquake_timer.start(earthquake_timer.wait_time)
	
func disable_rng():
	earthquake_timer.paused = true

func apply_shake():
	get_tree().get_nodes_in_group("Level").all(func (lvl): lvl.apply_shake())
	
func reduce_money(amount: int) -> bool:
	if(money < amount):
		no_more_money.emit()
		return false
	money -= amount
	return true

func increase_money(amount: int) -> void:
	money += amount
