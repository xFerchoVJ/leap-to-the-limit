extends CharacterBody2D

signal hit_player

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var speed: float = 80
var direction: float = 1

func _physics_process(delta: float) -> void:
	# Aplicar gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Aplicar direccion de movimiento
	velocity.x = direction * speed
	
	move_and_slide()
	
	# Dar la vuelta cuando no hay suelo o si hay un muro adelante
	if is_on_floor():
		if is_on_wall() or not ray_cast_2d.is_colliding():
			flip_character()
		
		
func flip_character() -> void:
	direction *= -1
	animated_sprite_2d.flip_h = direction < 0
	ray_cast_2d.position.x *= -1
		


func _on_hit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		hit_player.emit()
		
	
