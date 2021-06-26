extends ColorRect


signal restart

func _input(event):
	if event is InputEventMouseButton or event is InputEventKey:
		if event.pressed and visible:
			visible = false
			emit_signal("restart")
			get_tree().set_input_as_handled()
