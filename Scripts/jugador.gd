extends CharacterBody2D

var velocidad:int = 500
var direccionX = null
var direccionY = null

# Esta funcion actualiza los frames todo el rato
func _physics_process(delta):
	
	# Asignamos las teclas izquierda y derecha con 'get_axis'
	# 'get_axis' solo puede recibir dos argumentos
	direccionX = Input.get_axis("ui_left", "ui_right")
	direccionY = Input.get_axis("ui_up", "ui_down")
	
	# Ahora aplicamos la velocidad que le hemos asignado
	# Al atributo velocity del jugador.
	velocity.x = direccionX * velocidad
	velocity.y = direccionY * velocidad
	
	# Esta funcion permite que al presionar dos teclas
	# No se multiplique la velocidad y aumente.
	# La mantiene todo el rato en el mismo valor.
	velocity.normalized()
	
	# Sin esta funcion, no conseguimos que el objeto (nodo) se mueva
	move_and_slide()
