extends RayCast3D
#20240711T1718; lunch and social outting, WON'T HAPPEN AGAIN!!
		#T2016; unforunate that the raycast is "pointed" in the wrong direction
#20240711T1939; column_dist_[detected
#var column_dist_ = {
	#
#}

@export var chip_threshold : float = 0.02 
@export var ray_riser : float = 0.004 #20240711T1913; need a way to change it in editor while in debug mode| yea
@export_node_path("Node3D") var tableroot
@export_node_path("Node3D") var neighbor_1 = null
@export_node_path("Node3D") var neighbor_2 = null
@export_enum("Street:3", "Split1_2:2", "Split2_3:1", "Doubles: 0") var cast_member : int = 0 


####### if viewed with text "normal";
# 0 | 1 | 2 | ... | 13 = "2 to 1" |
var the_x = 0 #1-13; 1-12 are the columns; 0 is 0; 13 = 3x 
var the_y = 0 #4; 0 = doubles , 1 = 3x, 2 - 4 = field  ||
var chip_radius = .02
var the_chip : XRToolsPickable = null #20240712T1221 

func where_am_(i: float, chip_global: Vector3):
	#20240711T1742; I'm sure there's a smarter way to doing this...... oh well! BIG CHONKY IF STATEMENT
	#var i.global_transform.origin.distance_to(chip_global)
	#var placement = i.distance_to(chip_global)
	
	#var dist = transform.origin.x - chip_global.x #20240711T2055; get difference if the chip was moved onto the raycast
	#var placement = chip_global.x + dist
	var dist = (transform.origin.x - chip_global.x) #20240711T2121; 
	#20240711T2152; I feel the above line is NOT going to work, maybe I have no idea what I'm doing. I'm moving ahead!
	var placement = i + (dist - 0.05) #the 0.05  is the radius of the collsion
	
	the_y = cast_member #20240712T1233; regret not using Areas3D immensely. 
	#assuming it's a straight unless more info decides
	var already_split = false #20240712T1107;
	var street_corner_six = false #20240712T1152; | 
	
	$mesh.transform.origin = Vector3(dist, position.y, position.z) #testing reason, no time to stop, gotta follow my rainbow!
	if i > -0.083: 
		if chip_x_threshold(i, -0.083, false): #it's too close to the next square.
			already_split = true
			the_x = 13
			print("CDB.gd: where_am(): ")
		else:
			the_x = 13
		if dist < chip_threshold: #20240711T2156; is it TOO close to one of the rays?
			if already_split:
				street_corner_six = true
		#else:
			
				
		the_bet_is(the_x, the_y,  )
		
		return
					
	#elif i > -0.174: #20240711T1945; ugh why couldn't I do the plant grower in the basement instead!!! >=0
		#chip_x_threshold(i, -0.083, true)
		#chip_x_threshold(i, -0.174, false)
	#elif i > 

func chip_x_threshold(placement, threshold, check_bkwards): #20240711T1744;
	#are we close to a straight/split, do we [cross] any line?
	match check_bkwards:
		false: #just seeing if it's just a little too close [to] the table's right side
			if placement - chip_threshold < threshold:
				return true #too close! it's a split!
			else:
				return false #straight
		true: #flipped, duh, is the chip "closer" to the right side of the table
			if placement + chip_threshold > threshold:
				


#func chip_y_threshold(): #20240712T1046; People have already submitted!!!!! Only 26 hours remain!
	#if dist < chip_threshold: 


#you_are(chip_x_threshold(i, -0.083, false), dist < threshold but in a func so it's true and false?)
#func you_are(placement, splitting, on_raycast):
	
