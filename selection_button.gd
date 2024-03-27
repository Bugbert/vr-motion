extends Area3D

func _ready():
	set_process_input(true)
	
func _on_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Button clicked!")
		# Add your custom logic here
