extends Node2D

class_name Unit

# node
var visuals: Node2D
var shadow: Sprite2D
var sprite: Sprite2D
var collision: CollisionShape2D

@export var status: UnitStatus

func _ready() -> void:
	visuals = get_node("%visuals") as Node2D
	shadow = get_node("%shadow") as Sprite2D
	sprite = get_node("%sprite") as Sprite2D
	collision = get_node("%collision") as CollisionShape2D

func _process(delta: float) -> void:
	pass
