class_name ProceduralCubeShape
extends Node3D

@export var branch_count = 4
@export var max_branch_len = 5
@export var size = Vector3(10, 10, 10)

# Called when the node enters the scene tree for the first time.
func _ready():
	# This creates a simple array of Vectors that are adjacent to Vector3.ZERO.
	# The first 2 are X, second 2 Y, etc. This means that the index divided by 2
	# rounded down is the Axis
	var adjacent_vecs: Array[Vector3]
	adjacent_vecs.resize(6)
	for axis in range(3):
		for n in [-1, 1]:
			var vec = Vector3.ZERO
			vec[axis] = n
			adjacent_vecs[axis*2+max(0, n)] = vec

	# It's simplist to create the shape as an array of vectors first.
	# The "root" vector is at the origin.
	var cube_vecs: Array[Vector3] = [Vector3.ZERO]
	for _i in range(branch_count):
		var joint: Vector3
		var open_axises: Array[int]
		while !open_axises.size():
			# Choose a random vec from which to branch from.
			joint = cube_vecs[randi() % cube_vecs.size()]
			for j in range(adjacent_vecs.size()):
				var axis = floor(j/2)
				if !(joint + adjacent_vecs[j] in cube_vecs) && !(axis in open_axises):
					open_axises.append(axis)
		var axis = randi() % open_axises.size()
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
