extends Node3D
#20240712T2004; ROLLING AROUND AT THE SPEED OF SOUND


var the_book = { #20240712T2040; a winning number
  # 18 : [chip, multiplier, chip, 37x, a different bet/chip, 3x]
  # : [odds are chips, evens are multiplier because I hate myself so much]
	#the_book[batter].
	
	}

var pot = 0
var chips_detected = []
var chips_in_play = 0
var winning_number = null #20240712T2102; 17 HOURSS!!!? ONLY EXPORTED TWICE AND IT WAS THE SAME SCENE!!
var winning_chips = []
var red = [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36 ] #20240713T1342;
var spinning = false #20240714T1020; almost done!! T-4H37M
var open_bets = true
var base_text = "ROI: %s | #: %s"
var multi = 0 #20240714T1130

@export var chip_spawn_location : Vector3 #20240712T2121. global would be nice



@onready var chip_ = preload("res://tscns/chip.tscn")
@onready var cast_2_3 = get_node("Regret/Split 2_3")
@onready var cast_1_2 = get_node("Regret/Split 1_2")
@onready var cast_street = get_node("Regret/StreetColumn")
@onready var cast_doubles = get_node("Regret/Doubles")


var casts_ = []


#20240712T2029; :00000000 I just realized..... My raycast doesn't work if there's stacked chips!!
		#I just did crap but didn't see what I was doing! :///


#from https://www.roulettestar.com/guide/probability/
#Bet Type	Fraction	Ratio	Percentage
##Even (e.g. Red/Black)	1/2.11	1.11 to 1	47.4%
##Column	1/3.16	2.16 to 1	31.6%
##Dozen	1/3.16	2.16 to 1	31.6%
##Six Line	1/6.33	5.33 to 1	15.8%
#Corner	1/9.50	8.50 to 1	10.5%
##Street	1/12.67	11.67 to 1	7.9%
#Split	1/19.00	18.00 to 1	5.3%
##Straight	1/38.00	37.00 to 1	2.6%


func _ready():
	update_info() #20240714T1131; let's see if the label.text is understood


func the_bet(chip, the_x, the_y, split_vert, split_hor, street, corner_six):
	#already_split, street, and corner_six
			#ARE ONLY USED if the_x & the_y are within:
			# (x,y) = (1-12,2-4), otherwise it's NOT a straight bet
	#the_x = 0 #1-13; 1-12 are the columns; 0 is 0; 13 = 3x 
	#the_y = 0 #4; 0 = doubles , 1 = 3x, 2 - 4 = field  ||
	#straight, split/reside, corner, six, column, dozen, 
	#var corner_si #20240713T0017; OPTIMIZATIONS?!? AT T-14 HOURS AND 40 MINS?!?!
	
	#var num = (the_x * 3) * (the_y - 1)
	#var num = (the_x + the_x + 1) * (the_y - 1)
	# x,y = num | (1,1) = 1 | (2,1) = 4 | (6,2) = 17 |(8,1) = 22| 
	if chips_detected.has(chip):
		return
	var num = (the_x * 3) + (the_y - 3) #20240713T1306;
	
	#call_deferred("update_info") #20240714T1411; hopefully goes after all this
	
	if the_y in range(-1,2): # and the_x in range(1,13):
		
		if split_vert == 0 and split_hor > 0 and the_y == 1:
			if street: #below ray
				the_book[num] = [chip, 11]
				the_book[num + 1] = [chip, 11]
				the_book[num + 2] = [chip, 11]
				call_deferred("update_info")
				return
		#if split_vert != 0 and split_hor == 0:
		#if split_hor == 0: used colls, T-1H36M AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
		if the_y == 1:
			if the_x in range(1, 5): #1st 18
				for batter in range(1, 13):
					the_book[batter] = [chip, 2]
				call_deferred("update_info")
				return
			elif the_x in range(5, 9): #2nd
				for batter in range(13, 25):
					the_book[batter] = [chip, 2]
				call_deferred("update_info")
				return
			elif the_x in range(9, 13): #3rd
				for batter in range(25, 37):
					the_book[batter] = [chip, 2]
				call_deferred("update_info")
				return
		else: #20240713T1345; T-1H13M
			if the_x in range(1, 3): #1 - 18
				for batter in range(1, 19,):
					the_book[batter] = [chip, 1]
				call_deferred("update_info")
				return
			if the_x in range(3, 5): #Even
				for batter in range(2, 37, 2):
					the_book[batter] = [chip, 1]
				call_deferred("update_info")
				return
			if the_x in range(5, 7): #Red
				for batter in red:
					the_book[batter] = [chip, 1]
				call_deferred("update_info")
				return
			if the_x in range(7, 9): #Blk
				for batter in range(1, 37):
					if red.has(batter):
						continue
					the_book[batter] = [chip, 1]
				call_deferred("update_info")
				return
			if the_x in range(3, 5): #Odd
				for batter in range(1, 37, 2):
					the_book[batter] = [chip, 1]
				call_deferred("update_info")
				return
			
				
					
	
	if the_x == 0 or the_x == 13:
		#20240713T1124; AAAAAAAAAAA T-3H33M
		match the_x:
			0:
				the_book[0] = [chip, 36]
				#the_book[0].append_array([chip, 36])
				call_deferred("update_info")
				return
			13:
				var temp = the_y
				for batter in range(13):
					the_book[temp] = [chip, 2]
					temp += 3
					continue
				call_deferred("update_info")
				return
				#match the_y:
					#1:
					#2:
						#var temp = the_y
						#for batter in range(12):
							#the_book[temp]
							#var temp += 3
							#
							
	if the_y >= 2 and the_x in range(1,13): #in field
		
		if split_vert == 0 and split_hor == 0: #straight?! in the middle??
			the_book[num] = [chip, 36]
			call_deferred("update_info")
			return
		
		elif split_vert == 0 and split_hor > 0: #false and touching raycast
		#20240713T0207; got into a flow here, I think I may have something. I'll sleep once all the bets are in.
		#20240713T0229; well, decided to redo most of this.... I could sleep but I'd lose so much time
		#20240713T1109; I SLEPT AND IT WAS A BAD IDEA AHHHHHHHH
			if street: #above the raycast
				the_book[num] = [chip, 11]
				the_book[num + 1] = [chip, 11]
				the_book[num + 2] = [chip, 11]
				call_deferred("update_info")
				return
			if split_hor == -1: # horizontal split
				the_book[num] = [chip, 17]
				the_book[num - 1] = [chip, 17]
				call_deferred("update_info")
				return
			elif split_hor == 1: # horizontal split
				the_book[num] = [chip, 17]
				the_book[num + 1] = [chip, 17]
				call_deferred("update_info")
				return
				
		elif split_vert == 1: #Goes to the left #20240713T11358; T-1H0M30S!!!!!! LAST ITEM!!!!! LAST CALLLL
			match split_hor:
				0: #just a vert split
					the_book[num] = [chip, 17]
					if the_x > 2:
						the_book[num] = [chip, 17]
						the_book[num - 3] = [chip, 17]
						call_deferred("update_info")
						return
				-1: #Touching BOTTOM ray and LEFT CORNER!
					if street: #SIX DETECTED!!! #20240713T1402!!!!
						the_book[num] = [chip, 4]
						the_book[num + 1] = [chip, 4]
						the_book[num + 2] = [chip, 4]
						the_book[num - 1] = [chip, 4]
						the_book[num - 2] = [chip, 4]
						the_book[num - 3] = [chip, 4]
						call_deferred("update_info")
						return
					if the_y > 1: # CORNER!!!!
						the_book[num] = [chip, 7]
						the_book[num - 1] = [chip, 7]
						the_book[num - 5] = [chip, 7]
						the_book[num - 4] = [chip, 7]
						call_deferred("update_info")
						return
				1: #Touching TOP RAY AND LEFT CONER
					if the_y < 3: #CORNER!!! 20240713T1424; T-37M32S
						the_book[num] = [chip, 7]
						the_book[num + 1] = [chip, 7]
						the_book[num - 2] = [chip, 7]
						the_book[num - 3] = [chip, 7]
						call_deferred("update_info")
						return
		elif split_vert == 2:
			match split_hor:
				0: #just a vert split
					if the_x < 12:
						the_book[num] = [chip, 17]
						the_book[num + 3] = [chip, 17]
						call_deferred("update_info")
						return
				-1: #Touching BOTTOM ray and RIGHT CORNER!
					if street: #SIX DETECTED!!! #20240713T1402!!!!
						the_book[num] = [chip, 4]
						the_book[num - 1] = [chip, 4]
						the_book[num - 2] = [chip, 4]
						the_book[num + 1] = [chip, 4]
						the_book[num + 2] = [chip, 4]
						the_book[num + 3] = [chip, 4]
						call_deferred("update_info")
						return
					if the_x < 12 and the_y > 2: # CORNER!!!!
						the_book[num] = [chip, 7]
						the_book[num + 1] = [chip, 7]
						the_book[num + 3] = [chip, 7]
						the_book[num + 4] = [chip, 7]
						call_deferred("update_info")
						return
				1: #Touching TOP RAY AND RIGHT CONER
					if the_y < 3 and the_y < 4: #CORNER!!! 20240713T1424; T-37M32S
						the_book[num] = [chip, 7]
						the_book[num - 1] = [chip, 7]
						the_book[num + 3] = [chip, 7]
						the_book[num + 4] = [chip, 7]
						call_deferred("update_info")
						return
						
					
		#elif split_vert > and split_hor == 0:
			#
			#if split_vert_rside: #one final check
				#
				#return
			#if street:
			#
			#
		#if split_vert:
			#if !split_vert_rside:
				#if the_x > 0:
					#
			#else:
				#if the_x < 12:
					#
				#
				#
		#
		#
		##if corner_six and street and !already_split: #not poss
		##if corner_six and street and !split: #not poss
		#if corner_six: #corner
		#if corner_six and street: #six line
		#if !corner_six and street and !split: #street
		#if !corner_six and !street and split: #spilt
		#else:#straight
			#
			#
			#
		#return
	#if
		#
		#
	

#func spin_end(): #20240713T1332;
	#for batter in the_book:
		#if batter != winning_number:
			#call_deferred("claim_chip", batter)
			#continue
	#
		#if batter == winning_number:
			#winrar()


func winrar(): #20240712T2104;
##for key in my_dict:
	##var value = my_dict[key]
	##print("Key:", key, "Value:", value)
	

	if !the_book.has(winning_number):
		return
	var win_info = the_book.get(winning_number)
	var payee
	var winnings = 0
	for batter in win_info:
		#if batter is XRToolsPickable
		if batter is RigidBody3D: #is chip
			if !chips_in_play.has(batter):
				# old chip!! skipping!
				return
			else:
				print("roulette.gd: winrar(): batter is ", batter)
				payee = batter
				winning_chips.append(batter)
				continue
		else: #is monies, pay-up time
			winnings += batter
			ticket_printer(winnings, batter.global_transform.origin)
	call_deferred("update_info")
	call_deferred("reset_books") #20240713T0117; 
	#for batter in the_book:
		#if batter  != winning_number 
		



func reset_books():
	#20240713T0117; 
	the_book = []
	open_bets = true
	multi = 0
	for batter in chips_in_play:
		if batter != winning_chips:
			claim_chip(batter)

func ticket_printer(spawn_count, glob_pos : Vector3):
	#20240713T1144;
	for batter in spawn_count:
		var new_chip : RigidBody3D = chip_.instantiate()
		add_child(new_chip)
		glob_pos.y += 1
		new_chip.global_transform.origin = glob_pos
		new_chip.picked_up.connect(_remove_chip)
		new_chip.sleeping_state_changed.connect(_check_field)


func _remove_chip(free_chips):
	#20240713T1202;
	if chips_in_play.has(free_chips):
		chips_in_play.remove(free_chips)
		casts_ = [cast_2_3, cast_1_2, cast_street, cast_doubles]
		for batter in casts_:
			casts_.remove_exception(free_chips) #20240713T1223; hellloooo errors T-2H35M


func _check_field():
	if !open_bets:
		return
	casts_ = [cast_2_3, cast_1_2, cast_street, cast_doubles]
	
	for batter in casts_:
		if batter.is_colliding():
			print(batter.get_collision_point().distance_to(batter.global_position) ,"|", batter.get_collider() )
			batter.call_deferred(batter.where_am_(batter.get_collision_point().distance_to(batter.global_position) , batter.get_collider()))
			batter.add_exception(batter.get_collider())
			batter.force_raycast_update()
			casts_.append(batter) #we run it again to clear the raycast

func claim_chip(chip): #20240713T1328; T-1H30M
	chip.call_deferred("queue_free")


func _on_chip_sleeping_state_changed():
	_check_field()
	print("roulette.gd: _on_chip_sleeping_(): !")


func _on_begin_detect_area_entered(area):
	if !spinning:
		spinning = true
		$sfx.play()
		#await  get_tree().create_timer() #20240714T1134; idk what happened to await#
		$Timer.start(15.1)
		$AnimationPlayer.play("SPINMONKEYBALLSPIN")
		


func update_info():
	#20240714T1121; this ain't no thang, done it a 100 times.... in godot 3
	#if the_book.is_empty():
		#return
	
	if !the_book.is_empty():
		multi = 0
		for num in the_book.keys():
			for batter in num:
				var skip_chip = false
				if batter is RigidBody3D: #is chip
					if !chips_in_play.has(batter):
						skip_chip = true
						continue
					else:
						skip_chip = false #20240714T1124; don't need to do this.. right?
						continue
				else: #is monies, pay-up time
					if skip_chip:
						skip_chip = false
						continue
					multi += batter
	if winning_number == null:
		#$Label.text = base_text % [multi, "OPEN"]
		$Label.text = "ROI: %s | #: %s" % ["RDY", "OPEN"]
	else:
		$Label.text = base_text % [multi, String(winning_number)]


func _no_more_bets():
	#20240714T1113;
	open_bets = false
	$Label.text = base_text % [pot, "NMBets"]




func _on_sfx_finished(): #20240714T1128; done?
	winning_number =  randi() % 37
	call_deferred("winrar")


func _on_timer_timeout():
	call_deferred("_no_more_bets")
