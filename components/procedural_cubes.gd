class_name ProceduralCubeShape
extends Node3D

# As Vector3s can be indexed as arrays, (0, 1, 2) substitute (X, Y, Z) in many
# Places in this script.

# These can be added to and subtracted from vectors to get the ones adjacent.
const ADJACENT_VECS = [Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1)]

func generate(branch_count=3, max_branch_len=4):
	print("randomizing!")
	# It's simplist to create the shape as an array of vectors first.
	# The "root" vector is at the origin.
	var cube_vecs: Array[Vector3] = [Vector3.ZERO]
	for _i in range(branch_count):
		# Joint specifies the vector from which the branch will spawn
		var joint: Vector3
		# Array of axises that are available as to prevent branches folding
		# in on themselves
		var open_axises: Array[int]
		# Keep choosing a radom joint unitl one has availabe axises
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
		# Make sure the branch length isn't zero
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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
