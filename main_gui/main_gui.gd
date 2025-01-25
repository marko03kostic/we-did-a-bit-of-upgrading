extends Control
class_name MainGUI

func set_block_buttons_visible(visible: bool) -> void:
	%BlockButtonsContainer.visible = visible
func set_blocks(block1Price: int, block1Texture: Texture, block2Price: int, block2Texture: Texture, block3Price: int, block3Texture: Texture):
	$MarginContainer/BlockButtonsContainer/BlockButton.setPrice(block1Price)
	$MarginContainer/BlockButtonsContainer/BlockButton.setImage(block1Texture)
	$MarginContainer/BlockButtonsContainer/BlockButton2.setPrice(block2Price)
	$MarginContainer/BlockButtonsContainer/BlockButton2.setImage(block2Texture)
	$MarginContainer/BlockButtonsContainer/BlockButton3.setPrice(block2Price)
	$MarginContainer/BlockButtonsContainer/BlockButton3.setImage(block2Texture)
func set_money(money: int) -> void:
	$MoneyLabel.text = "Money: %s€" % [money]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
