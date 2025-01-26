extends Button
class_name BlockButton

signal block_selected(blockId: int)
const BLOCK_VIEWPORT_RENDER = preload("res://block_viewport_render.tscn")
var vtp
var id
func setPrice(price: int):
	if($RichTextLabel  != null):
		$RichTextLabel.text = "Price: %s" % [str(price)]
	pass
	
func setImage(blockScene: PackedScene):
	vtp = BLOCK_VIEWPORT_RENDER.instantiate()
	vtp.rendered_node = blockScene
	add_child(vtp)
	print_debug(vtp.viewPort.get_viewport())
	(vtp.viewPort.get_viewport() as SubViewport).ready.connect(continue_set_image)

func continue_set_image():
	$TextureRect.texture = vtp.viewPort.get_viewport().get_texture()
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	Globals.blockSelected(id)
