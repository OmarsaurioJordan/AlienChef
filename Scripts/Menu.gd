extends Node2D

const RADIO = 40.0
const sonidos = [
	preload("res://Sounds/voz1.wav"),
	preload("res://Sounds/voz2.wav"),
	preload("res://Sounds/voz3.wav"),
	preload("res://Sounds/voz4.wav"),
	preload("res://Sounds/voz5.wav"),
	preload("res://Sounds/voz6.wav"),
	preload("res://Sounds/voz7.wav"),
	preload("res://Sounds/voz8.wav"),
	preload("res://Sounds/voz9.wav"),
]

func _ready():
	$Chef/Anima.current_animation = "Idle"
	$Ayuda/Anima.current_animation = "Idle"
	$Level/Anima.current_animation = "Idle"
	$Level.frame = get_parent().level + 3
	$Chef/ManoL/Alimento.frame = randi() % 9
	$Musica.play()

func _process(_delta):
	if $Ayuda/Boton.is_hovered():
		$Ayuda.scale = Vector2(1.1, 1.1)
	else:
		$Ayuda.scale = Vector2(1, 1)
	if $Level/Hard.is_hovered():
		$Level.scale = Vector2(1.1, 1.1)
	else:
		$Level.scale = Vector2(1, 1)
	if Input.is_action_just_pressed("key_ayuda"):
		get_parent().cambio()

func _on_Reloj_timeout():
	$Intro.play()

func _on_Intro_finished():
	$Reloj.start(rand_range(5, 10))
	$Respiro.start(rand_range(3, 4))

func _on_Boton_pressed():
	get_parent().cambio()

func _on_Voz_finished():
	$AlienV.silenciar()
	$Respiro.start(rand_range(1, 5))

func _on_Respiro_timeout():
	$AlienV.setEstado("Habla")
	$Voz.stream = sonidos[randi() % len(sonidos)]
	$Voz.play()

func _on_Hard_pressed():
	get_parent().setDificultad()
	$Level.frame = get_parent().level + 3
