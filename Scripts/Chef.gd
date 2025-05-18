extends Node2D

func _ready():
	$Cuerpo/Sangre/Chorro.emitting = false
	$Anima.current_animation = "Idle"
	$Estado.current_animation = "Idle"

func setMorir():
	if getEstado() != "Super":
		setFinal(false)
		# poner a los aliens putos
		for ali in get_parent().aliens:
			ali.setEstado("Kill")

func _on_Estado_animation_finished(anim_name):
	if anim_name.find("Accion") != -1:
		$Estado.current_animation = "Idle"
		get_parent().get_node("Olla").setCarne()
		# ver si era lo correcto
		var echo = int(anim_name.replace("Accion", ""))
		if echo == get_parent().deseo:
			get_parent().get_node("Vidas").setPunto()
		else:
			get_parent().get_node("Vidas").setFallo()

func setEstado(ind=0):
	if not get_parent().tutorial:
		if $Estado.current_animation == "Idle":
			$Estado.current_animation = "Accion" + str(ind)

func getEstado():
	return $Estado.current_animation

func setFinal(isSuper):
	if isSuper:
		$Estado.current_animation = "Super"
		get_parent().get_node("Olla").vaciar()
	else:
		$Anima.current_animation = "Kill"
		$Estado.current_animation = "Kill"
		$Cuerpo/Sangre/Chorro.emitting = true
		get_parent().get_node("Olla/Craneo").visible = true
	get_parent().get_node("MusicaCora").stop()
	get_parent().get_node("MusicaTime").stop()
	get_parent().get_node("Reloj").detener()
	get_parent().get_node("Respiro").stop()
	get_parent().get_node("Ayuda").visible = true
	get_parent().tutorial = false
	# poner sonidos finales
	get_parent().get_node("Bien").stop()
	get_parent().get_node("Mal").stop()
	if isSuper:
		get_parent().get_node("Triunfo").play()
		get_parent().get_node("Ayuda").frame = 1
		get_parent().get_parent().save()
	else:
		get_parent().get_node("Fracaso").play()
		get_parent().get_node("Ayuda").frame = 2
	
