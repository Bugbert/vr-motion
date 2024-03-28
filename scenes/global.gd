extends Node

var real_shape_index = randi() % 4
var user_score = 0

func xz_distance(a, b):
	var diff = a.global_position - b.global_position
	return sqrt(diff.x**2 + diff.z**2)



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
