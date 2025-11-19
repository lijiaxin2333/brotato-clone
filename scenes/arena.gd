extends Node2D

class_name Arena

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = get_node("player_well_rounded") as Player
	Global.player = player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
