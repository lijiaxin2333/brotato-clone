extends Node2D

class_name Unit

# node
var visuals: Node2D
var collision: CollisionShape2D

@export var status: UnitStatus

func _ready() -> void:
	visuals = get_node("visuals") as Node2D
	collision = get_node("collision") as CollisionShape2D
	

func _process(delta: float) -> void:
	pass
