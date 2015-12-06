extends "../Primitive.gd"

var height = 2.0
var outer_radius = 1.0
var inner_radius = 0.5
var sides = 16
var slice = 0
var generate_top = true
var generate_bottom = true
var generate_ends = true

static func get_name():
	return "Tube"
	
func update():
	var ofs = Vector3(0, height/2, 0)
	var slice_angle = PI * 2 - deg2rad(slice)
	
	var ic = Utils.build_circle_verts(Vector3(), sides, inner_radius, slice_angle)
	var oc = Utils.build_circle_verts(Vector3(), sides, outer_radius, slice_angle)
	
	begin()
	
	add_smooth_group(false)
	
	if generate_top or generate_bottom:
		for idx in range(sides):
			if generate_top:
				add_quad([oc[idx + 1] + ofs, ic[idx + 1] + ofs, ic[idx] + ofs, oc[idx] + ofs])
				
			if generate_bottom:
				add_quad([oc[idx] - ofs, ic[idx] - ofs, ic[idx + 1] - ofs, oc[idx + 1] - ofs])
				
	if generate_ends and slice:
		add_quad([oc[0] + ofs, ic[0] + ofs, ic[0] - ofs, oc[0] - ofs])
		add_quad([ic[sides] + ofs, oc[sides] + ofs, oc[sides] - ofs, ic[sides] - ofs])
		
	add_smooth_group(smooth)
	
	for idx in range(sides):
		add_quad([oc[idx + 1] + ofs, oc[idx] + ofs, oc[idx] - ofs, oc[idx + 1] -ofs])
		add_quad([ic[idx] + ofs, ic[idx + 1] + ofs, ic[idx + 1] - ofs, ic[idx] -ofs])
		
	commit()
	
func mesh_parameters(editor):
	editor.add_tree_range('Height', height)
	editor.add_tree_range('Outer Radius', outer_radius)
	editor.add_tree_range('Inner Radius', inner_radius)
	editor.add_tree_range('Sides', sides, 3, 64, 1)
	editor.add_tree_range('Slice', slice, 0, 359, 1)
	editor.add_tree_empty()
	editor.add_tree_check('Generate Top', generate_top)
	editor.add_tree_check('Generate Bottom', generate_bottom)
	editor.add_tree_check('Generate Ends', generate_ends)
	

