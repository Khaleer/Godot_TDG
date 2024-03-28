extends Node2D

@export var health = 100
@export var speed_bonus = 1
@export var hunger = 100
@export var thirst = 100

func	multiplic():
	var new_stat = hunger + thirst
	print(str(new_stat))
