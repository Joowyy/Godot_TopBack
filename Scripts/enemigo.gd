extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var gravedad:float = 0.0
var player = null
var vida:int = 5
var daño:int = 3

# Guardamos la ruta de nuestro repositorio 'Remoto' cuando iniciamos el juego
func _ready():
	print("Vida enemigo:", vida)
	player = get_node("/root/Node2D/Jugador/Jugador")
	
func _physics_process(delta):
	
	# Si el jugador esta en la escena
	if player != null:
		
		var direccion = global_position.direction_to(player.global_position)
		velocity = direccion * SPEED
		
	move_and_slide()
	muerteEnemigo()

func Ataque(player:CharacterBody2D, daño:int):
	player.vida -= daño
	
func muerteEnemigo():
	if vida <= 0:
		queue_free()
		print("Enemigo muerto")

func _on_area_2d_body_entered(body:Node2D):
	if body.name == "Jugador":
		Ataque(body, daño)
	else:
		pass
		
