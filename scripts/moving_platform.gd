extends Node2D

@export var distance: float = 20.0 # px
@export var duration: float = 5.0 # sg

@onready var animatable_body_2d: AnimatableBody2D = $AnimatableBody2D

# Doc: Tween es una herramienta basada en código que sirve para animar
# propiedades de forma suave.

func _ready() -> void:
	# Posición inicial instanciada del animatable_body_2d
	var start_position: Vector2 = animatable_body_2d.position
	# Posicion final a la que llegara el animatable_body_2d con el distance custom
	var end_position: Vector2 = start_position + Vector2(distance, 0)
	
	# Crear el tween
	var tween: Tween = create_tween()
	
	# Sincroniza la actualización del Tween con el ciclo de física (_physics_process)
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	
	# Loopear la animacion del tween
	tween.set_loops()
	
	# Poner efecto de transicion
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	# Animacion a ejecutar
	# # Iniciar animacion para ir a la posicion final con la duracion custom
	tween.tween_property(animatable_body_2d, "position", end_position, duration)
	# # Terminar animacion para ir a la posicion inicial con la duracion custom
	tween.tween_property(animatable_body_2d, "position", start_position, duration)
