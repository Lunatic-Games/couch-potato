extends Node2D

const ITEMS = [
	preload("res://item/laptop.tscn"),
	preload("res://item/headset.tscn"),
	preload("res://item/drill.tscn")
]
const BOMB = preload("res://item/bomb.tscn")

const SCORE_INCREASE_SPEED = 50

var goal_score = 0
var current_score = 0
var bomb_spawn = false


func _ready():
	_on_SpawnTimer_timeout()


func _physics_process(_delta):
	if current_score < goal_score:
		current_score = min(current_score + SCORE_INCREASE_SPEED, goal_score)
	$Score.text = "SCORE: " + str(current_score)


func _on_SpawnTimer_timeout():
	var item_scene
	if bomb_spawn:
		item_scene = BOMB
	else:
		item_scene = ITEMS[randi() % ITEMS.size()]
	bomb_spawn = not bomb_spawn
	var item = item_scene.instance()
	$Conveyor.add_child(item)
	item.global_position = $Conveyor.global_position


func _on_Player_item_scored(value):
	if value >= 0:
		goal_score += value
		$Conveyor.increase()


func _on_HeartContainer_dead():
	$Player.playing = false
	$Gameover.visible = true
	$Player.hide_line()


func _on_Gameover_restart():
	$Player.playing = true
	$Player.show_line()
	$HeartContainer.reset()
	$Conveyor.reset()


func _on_Dialogue_done():
	get_tree().paused = false
	$Player.make_remote_visible()
	$Dialogue.visible = false
	$Score.visible = true
	$HeartContainer.visible = true
