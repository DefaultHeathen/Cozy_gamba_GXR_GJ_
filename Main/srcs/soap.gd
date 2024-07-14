@tool
extends XRToolsPickable
#20240710T0857; first main part of the game

var actual_knife : XRToolsPickable = null #20240710T1214; if null, then no CURRENT knife in contact
var hand_in_use

var handle_pos = { #T1037; dict, [.origin, rotation_degrees <- bad to use ]
	#T1040; knife or Hand place? handle will grab the hand...
	0: [Vector3(-0.1, -0.03, 0.05), Vector3(0, -180, 30)]
}

var on_slice : int = 0

@onready var slider : XRToolsInteractableSlider = get_node("CuttingRoot/InteractableSlider")


func _on_knife_detect_body_entered(body): #20240710T1031;
	
	print("soap.gd: knife body entered(): ", body)
	if body.is_in_group("knoife") and actual_knife == null: #actual_knife
		print("soap.gd: knife body entered(): knife detected!")
		actual_knife = body
		hand_in_use = body.hand_root
		
		actual_knife.hide()
		actual_knife.drop()
		hand_in_use.get_parent().global_transform.origin = slider.global_transform.origin #20240710T2108; plz change last iff
		slider.get_node("KnifeRoot/InteractableHandle").pick_up(hand_in_use)
		
	


func _on_interactable_handle_grabbed(pickable, by):
	print("soap.gd: _on_interactable_handle_grabbed(", pickable, ", ", by, ") not sure why this one is here")
	#if hand_in_use != null: #20240710T1231; assuming player has pulled hand away
		#if hand_in_use == by:
			
			
		


func _on_interactable_slider_slider_moved(_position):
	#if actual_knife == null:
	if _position <= 0.0849: #fully cut!
		on_slice +=1
		slider.slider_position = 0.0
		litter_time()
		


func litter_time():
	#1239; creates debris, changes mesh
	#1423; *breakfast & lunch break: homemade philly cheese steak sandwich [YUM]
	#new_coll.shape = batter.mesh.create_convex_shape() #T1424; the one line I needed from my old drone game, 
			#not even going to try to remember it, so here it is
	var rigid_slice = RigidBody3D.new()
	var slice : MeshInstance3D
	print("soap.gd: litter_time(): we got slice! WE GOT A SLICE!")
	match on_slice:
		0:  #reset slice?
			print("soap.gd:? what the hell kind of name is soap? \nalso this shouldn't be running, how is there a cut request when there's no cut?")
			#$SoapSLICEDDDD/SoapFull.show()
			
		1:
			$SoapSLICEDDDD/SoapFull.hide()
			$SoapSLICEDDDD/SoapCuts_1.show()
			slice = $SoapSLICEDDDD/SoapCuts_1/SoapShard_1
			slice.show()
		2:
			$SoapSLICEDDDD/SoapCuts_1.hide()
			$SoapSLICEDDDD/SoapCuts_2.show()
			slice = $SoapSLICEDDDD/SoapCuts_2/SoapShard_2
			slice.show()
		3:
			$SoapSLICEDDDD/SoapCuts_2.hide()
			$SoapSLICEDDDD/SoapCuts_3.show()
			slice = $SoapSLICEDDDD/SoapCuts_3/SoapShard_3
			slice.show()
		4:
			$SoapSLICEDDDD/SoapCuts_3.hide()
			$SoapSLICEDDDD/SoapCuts_4.show()
			slice = $SoapSLICEDDDD/SoapCuts_4/SoapShard_4
			slice.show()
		5:
			$SoapSLICEDDDD/SoapCuts_4.hide()
			$SoapSLICEDDDD/SoapCuts_5.show()
			slice = $SoapSLICEDDDD/SoapCuts_5/SoapShard_5
			slice.show()
		6:
			$SoapSLICEDDDD/SoapCuts_5.hide()
			$SoapSLICEDDDD/SoapCuts_6.show()
			slice = $SoapSLICEDDDD/SoapCuts_6/SoapShard_6
			slice.show()
		7:
			$SoapSLICEDDDD/SoapCuts_6.hide()
			$SoapSLICEDDDD/SoapCuts_7.show()
			slice = $SoapSLICEDDDD/SoapCuts_7/SoapShard_7
			slice.show()
	
	slice.get_parent().remove_child(slice)
	rigid_slice.add_child(slice)
	slice.transform.origin = Vector3()
	var coll = CollisionShape3D.new()
	rigid_slice.add_child(coll)
	#coll.shape = slice.mesh.create_convex_shape()
	coll.shape = slice.mesh.create_convex_shape() #1642; G4, not G3
	coll.transform.origin = Vector3()
	#T1438; time to see what's broken
	
			
			
