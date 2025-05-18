extends Node2D

const carnita = preload("res://Scenes/Carne.tscn")

func setCarne():
	if $Carnes.get_child_count() < 20:
		var carne = carnita.instance()
		$Carnes.add_child(carne)

func vaciar():
	for carne in $Carnes.get_children():
		carne.queue_free()
