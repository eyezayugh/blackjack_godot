extends Node3D

var card_scene = preload("res://Scene/game/objects/card.tscn")

var current_x_offset = 0.0;
var x_step = 26

var amount_off_card = 0.0

func _input(event):
	if event.is_action_pressed("ui_accept"):
		add_card(0);

func add_card(id):
	var new_card = card_scene.instantiate()
	
	new_card.transform.origin.x = current_x_offset
	current_x_offset += x_step
	
	$cards.add_child(new_card)
	
	new_card.set_card(id)
	$cards.transform.origin.x = -(current_x_offset-x_step)/3.5
