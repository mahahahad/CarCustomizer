extends Camera3D

var mouse = Vector2()

func _input(event):
	if event is InputEventMouse:
		mouse = event.position
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_selection()

func get_selection():
	pass
	#var worldspace = get_world_3d().direct_space_state
	#var start = project_ray_origin(mouse)
	#var end = project_position(mouse, 1000)
	#var result = worldspace.intersect_ray(PhysicsRayQueryParameters3D.create(start, end))
	#if result.collider:
		#print(result.collider)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass