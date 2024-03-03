class_name Brick
extends RigidBody2D

signal brick_destroyed

@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D

var health = 1

# Brick will change colour depending on it's health level (0-5)
var textures : Array[Texture2D] = [
	preload("res://assets/bricks/blue_64x32.png"),
	preload("res://assets/bricks/blue_green_64x32.png"),
	preload("res://assets/bricks/green_64x32.png"),
	preload("res://assets/bricks/magenta_64x32.png"),
	preload("res://assets/bricks/red_64x32.png"),
	preload("res://assets/bricks/grey_64x32.png")
]	

# The size of the brick is the size of the collision rectangle
func get_size() -> Vector2 :
	return collision_shape_2d.shape.get_rect().size
	
# The width of the brick is the width of the collision rectangle
func get_width():
	return collision_shape_2d.shape.get_rect().size.x

# Set health (1-6)
func set_health( value : int) :
	health = clamp(value, 1, 6) - 1
	sprite_2d.texture = textures[health]

# Decrement the health of the brick. If it reaches 0, erase the brick and
# stop registering collisions
func decrease_health() :
	if( health > 0 ) :
		health -= 1
		sprite_2d.texture = textures[health]
	else :
		collision_shape_2d.disabled = true
		fade_out()

# Fade the brick out over 1/2 a second then call destroyed() when complete
func fade_out() :
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate", Color.TRANSPARENT, 0.5)
	tween.tween_callback(destroyed)

# Delete the brick object and tell any listeners it's gone.	
func destroyed() :
	queue_free()
	brick_destroyed.emit()	
