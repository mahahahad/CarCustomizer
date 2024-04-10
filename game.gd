extends Node3D

@onready var cam: Camera3D = %Camera3D
@onready var paint_panel: Control = %Paint
@onready var change_scene_panel: Control = %ChangeScene
@onready var nav_bar: TabBar = %Navigation/PanelContainer/NavBar


@export var trans_duration := 0.6

var tween: Tween
var cam_tween: Tween

func	_ready():
	tween = create_tween()
	cam_tween = create_tween()
	paint_panel.visible = false
	paint_panel.modulate = Color("black", 1)
	change_scene_panel.visible = false
	change_scene_panel.modulate = Color("black", 1)

func	display_panel(panel: Control):
	var property_tweener

	if panel.visible:
		return
	if tween.is_running():
		tween.kill()
	if cam_tween.is_running():
		cam_tween.kill()
	cam_tween = create_tween()
	cam_tween.set_trans(Tween.TRANS_CUBIC)
	cam_tween.set_ease(Tween.EASE_IN_OUT)
	cam_tween.tween_property(cam, "position", Vector3(-0.5, 0, 6), trans_duration)
	tween = create_tween()
	tween.set_parallel()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	panel.visible = true
	tween.tween_property(panel, "modulate", Color("white", 1), trans_duration)
	property_tweener = tween.tween_property(panel, "position", Vector2(32, 32), trans_duration)
	property_tweener.from(Vector2(0, 32))

func	hide_panel(panel: Control):
	if not panel.visible:
		return 
	if tween.is_running():
		tween.kill()
	if cam_tween.is_running():
		cam_tween.kill()
	cam_tween = create_tween()
	cam_tween.set_trans(Tween.TRANS_CUBIC)
	cam_tween.set_ease(Tween.EASE_IN_OUT)
	cam_tween.tween_property(cam, "position", Vector3(0, 0, 6), trans_duration)
	tween = create_tween()
	tween.set_parallel()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(panel, "modulate", Color("black", 1), trans_duration)
	tween.tween_property(panel, "position", Vector2(0, 32), trans_duration)
	await tween.finished
	panel.visible = false

func _on_navigation_active_tab_changed(new_tab):
	if (new_tab == 1):
		await hide_panel(change_scene_panel)
		display_panel(paint_panel)
	else:
		hide_panel(paint_panel)

func	update_material(material: StandardMaterial3D):
	$Porsche.set_material(material)

func _on_paint_colour_changed(material: StandardMaterial3D):
	update_material(material)

func _input(_event):
	if Input.is_action_just_pressed("change_scene"):
		if change_scene_panel.visible:
			hide_panel(change_scene_panel)
		else:
			await hide_panel(paint_panel)
			nav_bar.current_tab = 0
			display_panel(change_scene_panel)

func _process(_delta):
	pass

func	switch_sky(path_to_sky: String):
	var new_env = Environment.new()
	var sky = Sky.new()
	var panorama_sky = PanoramaSkyMaterial.new()
	
	new_env.background_mode = Environment.BG_SKY
	panorama_sky.panorama = load(path_to_sky)
	sky.set_material(panorama_sky)
	new_env.sky = sky
	cam.environment = new_env

func _on_change_scene_button_pressed(button: Button):
	var black_env = Environment.new()
	
	black_env.background_mode = Environment.BG_COLOR
	black_env.background_color = Color("black")
	if button.get_meta("Name") == "BackButton":
		hide_panel(change_scene_panel)
	elif button.get_meta("Name") == "DayButton":
		switch_sky("res://HDRIs/lonely_road_afternoon_puresky_4k.exr")
	elif button.get_meta("Name") == "NightButton":
		switch_sky("res://HDRIs/cobblestone_street_night_4k.exr")
	else:
		cam.environment = black_env
