extends Node2D


const START_SPEED = 200.0
const GROW_AMOUNT = 30.0
const OUT_OF_BOUNDS = 1400

var current_speed = START_SPEED


func _physics_process(delta):
	for item in get_children():
		item.position.x += current_speed * delta
		if item.position.x > OUT_OF_BOUNDS:
			item.queue_free()


func reset():
	for item in get_children():
		item.queue_free()
	current_speed = START_SPEED


func increase():
	current_speed += GROW_AMOUNT
