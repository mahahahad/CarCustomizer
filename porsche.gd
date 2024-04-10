extends VehicleBody3D

@onready var door: MeshInstance3D = $"Sketchfab_model/GT3 RS_fbx/RootNode/TwiXeR_992_gt3rs_door_L/TwiXeR_992_gt3rs_door_L_TwiXeR_992_carPaint_003_0"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func	set_material(material: StandardMaterial3D):
	var s0_material: StandardMaterial3D = door.mesh.surface_get_material(0)
	s0_material.albedo_color = material.albedo_color
	s0_material.roughness = material.roughness
	s0_material.metallic = material.metallic
	s0_material.metallic_specular = material.metallic_specular

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

