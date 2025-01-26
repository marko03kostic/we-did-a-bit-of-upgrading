extends Control
class_name MainGUI
const BLOCK_BUTTON = preload("res://main_gui/block_button.tscn")
func set_block_buttons_visible(visible: bool) -> void:
	%BlockButtonsContainer.visible = visible

func set_money(money: int) -> void:
	$MoneyLabel.text = "Money: %s€" % [money]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.money_updated.connect(money_updated)
	
	for block in Globals.blocks:
		var btn:BlockButton = BLOCK_BUTTON.instantiate()
		%BlockButtonsContainer.add_child(btn)
		btn.setImage(block.scene)
		btn.setPrice(block.price)
		btn.id = block.id
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func money_updated(money: int):
	print_debug("money")
	set_money(money)
