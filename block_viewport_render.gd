extends SubViewportContainer

@export var rendered_node: PackedScene = preload("res://blocks/nadog_1.tscn")
@onready var viewPort = $SubViewport
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(rendered_node.can_instantiate()):
		var n = rendered_node.instantiate()
		$SubViewport.add_child(n)
		if "freeze" in n:
			n.freeze = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
