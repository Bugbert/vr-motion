class_name ProceduralCubeShape
extends Node3D

@export var branch_count = 3
@export var max_branch_len = 5
@export var size = Vector3(10, 10, 10)

const ADJACENT_VECS = [Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1)]

# Called when the node enters the scene tree for the first time.
func _ready():
	# It's simplist to create the shape as an array of vectors first.
	# The "root" vector is at the origin.
	var cube_vecs: Array[Vector3] = [Vector3.ZERO]
	for _i in range(branch_count):
		var joint: Vector3
		var open_axises: Array[int]
		while !open_axises.size():
			# Choose a random vec from which to branch from.
			joint = cube_vecs[randi() % cube_vecs.size()]
			for j in range(3):
				var up_free = !(joint - ADJACENT_VECS[j] in cube_vecs)
				var down_free = !(joint + ADJACENT_VECS[j] in cube_vecs)
				if up_free && down_free:
					open_axises.append(j)
		var axis = open_axises[randi() % open_axises.size()]
		var branch_len: int
		while !branch_len:
			branch_len = randi_range(-max_branch_len, max_branch_len)
		for j in range(abs(branch_len)):
			var new_cube = joint
			new_cube[axis] += ((j+1)*sign(branch_len))
			cube_vecs.append(new_cube)
	
	for vec in cube_vecs:
		var new_cube = $Cube.duplicate()
		new_cube.global_position = vec
		add_child(new_cube)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
