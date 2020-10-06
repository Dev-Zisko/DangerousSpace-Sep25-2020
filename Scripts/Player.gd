extends KinematicBody2D

var Bullet = preload("res://Scenes/Asteroid.tscn")
export (int) var speed = 200
export (float) var rotation_speed = 1.5

var velocity = Vector2()
var rotation_dir = 0
var limit

func _ready():
	limit = get_viewport_rect().size

func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
	position += velocity * delta
	position.x = clamp(position.x, 0, limit.x)
	position.y = clamp(position.y, 0, limit.y)

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed('move_right'):
		rotation_dir += 2
	if Input.is_action_pressed('move_left'):
		rotation_dir -= 2
	if Input.is_action_pressed('move_down'):
		velocity = Vector2(0, speed).rotated(rotation)
	if Input.is_action_pressed('move_up'):
		velocity = Vector2(0, -speed).rotated(rotation)
	get_animation(rotation_dir, velocity.y)

func get_animation(x, y):
	if x == 0 && y == 0:
		$AnimSprite.play()
		$AnimSprite.animation = "idle"
	else:
		$AnimSprite.play()
		$AnimSprite.animation = "run"

func _on_Timer_timeout():
	# "Muzzle" is a Position2D placed at the barrel of the gun.
	$TimerAsteroid.wait_time += 1
	var b = Bullet.instance()
	b.start($Muzzle.global_position, rotation)
	get_parent().add_child(b)
