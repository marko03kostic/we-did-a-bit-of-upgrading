extends Node

var money: int = 0
var number_of_blocks: int = 0
var rng_time_min:= 15
var rng_time_max:= 30

const inspection_penalty = 10000
const inspection_bribery = 5000
const bribery_loss = 20000

@onready var earthquake_timer = Timer.new() 
@onready var inspection_timer = Timer.new() 
signal no_more_money
signal money_updated(int)
signal block_changed(int)
signal inspection_starts

var ICON = preload("res://icon.svg")
const NADOG_1 = preload("res://blocks/nadog_1.tscn")
const HOUSE_L = preload("res://art/house_L.gltf")
const NADOG_2 = preload("res://blocks/nadog_2.tscn")
const CONTAINER = preload("res://blocks/container.tscn")
var blocks: Array[BlockResource] = []

var selectedBlock = 0

func _ready() -> void:
	blocks.resize(4)
	MainGui.visible = false;
	blocks[0] = BlockResource.new(NADOG_1, 0, 1000)
	blocks[1] = BlockResource.new(CONTAINER, 1, 2000)
	blocks[2] = BlockResource.new(NADOG_2, 2, 5000)
	blocks[3] = BlockResource.new(NADOG_2, 3, 10000)
	
	add_child(earthquake_timer)
	earthquake_timer.one_shot = false
	earthquake_timer.autostart = false
	earthquake_timer.timeout.connect(apply_shake)
	
	add_child(inspection_timer)
	inspection_timer.one_shot = false
	inspection_timer.autostart = false
	inspection_timer.timeout.connect(start_inspection)
	
func start_a_level():
	money_updated.emit(money)
	enable_rng()
	MainGui.visible = true; 
	
func enable_rng() -> void:
	earthquake_timer.start(randi_range(rng_time_min, rng_time_max))
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
func blockSelected(id:int) -> void:
	selectedBlock = id
	block_changed.emit(blocks[selectedBlock].scene)

func start_inspection():
	inspection_starts.emit()

func bribe_success():
	reduce_money(inspection_bribery)
func bribe_fail(): 
	reduce_money(bribery_loss)
func bribe_declined(): 
	reduce_money(inspection_penalty)

func win():
	#print("you win this level")
	get_tree().call_deferred("change_scene_to_file", "res://game_finished/game_finished.tscn")
func lose():
	#print("you lose this level")
	get_tree().call_deferred("change_scene_to_file", "res://game_finished/game_finished.tscn")
