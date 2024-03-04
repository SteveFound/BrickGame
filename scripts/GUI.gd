extends Node2D

@onready var score_label = $CanvasLayer/PanelContainer2/MarginContainer/GridContainer/score_label
@onready var lives_label = $CanvasLayer/PanelContainer2/MarginContainer/GridContainer/lives_label

@export var score = 0
@export var lives = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_score():
	var formatted_score = "%07d" % [score]
	score_label.text = formatted_score
	
func _on_brick_spawner_hit_points(points):
	score = score + points
	show_score()
 
