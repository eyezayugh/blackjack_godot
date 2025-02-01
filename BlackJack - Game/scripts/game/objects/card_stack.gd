extends Node3D

var card_scene = preload("res://Scene/game/objects/card.tscn")

var current_x_offset = 0.0
var x_step = 2.7

var amount_of_cards = 0.0

var value = 0
var ace_value = 0
var has_ace_value = false

var dealer_card_shown = false

@export var is_dealer = true

func add_card(id):
	var new_card = card_scene.instantiate()

	new_card.transform.origin.x = current_x_offset
	
	if is_dealer && amount_of_cards == 0:
		new_card.rotation.z = deg_to_rad(180)
	
	current_x_offset += x_step

	$cards.add_child(new_card)

	new_card.set_card(id)
	$cards.transform.origin.x = -(current_x_offset-x_step)/2
	
	amount_of_cards += 1

	calculate_value();
	
func show_dealer_cards():
	if is_dealer:
		$cards.get_child(0).rotation.z = 0
		dealer_card_shown = true

func calculate_value():
	var total_value = 0;
	for card in $cards.get_children():
		var card_value = card.id
		while card_value > 13:
			card_value -= 13
		
		if card_value >= 10:
			total_value += 10
		else:
			total_value += card_value+1
			
		if card_value == 0:
			has_ace_value = true
		
	if ace_value && total_value+10 > 21:
		has_ace_value = false
		
	value = total_value
	ace_value = total_value + 10
			
	if !has_ace_value:
		print(total_value)
	else:		
		print(str(total_value) + "/" + str(ace_value + 10))
