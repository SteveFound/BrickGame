class_name BrickSpawner
extends Node

# Number of rows and columns
const COLUMNS = 10
const ROWS = 3
# Pixel size of each brick
const BRICK_WIDTH = 64
const BRICK_HEIGHT = 32

signal wall_destroyed

# How big the gap between each brick should be
@export var margin: Vector2 = Vector2(8,8)
# The Brick class
@export var brick_scene: PackedScene
# A marker to where the wall should be drawn (top centre)
@export var spawn_point: Marker2D

var brick_count: int

func _ready():
	spawn()

func spawn() :
	# Calculate the width of a row in pixels
	var row_width = (BRICK_WIDTH * COLUMNS) +(margin.x * (COLUMNS - 1))
	# The first brick is drawn at the marker point - half the width
	var spawn_x = spawn_point.position.x - (row_width + BRICK_WIDTH + margin.x) / 2
	var spawn_y = spawn_point.position.y

	var y = spawn_y
	for row in ROWS:
		var x = spawn_x
		for col in COLUMNS:
			# Create a new brick and added as a child of the current scene
			var brick = brick_scene.instantiate() as Brick
			add_child(brick)
			brick.set_health(6)
			brick.set_position(Vector2(x,y))
			brick.brick_destroyed.connect( on_brick_destroyed)
			x += BRICK_WIDTH + margin.x
		y += BRICK_HEIGHT + margin.y
	brick_count = ROWS * COLUMNS
			
func on_brick_destroyed() :
	brick_count -= 1
	if( brick_count == 0):
		wall_destroyed.emit()
