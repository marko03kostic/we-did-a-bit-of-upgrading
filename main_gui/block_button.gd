extends Button
class_name BlockButton

signal block_selected(blockId: int)

func setPrice(price: int):
	$RichTextLabel.text = "Price: %s" % [str(price)]
	
func setImage(img: Texture):
	$TextureRect.texture = img

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
