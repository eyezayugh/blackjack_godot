extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_game_button_pressed():
	pass # Replace with function body.


func _on_continue_button_pressed():
	pass # Replace with function body.


func _on_settings_button_pressed():
	pass # Replace with function body.


func _on_about_button_pressed():
	$about_popup.show()


func _on_exit_button_pressed():
	get_tree().quit()


func _on_about_back_button_pressed():
	$about_popup.hide()
