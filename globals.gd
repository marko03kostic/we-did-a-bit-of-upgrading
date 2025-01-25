extends Node

var money: int = 0
var number_of_blocks: int = 0

@onready var t = Timer.new() 

signal no_more_money;

func _ready() -> void:
	add_child(t)
	t.one_shot = false
	t.autostart = false
	t.wait_time = randi_range(5, 6)
	t.timeout.connect(apply_shake)

	enable_rng()

func enable_rng():
	t.start(t.wait_time)
func disable_rng():
	t.paused = true

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
