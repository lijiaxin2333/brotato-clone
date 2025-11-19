extends Node2D

class_name Unit

# node
var visuals: Node2D
var shadow: Sprite2D
var sprite: Sprite2D
var collision: CollisionShape2D
var health_component: HealthComponent
var hurtbox_component: HurtboxComponent
var health_bar: HealthBar

@export var status: UnitStatus

func _ready() -> void:
	visuals = get_node("%visuals") as Node2D
	shadow = get_node("%shadow") as Sprite2D
	sprite = get_node("%sprite") as Sprite2D
	collision = get_node("%collision") as CollisionShape2D
	health_component = get_node("%health_component") as HealthComponent
	health_component.setup(status)
	health_bar = get_node("%HealthBar") as HealthBar
	health_component.connect("on_health_changed", health_bar.on_health_changed)
	hurtbox_component = get_node("%hurtbox_component") as HurtboxComponent
	hurtbox_component.connect("on_damaged", self.on_hurtbox_on_damaged)

func _process(delta: float) -> void:
	pass


func on_hurtbox_on_damaged(area: HitboxComponent) -> void:
	if health_component.current_health <= 0:
		return
	health_component.take_damage(area.damage)
	print("%s, %d" % [name, health_component.current_health])
