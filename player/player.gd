extends Area2D


signal item_scored

var playing = true


func _unhandled_input(event):
	if event.is_action_pressed("claw") and $Claw.is_returned() and playing:
		send_claw_out()


func _physics_process(_delta):
	if not playing:
		return
	update_angle()


func update_angle():
	var mouse_position = get_global_mouse_position()
	var remote_position = $Line.global_position
	var v = mouse_position - remote_position
	$Line.region_rect.size.y = int(v.length() / 3.0)
	$Line.region_rect.size.y -= int($Line.region_rect.size.y) % 2
	$Line.offset.y = int(v.length() / 6.0)
	$Line.rotation = v.angle() - PI / 2.0
	if cos($Line.rotation) < 0.0 and sin($Line.rotation) > 0.0:
		$Line.rotation = PI/2.0
	if cos($Line.rotation) < 0.0 and sin($Line.rotation) < 0.0:
		$Line.rotation = -PI/2.0
		
	if $Claw.is_returned():
		$Claw.rotation = $Line.rotation


func send_claw_out():
	$Claw.send_out(get_global_mouse_position())
	$Line.visible = false
	$ShootSFX.play()


func _on_Claw_returned(item):
	$Line.visible = true
	if item:
		emit_signal("item_scored", item.value)
		if item.is_in_group("bomb"):
			$Explosion.visible = true
			$Explosion.frame = 0
			$Explosion.play()
			$ExplosionSFX.play()
			get_tree().call_group("heart_container", "damage")
		else:
			$PickupSFX.play()
		item.queue_free()


func _on_Explosion_animation_finished():
	$Explosion.visible = false
	

func hide_line():
	$Line.visible = false


func show_line():
	$Line.visible = true


func make_remote_visible():
	$Remote.visible = true
	$Claw.visible = true
