extends Node3D

@onready var game_state_label = $Camera3D/game_ui/game_state_label
@onready var bet_label = $Camera3D/game_ui/bet_label

@onready var game_options = $Camera3D/game_ui/game_options
@onready var chip_options = $Camera3D/game_ui/chip_options

@onready var player_card_stack = $player_card_stack
@onready var dealer_card_stack = $dealer_card_stack

@onready var chips = $chips


var state = 0
# 0 : taking bets
# 1 : dealing cards
# 2 : user action
# 3 : dealer taking card
# 4 : pay out

var current_bet = 0;

var dealing_counter = 0
var dealing_timer = 0.0;
var dealing_timer_max = 0.1;

func _ready():
	change_state(0)
	
func change_state(new_state):
	state = new_state
	if state == 0:
		game_state_label.text = "Place your bets"
		chip_options.show()
		game_options.hide()
	if state == 1:
		game_state_label.text = "dealing cards..."
		chip_options.hide()
		game_options.hide()
	if state == 2:
		game_state_label.text = "players turn"
		chip_options.hide()
		game_options.show()
	if state == 3:
		game_state_label.text = "dealers turn"
		chip_options.hide()
		game_options.hide()
	if state == 4:
		var outcome = calculate_winner()
		if outcome == 0:
			game_state_label.text = "player wins"
		if outcome == 1:
			game_state_label.text = "dealer wins"
		if outcome == 2:
			game_state_label.text = "draw"
		chip_options.hide()
		game_options.hide()

func _process(delta):
	if state == 1:
		dealing_timer += delta
		if dealing_timer > dealing_timer_max:
			if dealing_counter == 0:
				player_card_stack.add_card(randi_range(0,51))
			if dealing_counter == 1:
				dealer_card_stack.add_card(randi_range(0,51))
			if dealing_counter == 2:
				player_card_stack.add_card(randi_range(0,51))
			if dealing_counter == 3:
				dealer_card_stack.add_card(randi_range(0,51))
			if dealing_counter == 4:
				change_state(2)
			dealing_counter += 1
			dealing_timer = 0
	if state == 3:
		dealing_timer += delta;
		if dealing_timer > dealing_timer_max:
			if !dealer_card_stack.dealer_card_shown:
				dealer_card_stack.show_dealer_cards()
			else:
				if dealer_card_stack.value < 17:
					dealer_card_stack.add_card(randi_range(0,51))
				else:
					change_state(4)
			dealing_timer = 0
			
func calculate_winner():
	var player_bust = false
	var dealer_bust = false
	
	var true_player_value = 0
	var true_dealer_value = 0
	
	if player_card_stack.value > 21:
		player_bust = true
	if dealer_card_stack.value > 21:
		dealer_bust = true
		
	if dealer_bust && !player_bust:
		return 0
	
	if player_bust && !dealer_bust:
		return 1
	
	if player_bust && dealer_bust:
		return 2
	
	true_player_value = player_card_stack.value
		
	if player_card_stack.has_ace_value:
		if player_card_stack.ace_value <= 21:
			true_player_value = player_card_stack.ace_value
	
	true_dealer_value = dealer_card_stack.value
	
	if dealer_card_stack.has_ace_value:
		if dealer_card_stack.ace_value <=21:
			true_player_value = dealer_card_stack.ace_value
			
	if true_player_value > true_dealer_value:
		return 0
		
	if true_player_value < true_dealer_value:
		return 1
	
	if true_dealer_value == true_player_value:
		return 2

func _on_done_button_pressed():
	if state == 0 && current_bet > 0:
		change_state(1)


func _on_chip_button_pressed(chip_id):
	if state == 0:
		chips.add_chip(chip_id)
		current_bet = chips.stack_value
		bet_label.text = "bet : " + str(current_bet)


func _on_hit_button_pressed():
	player_card_stack.add_card(randi_range(0,51))


func _on_stand_button_pressed():
	change_state(3)


func _on_new_game_button_pressed():
	pass # Replace with function body.
