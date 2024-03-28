extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.real_shape_index
	randomize()
	
	var subviewports = [$ShapeView1, $ShapeView2, $ShapeView3, $ShapeView4]
	for view in subviewports:
		view.get_node("Node3D/CubeGen").generate()

	
	var visible_shape = subviewports[Global.real_shape_index].get_node("Node3D/CubeGen").duplicate()
	for i in range(3):
		visible_shape.global_rotation[i] = randf()*2*PI
	add_child(visible_shape)
	visible_shape.global_position = Vector3(0, 6, -10)
	
	var message = "The index of the correct shape is: " + str(Global.real_shape_index)
	print(message)



func _process(_delta):
	pass
