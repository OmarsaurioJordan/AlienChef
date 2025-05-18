extends Node2D

const SPEED = 40.0

const sonidos = [
	preload("res://Sounds/voz8.wav"), # puerta visagra
	preload("res://Sounds/voz1.wav"), # suave ala avion
	preload("res://Sounds/voz3.wav"), # ranita
	preload("res://Sounds/voz5.wav"), # flauta
	preload("res://Sounds/voz2.wav"), # chab chab cha
	preload("res://Sounds/voz6.wav"), # cruaji ghost
	preload("res://Sounds/voz9.wav"), # concreto rugoso
	preload("res://Sounds/voz7.wav"), # march simpson
	preload("res://Sounds/voz4.wav"), # bru bru bru
]
var deseo = 0
var aliens = []
var randsnds = [0, 1, 2, 3, 4, 5, 6, 7, 8]
var aciertos = 5

# aprox 13 segundos dura el tutorial + first item
var tutorial = true
var tutoind = 0
var is_movil = false
var lejos_mandos = 804

func _ready():
	# ajustar el nivel de dificultad
	var level = get_parent().level
	if level in [0, 2, 4]:
		randsnds.shuffle()
	elif level == 1:
		aciertos += 3
	else:
		aciertos += 6
	if level == 0:
		for r in range(8, 2, -1):
			randsnds.remove(r)
	elif level in [1, 2]:
		for r in range(8, 5, -1):
			randsnds.remove(r)
	# inicializar cosas
	$Mesa.setIngredientes(len(randsnds))
	$Ayuda/Anima1.current_animation = "Idle"
	$Ayuda/Anima2.current_animation = "Idle"
	$Ayuda/Anima3.current_animation = "Idle"
	$MusicaCora.play()
	aliens = [$AlienM, $AlienL, $AlienR]
	setDeseo()
	var model = OS.get_model_name().to_lower()
	is_movil = model.count("android") > 0 or model.count("ios") > 0

func setDeseo():
	deseo = randi() % len(randsnds) + 1
	#print(deseo)

func setAcierto():
	aciertos = max(0, aciertos - 1)
	return aciertos == 0

func _process(delta):
	if $Ayuda.get_node("BotonAyuda").is_hovered():
		$Ayuda.scale = Vector2(1.1, 1.1)
	else:
		$Ayuda.scale = Vector2(1, 1)
	$Ayuda.visible = not tutorial
	teclas()
	# mover la info de teclas
	if not is_movil:
		$Fondo/Mandos.position.x += delta * SPEED
		if $Fondo/Mandos.position.x > lejos_mandos:
			$Fondo/Mandos.position.x = 0
			lejos_mandos = 804 * 1.5 + randf() * 804 * 1.5

func teclas():
	if Input.is_action_just_pressed("key_ayuda"):
		pedirAyuda()

func pedirAyuda():
	var est = $Chef.getEstado()
	match est:
		"Idle":
			if not tutorial:
				setTutorial()
		"Super":
			get_parent().cambio(true)
		"Kill":
			get_parent().cambio()

# guion y tutorial

func _on_Iniciador_timeout():
	$Inicio.play()
	aliens[0].setEstado("Habla")

func _on_Inicio_finished():
	aliens[0].silenciar()
	$Pretutorial.start()

func _on_Pretutorial_timeout():
	setTutorial()

func setTutorial():
	if aliens[0].getEstado() == "Idle":
		$Respiro.stop()
		$Entretuto.start()
		tutorial = true
		tutoind = 0

func _on_Entretuto_timeout():
	$Mesa.setDedos(tutoind + 1)
	$Voz.stream = sonidos[randsnds[tutoind]]
	$Voz.play()
	aliens[0].setEstado("Habla")

func _on_Voz_finished():
	$Mesa.setDedos()
	aliens[0].silenciar()
	if not $Chef.getEstado() in ["Kill", "Super"]:
		if tutorial:
			tutoind += 1
			if tutoind < len(randsnds):
				$Entretuto.start()
			else:
				tutorial = false
				$Reloj.setReloj()
		if not tutorial:
			$Respiro.start(rand_range(1, 3))

func _on_Respiro_timeout():
	$Voz.stream = sonidos[randsnds[deseo - 1]]
	$Voz.play()
	aliens[0].setEstado("Habla")

func _on_BotonAyuda_pressed():
	pedirAyuda()
