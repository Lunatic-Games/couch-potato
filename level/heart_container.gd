extends HBoxContainer


signal dead

var health = 3

func damage():
	if health <= 0:
		return
	var heart = get_node("Heart" + str(health))
	heart.get_node("Full").visible = false
	heart.get_node("Empty").visible = true
	health -= 1
	if health == 0:
		emit_signal("dead")


func reset():
	for heart in get_children():
		heart.get_node("Full").visible = true
		heart.get_node("Empty").visible = false
	health = 3
