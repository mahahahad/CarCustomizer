extends Node3D

var zoom = 1.25

@export var max_zoom = 3
@export var min_zoom = 0.5
@export var zoom_speed = 0.08
@export var mouse_sensitivity := 0.005

var rot_speed = 0.08
var rot = 0

func _input(event):
	if Input.is_action_pressed("mouse_left"):
		if event is InputEventMouseMotion:
			if event.relative.x != 0:
				rotate_object_local(Vector3.UP, -event.relative.x * mouse_sensitivity)
			if event.relative.y != 0:
				var y_rotation = clamp(-event.relative.y, -30, 30)
				$InnerCameraPivot.rotate_object_local(Vector3.RIGHT, y_rotation * mouse_sensitivity)
	if event.is_action_pressed("scroll_down"):
		zoom += zoom_speed
	if event.is_action_pressed("scroll_up"):
		zoom -= zoom_speed
	zoom = clamp(zoom, min_zoom, max_zoom)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	scale = lerp(scale, Vector3.ONE * zoom, zoom_speed)
	$InnerCameraPivot.rotation.x = clamp($InnerCameraPivot.rotation.x, -1.1, 0.3)
