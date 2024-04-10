extends Control

# Emits a signal from the NavBar TabBar element to the scene root whenever a 
# tab is changed

signal active_tab_changed(new_tab: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_nav_bar_tab_changed(tab):
	emit_signal("active_tab_changed", tab)
