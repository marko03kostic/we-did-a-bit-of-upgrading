extends Node

var money: int = 0
var number_of_blocks: int = 0

@onready var t = Timer.new() 

signal no_more_money;

func _ready() -> void:
	add_child(t)
	t.one_shot = false
	t.autostart = false
	t.wait_time = randi_range(5, 15)
	t.timeout.connect(test)

	enable_rng()

func enable_rng():
	t.start(t.wait_time)
func disable_rng():
	t.paused = true

func test ():
	print_debug("test")
	
func reduce_money(amount: int) -> bool:
	if(money < amount):
		no_more_money.emit()
		return false
	money -= amount
	return true

func increase_money(amount: int) -> void:
	money += amount
