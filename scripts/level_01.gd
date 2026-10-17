extends Node2D

@onready var hud: CanvasLayer = $HUD

const COINS_GROUP: String = "coins"

var collected_coins: int = 0

func _ready() -> void:
	# Obtener todas las monedas del level
	var coins: Array[Node] = get_tree().get_nodes_in_group(COINS_GROUP)
	
	# Conectar señales de las monedas
	for coin in coins:
		coin.collected.connect(_on_coin_collected)
		
		
func _on_coin_collected() -> void:
	collected_coins += 1
	hud.update_label(collected_coins)
	
	
