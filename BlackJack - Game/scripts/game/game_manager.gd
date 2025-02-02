extends Node3D

@onready var game_state_label = $Camera3D/game_ui/game_state_label
@onready var bet_label = $Camera3D/game_ui/bet_label

@onready var game_options = $Camera3D/game_ui/game_options
@onready var chip_options = $Camera3D/game_ui/chip_options
@onready var new_game_button = $Camera3D/game_ui/new_game_button

@onready var player_card_stack = $player_card_stack
@onready var dealer_card_stack = $dealer_card_stack

@onready var chips = $chips

@onready var audio_source = $audio_source

var sounds = []

var card_sound = preload("res://assets/Audio/card-place-1.ogg")
var chip_sound = preload("res://assets/Audio/chip-lay-1.ogg")

var state = 0
# 0 : taking bets
# 1 : dealing cards
# 2 : user action
# 3 : dealer taking card
# 4 : pay out

var current_bet = 0;

var dealing_counter = 0
var dealing_timer = 0.0;
var dealing_timer_max = 0.3;

func _ready():
	change_state(0)
	sounds = [card_sound, chip_sound]
	
func change_state(new_state):
	state = new_state
	if state == 0:
		player_card_stack.reset()
		dealer_card_stack.reset()
		chips.reset()
		game_state_label.modulate = Color.WHITE
		game_state_label.text = "Place your bets"
		chip_options.show()
		game_options.hide()
		new_game_button.hide()
	if state == 1:
		game_state_label.text = "dealing cards..."
		chip_options.hide()
		game_options.hide()
		new_game_button.hide()
	if state == 2:
		game_state_label.text = "players turn"
		chip_options.hide()
		game_options.show()
		new_game_button.hide()
	if state == 3:
		game_state_label.text = "dealers turn"
		chip_options.hide()
		game_options.hide()
		new_game_button.hide()
	if state == 4:
		var outcome = calculate_winner()
		if outcome == 0:
			game_state_label.text = "player wins"
			game_state_label.modulate = Color.FOREST_GREEN
		if outcome == 1:
			game_state_label.text = "dealer wins"
			game_state_label.modulate = Color.RED
		if outcome == 2:
			game_state_label.text = "draw"
			game_state_label.modulate = Color.BLUE
		chip_options.hide()
		game_options.hide()
		new_game_button.show()

func _process(delta):
	if state == 1:
		dealing_timer += delta
		if dealing_timer > dealing_timer_max:
			if dealing_counter == 0:
				player_card_stack.add_card(randi_range(0,51))
				play_sound(0)
			if dealing_counter == 1:
				dealer_card_stack.add_card(randi_range(0,51))
				play_sound(0)
			if dealing_counter == 2:
				player_card_stack.add_card(randi_range(0,51))
				play_sound(0)
			if dealing_counter == 3:
				dealer_card_stack.add_card(randi_range(0,51))
				play_sound(0)
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
					play_sound(0)
				else:
					change_state(4)
			dealing_timer = 0
			dealing_counter = 0
			
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
		print("dealer bust player did not")
		print("player value : " + str(player_card_stack.value))
		print("dealer value : " + str(dealer_card_stack.value))
		return 0
	
	if player_bust && !dealer_bust:
		print("player bust dealer did not")
		print("player value : " + str(player_card_stack.value))
		print("dealer value : " + str(dealer_card_stack.value))
		return 1
	
	if player_bust && dealer_bust:
		print("both bust")
		print("player value : " + str(player_card_stack.value))
		print("dealer value : " + str(dealer_card_stack.value))
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
		
func play_sound(id):
	audio_source.stream = sounds[id]
	audio_source.play()

func _on_done_button_pressed():
	if state == 0 && current_bet > 0:
		change_state(1)


func _on_chip_button_pressed(chip_id):
	if state == 0:
		chips.add_chip(chip_id)
		current_bet = chips.stack_value
		bet_label.text = "BET : $" + str(current_bet)
		play_sound(1)


func _on_hit_button_pressed():
	player_card_stack.add_card(randi_range(0,51))
	play_sound(0)


func _on_stand_button_pressed():
	change_state(3)


func _on_new_game_button_pressed():
	if state == 4:
		current_bet = 0
		bet_label.text = "BET : "
		change_state(0)
