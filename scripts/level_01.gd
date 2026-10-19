extends Node2D

@onready var hud: CanvasLayer = $HUD
@onready var player: CharacterBody2D = $Player
@onready var kill_zone: Area2D = $KillZone
@onready var goal: Area2D = $Goal

const COINS_GROUP: String = "coins"
const SLIME_GROUP: String = "enemies"
var collected_coins: int = 0
var player_won: bool = false

func _ready() -> void:
	# Obtener coins y enemies
	var coins: Array[Node] = get_tree().get_nodes_in_group(COINS_GROUP)
	var enemies: Array[Node] = get_tree().get_nodes_in_group(SLIME_GROUP)
	
	# Conectar señales
	for coin in coins:
		coin.collected.connect(_on_coin_collected)
	
	for enemy in enemies:
		enemy.hit_player.connect(_on_die_player)
		
	kill_zone.hit_player.connect(_on_die_player)
	goal.player_entered.connect(_on_player_won)
		
		
func _on_coin_collected() -> void:
	collected_coins += 1
	hud.update_label(collected_coins)
	
	
func _on_die_player() -> void:
	if player_won or player.is_dead:
		return
	player.die()
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
	
func _on_player_won() -> void:
	if player_won or player.is_dead:
		return
	
	player_won = true
	get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
