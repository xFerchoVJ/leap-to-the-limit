extends CharacterBody2D

@export var speed: float = 80
@export var jump_velocity: float = -250
@export var jump_cut_factor: float = 0.5

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

	# Aplicar salto
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity 
		
	# Recortar el salto al soltar la tecla
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= jump_cut_factor
	
	# Siempre poner todo lo que modifica velocity antes de move_and_slide
	move_and_slide()
	
	# Voltear personaje dependiendo la dirección
	if direction > 0: # Ir a la derecha
		animated_sprite_2d.flip_h = false
	elif direction < 0: # Ir a la izquierda
		animated_sprite_2d.flip_h = true
		
		
