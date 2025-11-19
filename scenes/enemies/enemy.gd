extends Unit

class_name Enemy

@export var flock_push = 20.0 # 敌人之间的斥力

var can_move = true

# node
var vision_area: Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	vision_area = get_node("%vision_area") as Area2D
	sprite.texture = status.icon

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not can_move:
		return
	if not can_move_towards_player():
		return
	position += get_move_direction() * status.speed * delta
	update_rotation()
	
func can_move_towards_player() -> bool:
	return is_instance_valid(Global.player) and \
	global_position.distance_to(Global.player.global_position) > 60.0
	
func get_move_direction() -> Vector2:
	if not is_instance_valid(Global.player):
		return Vector2.ZERO
	var direction = global_position.direction_to(Global.player.global_position)
	for area in vision_area.get_overlapping_areas():
		if area != self and area.is_inside_tree():
			var vector = global_position - area.global_position
			direction += vector.normalized() * flock_push / vector.length()
	return direction
	
func update_rotation() -> void:
	if not is_instance_valid(Global.player):
		return
	var player_position = Global.player.global_position
	var moving_right = global_position.x < player_position.x
	if moving_right:
		visuals.scale = Vector2(-0.5, 0.5)
	else:
		visuals.scale = Vector2(0.5, 0.5)
