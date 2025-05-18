extends Node2D

func _ready():
	setScore()
	$Anima.play("Finalizar")
	$Volver.visible = false
	if get_parent().level == 0:
		$Ente/Mensaje/Texto.text = "Graaaciaaasss!!!"

func setScore():
	$Score.visible = false
	var score = get_parent().score
	$Score.text = "0 1 2 3 4"
	for i in range(5):
		if score[i] == "x":
			$Score.text = $Score.text.replace(str(i), "X")
		else:
			$Score.text = $Score.text.replace(str(i), "_")
	$Reflexion.visible = $Score.text.count("X") >= 5

func _process(_delta):
	if Input.is_action_just_pressed("key_ayuda"):
		if $Volver.visible:
			get_parent().cambio()

func _on_Anima_animation_finished(_anim_name):
	$Volver.visible = true
	$Score.visible = true

func _on_Volver_pressed():
	get_parent().cambio()
