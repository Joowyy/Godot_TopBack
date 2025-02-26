extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var player = null
var playerCollision:bool = false
var vida:int = 5
var daño:int = 3

# Guardamos la ruta de nuestro repositorio 'Remoto' cuando iniciamos el juego
func _ready():
	player = get_node("/root/Node2D/Personaje/Jugador")
	
func _physics_process(delta):
	
	# Si el jugador esta en la escena
	if player != null:
		
		# Coge la posicion global de la escena de player 'Jugador' y la procesa en velocidad.
		var direccion = global_position.direction_to(player.global_position)
		velocity = direccion * SPEED
		
		move_and_slide()
	muerteEnemigo()

# Funcion de Ataque al Jugador
func Ataque(player:CharacterBody2D, daño:int):
	if player.vida > 0:
		player.vida -= daño
		print(player.vida)
	
		# Un nodo 'Timer' cuenta el tiempo de algo
		$Timer.start()
	else:
		return
	
func muerteEnemigo():
	if vida <= 0:
		queue_free()
		print("Enemigo muerto")

# En este caso, para usar el 'while' necesitamos retornar algo
func _on_area_2d_body_entered(body:Node2D):
	if body.name == "Jugador":
		playerCollision = true
		Ataque(body, daño)
		
	else:
		playerCollision = false
		return
	
# Funcion 'SEÑAL' de Timer, si el jugador esta colisionando, haz daño.
func _on_timer_timeout():
	if playerCollision and player != null:
		Ataque(player, daño)
	else:
		return
