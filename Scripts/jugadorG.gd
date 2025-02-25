extends CharacterBody2D

<<<<<<< HEAD
# Accedemos a la ruta del padre de Label, en este caso Node2D.
# Cada "../" es una carpeta hacia atras. Luego indicamos el nombre.
@onready var label:Label = $"../../Label"

# Velocidad y salto del personaje
const SPEED:float = 300.0
const JUMP_VELOCITY:float = -300.0

# Agregamos la velocidad en nuestro personaje
var gravedad:float = 0.0
var coins:int = 0
var vida:int = 10

func _ready():
	print(vida)

# Comprueba constantemente 60 veces por segundo
func _physics_process(delta: float) -> void:
	
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

func gameOver() -> void:
	
	# Si la vida es 0, imprime estas muerto y mantiene el valor a 0.
	if vida <= 0:
		queue_free()
		label.text = "Has muerto!"

# Usamos una señal del Inspector y apartado señales.
# Esta funcion indica que cuando toquemos un cuerpo ocurra algo.
# Aqui le bajamos la vida a nuestro personaje
func _on_area_2d_body_entered(body):
	
	# Cuando el cuerpo se llame 'nombreCuerpo', restame la vida -2.
	# Añadimos los cuerpos en un grupo juntos y llamamos al grupo.
	if body.is_in_group("Spike"):#or body.name == "Spike_02":
		vida -= 2
		
	print(vida)
	
func escogerSexo (sexo:String) -> String:
	
	if sexo == "Hombre":
		return "Hombre"
	elif sexo == "Mujer":
		return "Mujer"
	return "Eso no es un género. Introduce otro género."
=======
# Velocidad y salto del personaje
const SPEED:float = 200.0
const JUMP_VELOCITY:float = -300.0

# Agregamos la velocidad en nuestro personaje
var gravedad:float = 700.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravedad * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
>>>>>>> 77a1f52 (Rampa agregada)
