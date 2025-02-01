extends Node3D

var card_textures = [
	"res://assets/textures/cards/card_clubs_A.png", "res://assets/textures/cards/card_clubs_02.png", "res://assets/textures/cards/card_clubs_03.png", "res://assets/textures/cards/card_clubs_04.png", "res://assets/textures/cards/card_clubs_05.png", "res://assets/textures/cards/card_clubs_06.png", "res://assets/textures/cards/card_clubs_07.png", "res://assets/textures/cards/card_clubs_08.png", "res://assets/textures/cards/card_clubs_09.png", "res://assets/textures/cards/card_clubs_10.png", "res://assets/textures/cards/card_clubs_J.png", "res://assets/textures/cards/card_clubs_K.png", "res://assets/textures/cards/card_clubs_Q.png",
	"res://assets/textures/cards/card_diamonds_A.png", "res://assets/textures/cards/card_diamonds_02.png", "res://assets/textures/cards/card_diamonds_03.png", "res://assets/textures/cards/card_diamonds_04.png", "res://assets/textures/cards/card_diamonds_05.png", "res://assets/textures/cards/card_diamonds_06.png", "res://assets/textures/cards/card_diamonds_07.png", "res://assets/textures/cards/card_diamonds_08.png", "res://assets/textures/cards/card_diamonds_09.png", "res://assets/textures/cards/card_diamonds_10.png", "res://assets/textures/cards/card_diamonds_J.png", "res://assets/textures/cards/card_diamonds_K.png", "res://assets/textures/cards/card_diamonds_Q.png",
	"res://assets/textures/cards/card_hearts_A.png", "res://assets/textures/cards/card_hearts_02.png", "res://assets/textures/cards/card_hearts_03.png", "res://assets/textures/cards/card_hearts_04.png", "res://assets/textures/cards/card_hearts_05.png", "res://assets/textures/cards/card_hearts_06.png", "res://assets/textures/cards/card_hearts_07.png", "res://assets/textures/cards/card_hearts_08.png", "res://assets/textures/cards/card_hearts_09.png", "res://assets/textures/cards/card_hearts_10.png", "res://assets/textures/cards/card_hearts_J.png", "res://assets/textures/cards/card_hearts_K.png", "res://assets/textures/cards/card_hearts_Q.png",
	"res://assets/textures/cards/card_spades_A.png", "res://assets/textures/cards/card_spades_02.png", "res://assets/textures/cards/card_spades_03.png", "res://assets/textures/cards/card_spades_04.png", "res://assets/textures/cards/card_spades_05.png", "res://assets/textures/cards/card_spades_06.png", "res://assets/textures/cards/card_spades_07.png", "res://assets/textures/cards/card_spades_08.png", "res://assets/textures/cards/card_spades_09.png", "res://assets/textures/cards/card_spades_10.png", "res://assets/textures/cards/card_spades_J.png", "res://assets/textures/cards/card_spades_K.png", "res://assets/textures/cards/card_spades_Q.png"
]

var id = 0

@onready var front = $front

func set_card(new_id):
	id = new_id
	var image = load(card_textures[new_id])
	var material_one = front.mesh.get_material()
	var new_material = material_one.duplicate()
	new_material.albedo_texture = image
	front.mesh.set_material(new_material)
