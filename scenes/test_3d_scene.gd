extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	var subviewports = [$ShapeView1, $ShapeView2, $ShapeView3, $ShapeView4]
	for view in subviewports:
		view.get_node("Node3D/CubeGen").generate()

	var real_shape_index = randi() % 4
	var visible_shape = subviewports[real_shape_index].get_node("Node3D/CubeGen").duplicate()
	for i in range(3):
		visible_shape.global_rotation[i] = randf()*2*PI
	add_child(visible_shape)
	visible_shape.global_position = Vector3(0, 10, -10)
	
	print(real_shape_index)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
