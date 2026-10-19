extends CanvasLayer

func _on_reset_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_01.tscn")

func _on_back_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
