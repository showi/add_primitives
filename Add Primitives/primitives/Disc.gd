extends "../Primitive.gd"

var outer_radius = 1.0
var inner_radius = 0.5
var segments = 16
var slice = 0

static func get_name():
	return "Disc"
	
static func get_container():
	return "Extra Objects"
	
func update():
	var slice_angle = PI * 2 - deg2rad(slice)
	
	var circle = Utils.build_circle_verts(Vector3(), segments, 1, slice_angle)
	
	begin()
	
	add_smooth_group(smooth)
	
	for i in range(segments):
		var uv = [Vector2(circle[i].x, circle[i].z) * inner_radius,
		          Vector2(circle[i].x, circle[i].z) * outer_radius,
		          Vector2(circle[i+1].x, circle[i+1].z) * outer_radius,
		          Vector2(circle[i+1].x, circle[i+1].z) * inner_radius]
		
		add_quad([circle[i] * inner_radius, circle[i] * outer_radius,
		          circle[i+1] * outer_radius, circle[i+1] * inner_radius], uv)
		
	commit()
	
func mesh_parameters(editor):
	editor.add_numeric_parameter('outer_radius', outer_radius)
	editor.add_numeric_parameter('inner_radius', inner_radius)
	editor.add_numeric_parameter('segments', segments, 3, 64, 1)
	editor.add_numeric_parameter('slice', slice, 0, 359, 1)
	
