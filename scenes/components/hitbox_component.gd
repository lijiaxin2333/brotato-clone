extends Area2D
class_name HitboxComponent

var damage = 1.0
var critical = false
var knockback_power = 0.0
var source: Node2D

signal on_hit_huirbox(area: HurtboxComponent)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("area_entered", self.on_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enable() -> void:
	set_deferred("monitoring", true)
	set_deferred("monitorable", true)
	
func disable() -> void:
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)

func setup(
	damage: float,
	critical: bool,
	knock_power: float,
	source: Node2D
) -> void:
	self.damage = damage
	self.critical = critical
	self.knockback_power = knockback_power
	self.source = source

func on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		on_hit_huirbox.emit(area)
		print(area.owner.name)
