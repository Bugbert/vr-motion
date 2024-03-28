extends Node3D

@onready var options = [$Option1, $Option2, $Option3, $Option4]
@onready var player = $Player

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
	for option in options:
		var relative_pos = player.global_position - option.global_position
		var theta = atan(relative_pos.x / relative_pos.z)
		if relative_pos.z > 0:
			option.global_rotation.y = theta
		else:
			option.global_rotation.y = theta + PI


func _on_option_1_area_entered(area):
	pass # Replace with function body.


func _on_option_2_area_entered(area):
	pass # Replace with function body.


func _on_option_3_area_entered(area):
	pass # Replace with function body.


func _on_option_4_area_entered(area):
	pass # Replace with function body.
