extends Node

# la dificultad va de 0 a 4
var level = 3
var score = "01234"

func _ready():
	randomizar()
	var archivo = File.new()
	var ruta = "user://save.txt"
	if archivo.file_exists(ruta):
		if archivo.open(ruta, File.READ) == OK:
			var txt = archivo.get_line()
			archivo.close()
			if len(txt) == 5:
				score = txt

func save():
	score = score.replace(str(level), "x")
	var archivo = File.new()
	var ruta = "user://save.txt"
	if archivo.open(ruta, File.WRITE) == OK:
		archivo.store_line(score)
		archivo.close()

func setDificultad():
	level -= 1
	if level < 0:
		level = 4

func cambio(gano=false):
	var child = get_child(0)
	match child.name:
		"Menu":
			add_child(load("res://Scenes/Juego.tscn").instance())
		"Juego":
			if gano:
				add_child(load("res://Scenes/Final.tscn").instance())
			else:
				add_child(load("res://Scenes/Menu.tscn").instance())
		_:
			add_child(load("res://Scenes/Menu.tscn").instance())
	child.queue_free()

func randomizar():
	randomize()
	for _i in range(randi() % 10 + 1):
		for _j in range(randi() % 10 + 1):
			var _t = randf() < 0.5
		randomize()
