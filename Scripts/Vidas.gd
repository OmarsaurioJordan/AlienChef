extends Node2D

func _ready():
	for vid in get_children():
		vid.get_node("Punto").visible = false

func setFallo():
	var die = true
	get_parent().get_node("Mal").play()
	for vid in get_children():
		if not vid.get_node("Punto").visible:
			vid.get_node("Punto").visible = true
			die = false
			setAliens("Mal")
			break
	if die:
		get_parent().get_node("Chef").setMorir()

func setPunto():
	get_parent().setDeseo()
	get_parent().get_node("Bien").play()
	if get_parent().setAcierto():
		if get_parent().get_node("Chef").getEstado() != "Kill":
			setAliens("Super")
			get_parent().get_node("Chef").setFinal(true)
			get_parent().get_node("Reloj").detener()
	else:
		setAliens("Bien")

func setAliens(est="Idle"):
	for ali in get_parent().aliens:
		ali.setEstado(est)
