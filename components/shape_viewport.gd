extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var cubes = $Cubes
	for i in range(3):
		cubes.global_rotation[i] = randf()*2*PI


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
