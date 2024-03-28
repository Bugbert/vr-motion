extends Area3D

func _ready():
	set_process_input(true)
	Global.real_shape_index
	
func _on_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Button clicked!")

		var sphereNum = 2
		if sphereNum == Global.real_shape_index:
			print("right option")
			Global.real_shape_index = randi() % 4
			get_tree().reload_current_scene()
		else:
			print("wrong option")
			Global.real_shape_index = randi() % 4
			get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
