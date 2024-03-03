class_name Paddle
extends CharacterBody2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D

var direction = Vector2.ZERO

@export var speed = 750
	 
func _ready():
	velocity = Vector2.ZERO
	
func _physics_process(delta):
	move_and_collide(velocity * delta)
	
func _input(event):
	if( Input.is_action_pressed("left")):
		velocity = Vector2.LEFT * speed
	elif( Input.is_action_pressed("right")):
		velocity = Vector2.RIGHT * speed
	else:
		velocity = Vector2.ZERO

# The size of the psddle is the size of the collision rectangle
func get_size() -> Vector2 :
	return collision_shape_2d.shape.get_rect().size
	
# The width of the psddle is the width of the collision rectangle
func get_width():
	return collision_shape_2d.shape.get_rect().size.x
