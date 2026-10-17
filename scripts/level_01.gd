extends Node2D

@onready var hud: CanvasLayer = $HUD
@onready var player: CharacterBody2D = $Player

const COINS_GROUP: String = "coins"
const SLIME_GROUP: String = "enemies"
var collected_coins: int = 0

func _ready() -> void:
	# Obtener coins y enemies
	var coins: Array[Node] = get_tree().get_nodes_in_group(COINS_GROUP)
	var enemies: Array[Node] = get_tree().get_nodes_in_group(SLIME_GROUP)
	
	# Conectar señales
	for coin in coins:
		coin.collected.connect(_on_coin_collected)
	
	for enemy in enemies:
		enemy.hit_player.connect(_on_hit_player)
		
		
func _on_coin_collected() -> void:
	collected_coins += 1
	hud.update_label(collected_coins)
	
	
func _on_hit_player() -> void:
	if player.is_dead:
		return
	player.die()
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
