extends ColorRect


signal done


func dialogue():
	visible = true
	yield(get_tree().create_timer(0.3), "timeout")
	yield(type($DadDialogue, "Missssssy, get in here!"), "completed")
	$AnimationPlayer.play("entrance")


func entrance_done():
	yield(type($DaughterDialogue, "What is it, Dad?"), "completed")
	yield(type($DadDialogue, "Can you grab me something?"), "completed")
	yield(type($DaughterDialogue, "Get it yourself, ya lazy couch potato", 1.5), "completed")
	$AnimationPlayer.play("exit")


func exit_done():
	yield(get_tree().create_timer(1.0), "timeout")
	yield(type($DadDialogue, "Kids these days..."), "completed")
	yield(type($DadDialogue, "Luckily", 0.5), "completed")
	yield(type($DadDialogue, "I don't have to get up"), "completed")
	yield(type($DadDialogue, "Thanks to my GRABBER-9000", 2.0), "completed")
	emit_signal("done")


func type(label, text, wait=1.0):
	label.text = ""
	label.visible = true
	$TextSFX.play()
	for c in text:
		label.text += c
		yield(get_tree(), "idle_frame")
		yield(get_tree(), "idle_frame")
	$TextSFX.stop()
	yield(get_tree().create_timer(wait), "timeout")
	label.visible = false


func _on_MainMenu_start():
	$AnimationPlayer.play("pop_up")
