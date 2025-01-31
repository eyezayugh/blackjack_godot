extends Node3D

@onready var white_chip = preload("res://assets/Models/chips_fixed/blue.tscn")#1
@onready var red_chip = preload("res://assets/Models/chips_fixed/red.tscn") #5
@onready var green_chip = preload("res://assets/Models/chips_fixed/green.tscn") #25
@onready var black_chip = preload("res://assets/Models/chips_fixed/black_white.tscn") #100
@onready var blue_chip = preload("res://assets/Models/chips_fixed/white_blue.tscn") #500

@onready var chip_models = [
	white_chip,
	red_chip,
	green_chip,
	black_chip,
	blue_chip
]

var values = [1,5,25,100,500]

var current_y_offset = 0.1;
var offset_step = 0.2;
var stack_value = 0

#DEBUG
func _input(event):
	if event.is_action_pressed("ui_accept"):
		add_chip(randi_range(0,4))

func add_chip(id):
	stack_value += values[id]
	var chip = chip_models[id].instantiate();
	chip.transform.origin.y = current_y_offset
	current_y_offset += offset_step
	add_child(chip)


