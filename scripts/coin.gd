extends Area2D

signal collected

@onready var coin_sound: AudioStreamPlayer = $CoinSound

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		collected.emit()
		visible = false
		set_deferred("monitoring", false)
		coin_sound.play()
		


func _on_coin_sound_finished() -> void:
	queue_free()
