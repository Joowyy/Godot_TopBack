extends Node

# Creamos un spawn con un 'Preload', que precarga la escena 'Enemigos'
@onready var enemigo = preload("res://Escenas/Enemigo.tscn")
@onready var spawn_01 = $Spawn_01
@onready var spawn_02 = $Spawn_02
@onready var spawn_03 = $Spawn_03

func _on_timer_timeout() -> void:
	var generateEnemigo = enemigo.instantiate()
	
	# Es lo mismo que un 'switch'
	# 'randi_range' genera un numero aleatorio.
	match randi_range(1, 3):
		1:
			spawn_01.add_child(generateEnemigo)
		2:
			spawn_02.add_child(generateEnemigo)
		3:
			spawn_03.add_child(generateEnemigo)
