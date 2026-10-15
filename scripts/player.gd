extends CharacterBody2D

@export var speed: float = 80
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	#Obtener la dirección del movimiento
	var direction: float = Input.get_axis("move_left", "move_right")
	
	# Aplicar movimiento horizontal
	if direction != 0:
		velocity.x = direction * speed
	else:
		velocity.x = 0

	# Aplicar gravedad cuando esta en el aire
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
	
	# Voltear personaje dependiendo la dirección
	if direction > 0: # Ir a la derecha
		animated_sprite_2d.flip_h = false
	elif direction < 0: # Ir a la izquierda
		animated_sprite_2d.flip_h = true
		
		
