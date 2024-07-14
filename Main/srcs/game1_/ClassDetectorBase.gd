class_name RouDetector
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
#@export_node_path("Node3D") var neighbor_1 = null
#@export_node_path("Node3D") var neighbor_2 = null
@export_enum("Street:2", "Split1_2:3", "Split2_3:4", "Doubles: 1") var cast_member : int = 0 


####### if viewed with text "normal";
# 0 | 1 | 2 | ... | 13 = "2 to 1" |
var the_x = 0 #1-13; 1-12 are the columns; 0 is 0; 13 = 3x 
var the_y = 0 #4; 0 = doubles , 1 = 3x, 2 - 4 = field  ||
var coll_radius = .05
#var the_chip : XRToolsPickable = null #20240712T1221 

var depth_markers = [-1.117, -1.117, -1.041, -0.952, -0.862, -0.777, -0.604, -0.52, -0.432, 0.343, -0.258, -0.174, -0.083, 0] #20240712T1239; I GOT IT!!!!!!!!!!!!!

func where_am_(i: float, chip):
	var dist = (transform.origin.x - chip.position.x) #20240711T2121; 
	var placement = i + (dist - coll_radius) #where it is [on the depth_marker]
	#assuming it's a straight unless more info decides
	var split_vert : int = 0 #20240713T0209; 0: false | 1: to the left | 2: to the right
	var street = false #20240712T1528; | if corner_ true, th
	var corner_six = false #20240712T1528; | 
	var split_hor : int = 0 #20240713T0209; 0: false | -1: below raycast | 1: to the top
	#var six = if corner_six and street
	print("ClassDetectorBase.gd: where_am_(): ! ")
	$mesh.transform.origin = Vector3(dist, position.y, position.z) #testing reason, no time to stop, gotta follow my rainbow!
	for batter in depth_markers:
		if (batter - placement > 0.086) or chip == null: #depth is too far to matter, skipping
			continue
			
		if placement >= batter: #closer right
			if chip_x_threshold(i, batter, false): #it's too close to the next [left] square.
				split_vert += 1
			the_x = depth_markers.find(batter)
				
		elif placement < batter:
			if chip_x_threshold(i, batter, true):
				split_vert += 1 #2 #20240413T0211
			the_x = (depth_markers.find(batter)) - 1
			
			#20240712T1525; above or below line
		if chip.position.x < transform.origin.x: #below line
			the_y = cast_member
					
			if dist < chip_threshold: #20240711T2156; it's TOO close to one of the rays!\
				split_hor = -1
					
		else:
			the_y = cast_member - 1
			if dist < chip_threshold: #20240711T2156; it's TOO close to one of the rays!\
				split_hor = 1
			
		if split_vert != 0:
			split_vert += 1
			if cast_member == 3:
				street = true #it's a six! (needs corner_six to be true
			corner_six = true #it's a corner!
			
		else: 
			if cast_member == 3:
				street = true #it's only touching one line!
	
		#else: #is not too close
			#it's a straight!
			
		break
			
	print("CDB.gd: where_am(): 
				cast_member: ", cast_member,
				"\nthe_x, ",the_x,
				", \nthe_y: ", the_y,
				", \nsplit_vert: ", split_vert, 
				", \nstreet: ", street, 
				", \ncorner_six: ", corner_six,
				", \nsplit_hor: ", split_hor,
				"\ntableroot: ", tableroot,
			)
	get_node(tableroot).the_bet(chip, the_x, the_y, split_vert, split_hor, street, corner_six)


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
				return true
			else:
				return false

#func chip_y_threshold(): #20240712T1046; People have already submitted!!!!! Only 26 hours remain!

