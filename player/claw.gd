extends Area2D


signal returned

const SPEED = 400.0

var sending_out = false
var coming_back = false
var grabbed_item: Node
var to_point: Vector2


func send_out(point):
	to_point = point
	sending_out = true
	coming_back = false


func _physics_process(delta):
	if !sending_out and !coming_back:
		return
	
	var v = to_point - global_position
	if v.length() <= SPEED * delta:
		global_position = to_point
		if sending_out:
			sending_out = false
			coming_back = true
			to_point = get_parent().get_node("Remote").global_position
		elif coming_back:
			coming_back = false
			emit_signal("returned", grabbed_item)
			grabbed_item = null
	else:
		position += v.normalized() * SPEED * delta
	

func is_returned():
	return (not sending_out and not coming_back)


func _on_area_entered(area):
	if area.is_in_group("item") and not grabbed_item:
		grabbed_item = area
		get_tree().call_group("camera", "shake")
		call_deferred("reparent_item", area)
		$HitSFX.play()


func reparent_item(item):
	item.get_parent().remove_child(item)
	add_child(item)
	item.global_position = global_position
	item.rotation = -rotation
