class_name Ball
extends CharacterBody2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D

const MAX_SPEED = 400
@export var speed = 150
@export var speed_factor = 1.05

signal brick_hit

var start_position: Vector2
var last_collider_id

func _ready():
	start_position = position

func _physics_process(delta):
	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	if( !collision ):
		return
	var layer = collision.get_collider().collision_layer
	if(layer & 2):		# Bat
		paddle_collision(collision)
	if(layer & 8):		# Brick
		brick_collision(collision)
	if((layer & 10) == 0):	# Neither Bat or Brick 
		bounce_off(collision)
	
func start_moving():
	position = start_position
	randomize()
	velocity = Vector2(randf_range(0.1, 1.0), randf_range(-0.1, -1)).normalized() * speed
	
func stop_moving():
	queue_free()

# The size of the brick is the size of the collision rectangle
func get_size() -> Vector2 :
	return collision_shape_2d.shape.get_rect().size
	
# The width of the brick is the width of the collision rectangle
func get_width():
	return collision_shape_2d.shape.get_rect().size.x

func bounce_off(collision: KinematicCollision2D):
	velocity = velocity.bounce(collision.get_normal())
	
func speed_up():
	speed = clamp(speed * speed_factor, 0, MAX_SPEED)
		
func paddle_collision(collision: KinematicCollision2D):
	var paddle = collision.get_collider() as Paddle
	
	# Get hit position relative to paddle centre
	var hit_coord = paddle.collision_shape_2d.to_local(collision.get_position())
	# Add half the paddle width to get the X coordinate in the range 0 - width
	# Then divide by the width to make it a percentage (0-1)
	var paddle_width = paddle.get_width()
	var hit_percant = clamp((hit_coord.x + (paddle_width/2)) / paddle_width, 0, 1)
	var bounce_angle = lerp(220, 330, hit_percant)
	velocity = Vector2.from_angle(deg_to_rad(bounce_angle)).normalized() * speed
#	bounce_off(collision)
	
func brick_collision(collision: KinematicCollision2D):
	var brick = collision.get_collider() as Brick
	brick.decrease_health()
	bounce_off(collision)
