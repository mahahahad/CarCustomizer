extends Control

signal colour_changed(new_material: StandardMaterial3D)
signal material_changed(new_material: StandardMaterial3D)

@export var new_colour: Color
@export var new_material: StandardMaterial3D = StandardMaterial3D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	for n: ColorRect in %ColourContainer.get_children():
		n.gui_input.connect(_on_color_rect_pressed.bind(n))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_color_rect_pressed(event: InputEvent, color_rect_element: ColorRect):
	if event is InputEventMouseButton and event.is_pressed():
		handle_colour_picked(color_rect_element.color)

func	handle_colour_picked(colour: Color):
	new_colour = colour
	new_material.albedo_color = colour
	emit_signal("colour_changed", new_material)

func _on_color_picker_color_changed(color):
	%ColourPickerButton/PlusIcon.visible = false
	new_colour = color
	new_material.albedo_color = color
	emit_signal("colour_changed", new_material)


func _on_finish_metallic_button_pressed():
	new_material.roughness = 0.1
	new_material.metallic = 0.95
	new_material.metallic_specular = 1
	emit_signal("material_changed", new_material)


func _on_finish_matte_button_pressed():
	new_material.roughness = 0.9
	new_material.metallic = 0.05
	new_material.metallic_specular = 0
	emit_signal("material_changed", new_material)
