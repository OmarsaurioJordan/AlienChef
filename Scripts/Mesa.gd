extends Node2D

var ingredientes = []

func _ready():
	ingredientes = [
		$Tabla3/Alimento1, $Tabla3/Alimento2, $Tabla3/Alimento3,
		$Tabla2/Alimento4, $Tabla2/Alimento5, $Tabla2/Alimento6,
		$Tabla1/Alimento7, $Tabla1/Alimento8, $Tabla1/Alimento9
	]
	for ing in ingredientes:
		ing.visible = false
	setDedos()

func setIngredientes(cuantos=9):
	var c = 0
	for ing in ingredientes:
		ing.visible = true
		c += 1
		if c >= cuantos:
			break

func _process(_delta):
	var i = 1
	for alim in ingredientes:
		if alim.get_node("Boton" + str(i)).is_hovered():
			alim.scale = Vector2(1.2, 1.2)
		else:
			alim.scale = Vector2(1, 1)
		i += 1
	teclas()

func setDedos(ind=0):
	for alim in ingredientes:
		alim.get_node("Dedo").visible = alim.name.count(str(ind)) > 0

func teclas():
	if Input.is_action_just_pressed("key_1"):
		seleccion(1)
	elif Input.is_action_just_pressed("key_2"):
		seleccion(2)
	elif Input.is_action_just_pressed("key_3"):
		seleccion(3)
	elif Input.is_action_just_pressed("key_4"):
		seleccion(4)
	elif Input.is_action_just_pressed("key_5"):
		seleccion(5)
	elif Input.is_action_just_pressed("key_6"):
		seleccion(6)
	elif Input.is_action_just_pressed("key_7"):
		seleccion(7)
	elif Input.is_action_just_pressed("key_8"):
		seleccion(8)
	elif Input.is_action_just_pressed("key_9"):
		seleccion(9)

func seleccion(ind=0):
	if ingredientes[ind - 1].visible:
		get_parent().get_node("Chef").setEstado(ind)

func _on_Boton1_pressed():
	seleccion(1)

func _on_Boton2_pressed():
	seleccion(2)

func _on_Boton3_pressed():
	seleccion(3)

func _on_Boton4_pressed():
	seleccion(4)

func _on_Boton5_pressed():
	seleccion(5)

func _on_Boton6_pressed():
	seleccion(6)

func _on_Boton7_pressed():
	seleccion(7)

func _on_Boton8_pressed():
	seleccion(8)

func _on_Boton9_pressed():
	seleccion(9)
