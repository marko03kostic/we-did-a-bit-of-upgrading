extends Button
class_name BlockButton

signal block_selected(blockId: int)
const BLOCK_VIEWPORT_RENDER = preload("res://block_viewport_render.tscn")
func setPrice(price: int):
	$RichTextLabel.text = "Price: %s" % [str(price)]
	
func setImage(blockScene: PackedScene):
	var vtp = BLOCK_VIEWPORT_RENDER.instantiate()
	vtp.rendered_node = blockScene
	add_child(vtp)
	$TextureRect.texture = vtp.viewPort.get_viewport().get_texture()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
