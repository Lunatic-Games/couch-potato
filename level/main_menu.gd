extends ColorRect


signal start

func _ready():
	get_tree().paused = true


func _input(event):
	if event is InputEventMouseButton or event is InputEventKey:
		if event.pressed and visible:
			visible = false
			emit_signal("start")
			get_tree().set_input_as_handled()
