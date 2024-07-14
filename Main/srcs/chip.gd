extends XRToolsPickable
#20240714T1248; hmmm maybe I need more time.... shid

var held = false

func _on_dropped(pickable):
	held = false
	await get_tree().create_timer(1.9).timeout
	if held:
		return
	#while linear_velocity.y < .01:
	#
	#var tween : Tween = get_tree().create_tween()
	##freeze = true
	#if abs(rotation_degrees.z) > 90 or abs(rotation_degrees.x) > 90:
		#tween.tween_property(self, "rotation_degrees", Vector3(0, -49.5, 0),.75)
	#else:
		#tween.tween_property(self, "rotation_degrees", Vector3(-180, -49.5, 180), .75)
	#await tween.finished
	emit_signal("sleeping_state_changed")
		#break

func _on_picked_up(pickable):
	held = true
	freeze = false
