extends Area3D
#20240710T1125;

var text_in_use = 0

@export_node_path("MeshInstance3D") var left_mesh 


func _on_area_entered(area):
	match text_in_use: #20240710T1125; no time to think! using this from an old project
		1:
			get_node(left_mesh).get_surface_override_material(0).albedo_color = Color(1,1,1)
			text_in_use = 0
		0:
			get_node(left_mesh).get_surface_override_material(0).albedo_color = Color(0.518, 0.404, 0.329)
			text_in_use = 1
