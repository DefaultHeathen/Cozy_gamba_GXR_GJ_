	
extends XRToolsPickable


#20240710T1027; what's this for again?
var hand_root #1218; retain for smoke and mirror



func _on_grabbed(pickable, by): #1220;
	print("not_gun.gd: _on_grabbed(", pickable, ", ", by, ")")
	hand_root = by
