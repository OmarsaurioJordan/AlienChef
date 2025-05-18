extends Node2D

func _on_Play_pressed():
	get_parent().cambio()

func _process(_delta):
	if Input.is_action_just_pressed("key_ayuda"):
		get_parent().cambio()
