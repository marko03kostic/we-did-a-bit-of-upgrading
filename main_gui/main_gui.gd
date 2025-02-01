extends Control
class_name MainGUI
const BLOCK_BUTTON = preload("res://main_gui/block_button.tscn")
func set_block_buttons_visible(visible: bool) -> void:
	%BlockButtonsContainer.visible = visible

func set_money(money: int) -> void:
	$MoneyLabel.text = "Money: %s€" % [money]
	
func set_money_added(money: int) -> void:
	$AddedMoney.text = "+ %s" % [money]

	await get_tree().create_timer(4).timeout
	$AddedMoney.text = ""
	
func set_money_removed(money: int) -> void:
	$RemovedMoney.text = "- %s" % [money]

	await get_tree().create_timer(4).timeout
	$RemovedMoney.text = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.money_updated.connect(money_updated)
	Globals.inspection_starts.connect(start_inspection)
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
	#print_debug("money")
	if (money > int($MoneyLabel.text)):
		set_money_added(money - int($MoneyLabel.text))
	elif (money < int($MoneyLabel.text)):
		set_money_removed(int($MoneyLabel.text) - money)
	else:
		pass
	set_money(money)
	 
func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://physics_test/physics_test2.tscn")

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
func start_inspection():
	$InspectionDialog1.visible = true;


func _on_inspection_dialog_1_confirmed() -> void:
	var r = randf_range(0,1)
	if(r > 0.7):
		$BribeFailedDialog.visible = true
		Globals.bribe_fail()
	else:
		$BribeSuccessDialog.visible = true
		Globals.bribe_success()

func _on_inspection_dialog_1_canceled() -> void:
	$BribeDeclainedDialog.visible = true
	Globals.bribe_declined()
	
