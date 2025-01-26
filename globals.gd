extends Node

var money: int = 0
var number_of_blocks: int = 0
var rng_time_min:= 6
var rng_time_max:= 15


@onready var earthquake_timer = Timer.new() 
signal no_more_money
signal money_updated(int)

var ICON = preload("res://icon.svg")
const NADOG_1 = preload("res://blocks/nadog_1.tscn")
const blocks = [{
	"name": "1", "scene": NADOG_1, "price": 10000, 
}, {
	"name": "2", "scene": NADOG_1, "price": 20000, 
}, {
	"name": "3", "scene": NADOG_1, "price": 30000, 
}]

var selectedBlock = 0

func _ready() -> void:
	MainGui.visible = false;
	
	add_child(earthquake_timer)
	earthquake_timer.one_shot = false
	earthquake_timer.autostart = false
	earthquake_timer.timeout.connect(apply_shake)
	
	
func start_a_level():
	MainGui.block1Selected.connect(block1Selected)
	MainGui.block2Selected.connect(block2Selected)
	MainGui.block3Selected.connect(block3Selected)
	money_updated.emit(money)
	enable_rng()
	MainGui.visible = true; 
	MainGui.set_blocks(blocks[0]["price"], blocks[0]["scene"], blocks[1]["price"], blocks[1]["scene"], blocks[2]["price"], blocks[2]["scene"])
	
func enable_rng() -> void:
	earthquake_timer.start(randi_range(rng_time_min, rng_time_max))
	
func disable_rng():
	earthquake_timer.paused = true

func apply_shake():
	pass
	#get_tree().get_nodes_in_group("Level").all(func (lvl): lvl.apply_shake())
	
func reduce_money(amount: int) -> bool:
	if(money < amount):
		no_more_money.emit()
		return false
	money -= amount
	money_updated.emit(money)
	return true

func increase_money(amount: int) -> void:
	money += amount
	
func block_placed():
	reduce_money(blocks[selectedBlock].price)
	
func get_selected_block():
	return blocks[selectedBlock]
func block1Selected():
	selectedBlock = 0
func block2Selected():
	selectedBlock = 1
func block3Selected():
	selectedBlock = 2
