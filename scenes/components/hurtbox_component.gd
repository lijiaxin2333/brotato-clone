extends Area2D
class_name HurtboxComponent

signal on_damaged(area: HitboxComponent)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("area_entered", self.on_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		on_damaged.emit(area)
