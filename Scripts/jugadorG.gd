extends CharacterBody2D

# Accedemos a la ruta del padre de Label, en este caso Node2D.
# Cada "../" es una carpeta hacia atras. Luego indicamos el nombre.
# @onready var label:Label = $"../../Label"

# Velocidad y salto del personaje
const SPEED:float = 300.0
const JUMP_VELOCITY:float = -300.0

# Agregamos la velocidad en nuestro personaje
var gravedad:float = 0.0
var points:int = 0
var vida:int = 15
var daño:int = 3
var canAtaque:bool = true

# Variables enemigo
var enemigo = null
var enemigoCollision:bool = false

# Comprueba constantemente 60 veces por segundo
func _physics_process(delta: float) -> void:
	
	$CanvasLayer/Vida.text = "Vida: " + str(vida)
	$CanvasLayer/EnemigosMuertos.text = "Puntos: " + str(points)
	
	# Si no estas en el piso, aplica la gravedad
	if not is_on_floor():
		velocity.y += gravedad * delta

	# Si la tecla es presionada "Espacio, Enter..."
	# Y si tambien esta en el piso, suelo.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movimiento del personaje
	var directionY := Input.get_axis("ui_up", "ui_down")
	var directionX := Input.get_axis("ui_left", "ui_right")
	if directionY or directionX:
		velocity.y = directionY * SPEED
		velocity.x = directionX * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		velocity.x = move_toward(velocity.x, 0, SPEED)

# Permite que el juego reciba los moviemientos.
	move_and_slide()
	gameOver()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if enemigo != null:
			AtaqueJugador(enemigo, daño)

func gameOver() -> void:
	
	# Si la vida es 0, imprime estas muerto y mantiene el valor a 0.
	if vida <= 0:
		queue_free()
		print("Has muerto!")

# Usamos una señal del Inspector y apartado señales.
# Esta funcion indica que cuando toquemos un cuerpo ocurra algo.
# Aqui le bajamos la vida a nuestro personaje
func _on_area_2d_body_entered(body):
	
	# Cuando el cuerpo se llame 'nombreCuerpo', restame la vida -2.
	# Añadimos los cuerpos en un grupo juntos y llamamos al grupo.
	if body.is_in_group("Spike"):#or body.name == "Spike_02":
		vida -= 2

	if body.is_in_group("Enemigo"):
		enemigoCollision = true
		enemigo = body

# Como entra un body, tambien sale.
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemigo"):
		enemigoCollision = false
		
	print(enemigoCollision)

	
func escogerSexo (sexo:String) -> String:
	
	if sexo == "Hombre":
		return "Hombre"
	elif sexo == "Mujer":
		return "Mujer"
	return "Eso no es un género. Introduce otro género."
	
func AtaqueJugador (enemigo, daño) -> void:
	
	if canAtaque:
		enemigo.vida -= daño
		if enemigo.vida <= 0:
			points += 1
		$Timer.start()
		canAtaque = false
	
func _on_timer_timeout() -> void:
	canAtaque = true
