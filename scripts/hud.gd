extends CanvasLayer

@onready var label: Label = $Label


func update_label(qty: int) -> void:
	label.text = "Monedas: %d" % qty
