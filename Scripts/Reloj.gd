extends Sprite

const ACELERADO = preload("res://Sounds/reloj_full.wav")
const RELOJ_FIN = 72.0
const RELOJ_ULTIMO_TRAMO = 22.0

var contador = 0.0
var is_acelerado = false
var proporcion = 1.0

func _ready():
	var level = get_parent().get_parent().level
	if level == 0:
		proporcion = 0.5
	elif level in [1, 2]:
		proporcion = 0.75
	for vid in get_children():
		if vid == $RelojFin:
			continue
		vid.visible = false

func getTimeMax():
	var tot = get_child_count() - 1
	return (RELOJ_FIN / tot) * proporcion

func getTimeMaxMax():
	return RELOJ_FIN * proporcion

func getTimeCritic():
	return (RELOJ_FIN - RELOJ_ULTIMO_TRAMO) * proporcion

func setReloj():
	if $RelojFin.is_stopped():
		$RelojFin.start(getTimeMax())
		get_parent().get_node("MusicaTime").play()

func _on_RelojFin_timeout():
	conteoTictac()
	var die = true
	for vid in get_children():
		if vid == $RelojFin:
			continue
		if not vid.visible:
			vid.visible = true
			die = false
			break
	if die:
		get_parent().get_node("Chef").setMorir()
	else:
		setReloj()

func conteoTictac():
	contador += getTimeMax()
	if contador > getTimeCritic() and not is_acelerado:
		is_acelerado = true
		get_parent().get_node("MusicaTime").stream = ACELERADO
		get_parent().get_node("MusicaTime").play()
	get_parent().get_node("MusicaCora").pitch_scale =\
		lerp(1, 2.5, contador / getTimeMaxMax())

func detener():
	$RelojFin.stop()
