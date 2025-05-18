extends Node2D

var relojOjos = 0.0
var relojHabla = 0.0

func _ready():
	match name:
		"AlienL":
			$Anima.playback_speed = 0.9
			$Estado.playback_speed = 0.9
		"AlienR":
			$Anima.playback_speed = 1.0
			$Estado.playback_speed = 1.0
		"AlienM":
			$Anima.playback_speed = 1.1
			$Estado.playback_speed = 1.1
	setEstado()

func _process(delta):
	if getEstado() in ["Idle", "Habla"]:
		relojOjos -= delta
		if relojOjos <= 0:
			if $Craneo/OjoL.frame == 1:
				$Craneo/OjoL.frame = 2
				$Craneo/OjoR.frame = 2
				relojOjos = rand_range(0.1, 0.2)
			else:
				$Craneo/OjoL.frame = 1
				$Craneo/OjoR.frame = 1
				relojOjos = rand_range(0.1, 2.0)
	if getEstado() == "Habla":
		relojHabla -= delta
		if relojHabla <= 0:
			relojHabla = rand_range(0.1, 0.3)
			var bocas = [8, 9, 10, 14, 15, 16]
			var ant = $Craneo/Boca.frame
			$Craneo/Boca.frame = bocas[randi() % bocas.size()]
			while $Craneo/Boca.frame == ant:
				$Craneo/Boca.frame = bocas[randi() % bocas.size()]

func setEstado(est="Idle"):
	if not getEstado() in ["Kill", "Super"]:
		$Estado.current_animation = est
		if est in ["Kill", "Super", "Idle"]:
			$Anima.current_animation = est
		elif est == "Bien":
			$Anima.current_animation = "Super"
		elif est == "Mal":
			$Anima.current_animation = "Kill"
		else:
			$Anima.current_animation = "Idle"
		if est in ["Idle", "Habla"]:
			$Craneo/OjoL.frame = 1
			$Craneo/OjoR.frame = 1

func getEstado():
	return $Estado.current_animation

func silenciar():
	if getEstado() == "Habla":
		setEstado()

func _on_Estado_animation_finished(anim_name):
	if anim_name in ["Bien", "Mal", "Habla"]:
		if name == "AlienM":
			if (get_parent().get_node("Inicio").playing or
					get_parent().get_node("Voz").playing):
				setEstado("Habla")
				return null
		elif name == "AlienV":
			if get_parent().get_node("Voz").playing:
				setEstado("Habla")
				return null
		setEstado()
