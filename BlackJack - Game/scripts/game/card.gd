extends Node3D

var card_textures = [ 
"res://BlackJack - Assests/textures/cards/card_clubs_02.png", "res://BlackJack - Assests/textures/cards/card_clubs_03.png", "res://BlackJack - Assests/textures/cards/card_clubs_04.png", "res://BlackJack - Assests/textures/cards/card_clubs_05.png", "res://BlackJack - Assests/textures/cards/card_clubs_06.png", "res://BlackJack - Assests/textures/cards/card_clubs_07.png", "res://BlackJack - Assests/textures/cards/card_clubs_08.png", "res://BlackJack - Assests/textures/cards/card_clubs_09.png", "res://BlackJack - Assests/textures/cards/card_clubs_10.png", "res://BlackJack - Assests/textures/cards/card_clubs_A.png", "res://BlackJack - Assests/textures/cards/card_clubs_J.png", "res://BlackJack - Assests/textures/cards/card_clubs_K.png", "res://BlackJack - Assests/textures/cards/card_clubs_Q.png", "res://BlackJack - Assests/textures/cards/card_diamonds_02.png", "res://BlackJack - Assests/textures/cards/card_diamonds_03.png", 
"res://BlackJack - Assests/textures/cards/card_diamonds_04.png", "res://BlackJack - Assests/textures/cards/card_diamonds_05.png", "res://BlackJack - Assests/textures/cards/card_diamonds_06.png", "res://BlackJack - Assests/textures/cards/card_diamonds_07.png", "res://BlackJack - Assests/textures/cards/card_diamonds_08.png", "res://BlackJack - Assests/textures/cards/card_diamonds_09.png", "res://BlackJack - Assests/textures/cards/card_diamonds_10.png", "res://BlackJack - Assests/textures/cards/card_diamonds_A.png", "res://BlackJack - Assests/textures/cards/card_diamonds_J.png", "res://BlackJack - Assests/textures/cards/card_diamonds_K.png", "res://BlackJack - Assests/textures/cards/card_diamonds_Q.png", "res://BlackJack - Assests/textures/cards/card_hearts_02.png", "res://BlackJack - Assests/textures/cards/card_hearts_03.png", "res://BlackJack - Assests/textures/cards/card_hearts_04.png", "res://BlackJack - Assests/textures/cards/card_hearts_05.png", 
"res://BlackJack - Assests/textures/cards/card_hearts_06.png", "res://BlackJack - Assests/textures/cards/card_hearts_07.png", "res://BlackJack - Assests/textures/cards/card_hearts_08.png", "res://BlackJack - Assests/textures/cards/card_hearts_09.png", "res://BlackJack - Assests/textures/cards/card_hearts_10.png", "res://BlackJack - Assests/textures/cards/card_hearts_A.png", "res://BlackJack - Assests/textures/cards/card_hearts_J.png", "res://BlackJack - Assests/textures/cards/card_hearts_K.png", "res://BlackJack - Assests/textures/cards/card_hearts_Q.png", "res://BlackJack - Assests/textures/cards/card_joker_black.png", "res://BlackJack - Assests/textures/cards/card_joker_red.png", "res://BlackJack - Assests/textures/cards/card_spades_02.png", "res://BlackJack - Assests/textures/cards/card_spades_03.png", "res://BlackJack - Assests/textures/cards/card_spades_04.png", "res://BlackJack - Assests/textures/cards/card_spades_05.png", "res://BlackJack - Assests/textures/cards/card_spades_06.png", 
"res://BlackJack - Assests/textures/cards/card_spades_07.png", "res://BlackJack - Assests/textures/cards/card_spades_08.png", "res://BlackJack - Assests/textures/cards/card_spades_09.png", "res://BlackJack - Assests/textures/cards/card_spades_10.png", "res://BlackJack - Assests/textures/cards/card_spades_A.png", "res://BlackJack - Assests/textures/cards/card_spades_J.png", "res://BlackJack - Assests/textures/cards/card_spades_K.png", "res://BlackJack - Assests/textures/cards/card_spades_Q.png"
]

@onready var front = $front

func set_card(id):
	
	var image = load(card_textures[id]);
	var material_one = front.mesh.get_material();
	var new_material = material_one.duplicate();
	new_material.albedo_texture = image
	front.mesh.set_material(new_material)
	
func _ready():
	set_card(randi_range(0,card_textures.size()-1))

#DEBUG
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		set_card(randi_range(0, card_textures.size()-1))
