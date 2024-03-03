class_name Main
extends Node2D

@onready var ball = $Ball


# Called when the node enters the scene tree for the first time.
func _ready():
	ball.start_moving()
	

func _on_brick_spawner_wall_destroyed():
	ball.stop_moving()
