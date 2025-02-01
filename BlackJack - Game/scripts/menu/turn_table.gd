extends Node3D

@export var turn_speed = 4;
func _process(delta):
	rotation.y += deg_to_rad(turn_speed)*delta


func _ready():
	$card.set_card(0)
	$card2.set_card(25)
