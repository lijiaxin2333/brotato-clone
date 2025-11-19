extends Unit
class_name Player

var move_dir: Vector2 = Vector2.ZERO
var is_dashing = false
var dash_available = true

@export var dash_duration = .5
@export var dash_multi = 2.0
@export var dash_cooldown_duration = .5

# node
var animation_paleyr: AnimationPlayer
var dash_timer: Timer
var dash_cooldown_timer: Timer

# 动画名称
const moveAnimation = "move"
const idleAnimation = "idle"
const dieAnimation = "die"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	animation_paleyr = get_node("animation_player") as AnimationPlayer
	dash_timer = get_node("dash_timer") as Timer
	dash_cooldown_timer = get_node("dash_cooldown_timer") as Timer
	dash_timer.wait_time = dash_duration; dash_timer.one_shot = true
	dash_cooldown_timer.wait_time = dash_cooldown_duration; dash_cooldown_timer.one_shot = true
	dash_timer.connect("timeout", self.on_dash_timer_timeout)
	sprite.texture = status.icon

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var current_velocity: Vector2 = move_dir * status.speed
	if is_dashing:
		current_velocity *= dash_multi
	if can_dash():
		start_dash()
	position += current_velocity * delta
	position.x = clamp(position.x, -1000, +1000)
	position.y = clamp(position.y, -500, +500)
	update_animations()
	update_rotation()
	
# 动画
func update_animations() -> void:
	if move_dir.length() > 0:
		animation_paleyr.play(moveAnimation)	
	else:
		animation_paleyr.play(idleAnimation)
		
func update_rotation() -> void:
	if move_dir == Vector2.ZERO:
		return
	if move_dir.x > 0:
		visuals.scale = Vector2(-0.5, 0.5)
	else:
		visuals.scale = Vector2(0.5, 0.5)

func start_dash() -> void:
	is_dashing = true
	dash_timer.start()
	visuals.modulate.a = .5
	collision.set_deferred("disabled", true)
	
func can_dash() -> bool:
	return \
	not is_dashing and \
	dash_cooldown_timer.is_stopped() and \
	Input.is_action_just_pressed("dash") and \
	move_dir != Vector2.ZERO

# timer
func on_dash_timer_timeout() -> void:
	is_dashing = false
	visuals.modulate.a = 1
	move_dir = Vector2.ZERO
	collision.set_deferred("disabled", false)
	dash_cooldown_timer.start()
