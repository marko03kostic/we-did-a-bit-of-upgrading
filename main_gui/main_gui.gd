extends Control
class_name MainGUI

signal block1Selected
signal block2Selected
signal block3Selected

func set_block_buttons_visible(visible: bool) -> void:
	%BlockButtonsContainer.visible = visible
func set_blocks(block1Price: int, block1: PackedScene, block2Price: int, block2: PackedScene, block3Price: int, block3: PackedScene):
	$MarginContainer/BlockButtonsContainer/BlockButton.setPrice(block1Price)
	$MarginContainer/BlockButtonsContainer/BlockButton.setImage(block1)
	$MarginContainer/BlockButtonsContainer/BlockButton2.setPrice(block2Price)
	$MarginContainer/BlockButtonsContainer/BlockButton2.setImage(block2)
	$MarginContainer/BlockButtonsContainer/BlockButton3.setPrice(block3Price)
	$MarginContainer/BlockButtonsContainer/BlockButton3.setImage(block3)
func set_money(money: int) -> void:
	$MoneyLabel.text = "Money: %s€" % [money]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/BlockButtonsContainer/BlockButton.connect("pressed", block_1_pressed)
	$MarginContainer/BlockButtonsContainer/BlockButton2.connect("pressed", block_2_pressed)
	$MarginContainer/BlockButtonsContainer/BlockButton3.connect("pressed", block_3_pressed)
	Globals.money_updated.connect(money_updated)
	
	pass # Replace with function body.
func block_1_pressed ():
	block1Selected.emit()
func block_2_pressed ():
	block2Selected.emit()
func block_3_pressed ():
	block3Selected.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func money_updated(money: int):
	print_debug("money")
	set_money(money)
