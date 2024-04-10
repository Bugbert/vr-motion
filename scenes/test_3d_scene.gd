extends Node3D

@onready var options = [$Option1, $Option2, $Option3, $Option4]
@onready var player = $Player

var selected: Array[int]

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.real_shape_index = randi() % 4
	
	var subviewports = [$ShapeView1, $ShapeView2, $ShapeView3, $ShapeView4]
	for view in subviewports:
		view.get_node("Node3D/CubeGen").generate()
	
	var visible_shape = subviewports[Global.real_shape_index].get_node("Node3D/CubeGen").duplicate()
	visible_shape.global_position = Vector3.ZERO
	$VisibleShape.add_child(visible_shape)
	for i in range(3):
		$VisibleShape.global_rotation[i] = randf()*2*PI
	
	var message = "The index of the correct shape is: " + str(Global.real_shape_index)
	print(message)

func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().change_scene_to_file("res://scenes/home_menu.tscn")
	
	for option in options:
		var relative_pos = player.global_position - option.global_position
		var theta = atan(relative_pos.x / relative_pos.z)
		if relative_pos.z > 0:
			option.global_rotation.y = theta
		else:
			option.global_rotation.y = theta + PI

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed && selected.size():
			if selected[0] == Global.real_shape_index:
				Global.user_score += 1
				get_tree().change_scene_to_file("res://scenes/correct_screen.tscn")
			else:
				Global.user_score -= 1
				get_tree().change_scene_to_file("res://scenes/wrong_screen.tscn")

func entered(i, area):
	if area.name == "Pointer":
		selected.append(i)
		var sort = func(a, b):
			return Global.xz_distance(options[i], player) < Global.xz_distance(options[i], player)
		selected.sort_custom(sort)

func exited(index, area):
	if area.name == "Pointer":
		selected.remove_at(selected.find(index))

func _on_option_1_area_entered(area):
	entered(0, area)


func _on_option_2_area_entered(area):
	entered(1, area)


func _on_option_3_area_entered(area):
	entered(2, area)


func _on_option_4_area_entered(area):
	entered(3, area)


func _on_option_1_area_exited(area):
	exited(0, area)


func _on_option_2_area_exited(area):
	exited(1, area)


func _on_option_3_area_exited(area):
	exited(2, area)


func _on_option_4_area_exited(area):
	exited(3, area)
