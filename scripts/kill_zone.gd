extends Area2D

signal hit_player

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		hit_player.emit()
