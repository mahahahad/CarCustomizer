extends Control

# Emits a signal when any button from this scene is pressed
# Checks which one it is in the main script

signal button_pressed(button: Button)

func _on_back_button_pressed():
	emit_signal("button_pressed", %BackButton)


func _on_day_button_pressed():
	emit_signal("button_pressed", %DayButton)


func _on_night_button_pressed():
	emit_signal("button_pressed", %NightButton)


func _on_black_button_pressed():
	emit_signal("button_pressed", %BlackButton)
