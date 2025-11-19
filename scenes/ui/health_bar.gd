extends Control
class_name HealthBar

@export var background_color: Color
@export var fill_color: Color

# nodes
var progress_bar: ProgressBar
var label: Label

func _ready() -> void:
	progress_bar = get_node("%ProgressBar")
	label = get_node("%Label")
	var background_style = progress_bar.get_theme_stylebox("background").duplicate()
	background_style.bg_color = background_color
	var fill_style = progress_bar.get_theme_stylebox("fill").duplicate()
	fill_style.bg_color = fill_color
	progress_bar.add_theme_stylebox_override("background", background_style)
	progress_bar.add_theme_stylebox_override("fill", fill_style)
	
	
func _process(delta: float) -> void:
	pass

func update_bar(percentage_value: float, current_health: float) -> void:
	progress_bar.value = percentage_value
	label.text = str(current_health)
	
func on_health_changed(current: float, max: float) -> void:
	update_bar(current / max, current)
