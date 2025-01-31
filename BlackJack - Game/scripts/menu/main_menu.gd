extends Control

var fullscreen = false;
var sound = true;


func _on_new_game_button_pressed():
	DataManager.reset_all_data()
	get_tree().change_scene_to_file("res://Scene/game/game.tscn")


func _on_continue_button_pressed():
	get_tree().change_scene_to_file("res://Scene/game/game.tscn")


func _on_settings_button_pressed():
	$settings_popup.show()


func _on_about_button_pressed():
	$about_popup.show()


func _on_exit_button_pressed():
	get_tree().quit()


func _on_about_back_button_pressed():
	$about_popup.hide()


func _on_settings_back_button_pressed():
	$settings_popup.hide()


# TODO : enable and disable the game sound
func _on_settings_sound_button_pressed():
	sound = !sound
	
	if sound:
		$settings_popup/settings_items/sounnd_settings/settings_sound_button.text = "OFF"
	else:
		$settings_popup/settings_items/sounnd_settings/settings_sound_button.text = "ON"


func _on_settings_fullscreen_button_pressed():
	fullscreen = !fullscreen
	
	if(fullscreen):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		$settings_popup/settings_items/fullscreen_settings/settings_fullscreen_button.text = "ENABLE"
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		$settings_popup/settings_items/fullscreen_settings/settings_fullscreen_button.text = "DISABLE"
	
