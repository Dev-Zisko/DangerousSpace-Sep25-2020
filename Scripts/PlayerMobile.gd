extends KinematicBody2D

var Bullet = preload("res://Scenes/Asteroid.tscn")

var limit
var speed = 200
signal dead

onready var joystick = get_parent().get_node("Joystick/TouchButton")

func _ready():
	hide()
	limit = get_viewport_rect().size

func start_game(pos):
	position = pos
	show()
	$TimerAsteroid.start()

func _process(delta):
	move_and_slide(joystick.get_value() * 200)
	get_animation(joystick.get_value().x, joystick.get_value().y)
	if(get_slide_count() > 0):
		var collision = get_slide_collision(get_slide_count()-1).collider
		if(collision.is_in_group("Asteroid")):
			emit_signal("dead")
			hide()

#+ - Derecha Arriba
#- - Izquierda Arriba
#- + Izquierda abajo
#+ +  Derecha Abajo


func get_animation(x, y):
	if x == 0 && y == 0:
		$AnimSprite.play()
		$AnimSprite.animation = "idle"
	else:
		# Animación arriba
		if (x >= -0.05 || x <= 0.05) && y <= -0.95:
			$AnimSprite.play()
			$AnimSprite.rotation_degrees = 0
			$AnimSprite.animation = "run"
		# Animación abajo
		elif (x >= -0.05 || x <= 0.05) && y >= 0.95:
			$AnimSprite.play()
			$AnimSprite.rotation_degrees = 180
			$AnimSprite.animation = "run"
		# Animación derecha
		elif (y >= -0.05 || y <= 0.05) && x >= 0.95:
			$AnimSprite.play()
			$AnimSprite.rotation_degrees = 90
			$AnimSprite.animation = "run"
		# Animación izquierda
		elif (y >= -0.05 || y <= 0.05) && x <= -0.95:
			$AnimSprite.play()
			$AnimSprite.rotation_degrees = 270
			$AnimSprite.animation = "run"
		# Animación arriba a la derecha
		elif  x > 0 && y < 0:
			$AnimSprite.play()
			$AnimSprite.rotation_degrees = 45
			$AnimSprite.animation = "run"
		# Animación arriba a la izquierda
		elif x < 0 && y < 0:
			$AnimSprite.play()
			$AnimSprite.rotation_degrees = 315
			$AnimSprite.animation = "run"
		# Animación abajo a la izquierda
		elif x < 0 && y > 0:
			$AnimSprite.play()
			$AnimSprite.rotation_degrees = 225
			$AnimSprite.animation = "run"
		# Animación abajo a la derecha
		elif x > 0 && y > 0:
			$AnimSprite.play()
			$AnimSprite.rotation_degrees = 145
			$AnimSprite.animation = "run"


func _on_Timer_timeout():
	# "Muzzle" is a Position2D placed at the barrel of the gun.
	$TimerAsteroid.wait_time += 5
	var b = Bullet.instance()
	b.start($Muzzle.global_position, rotation, speed)
	get_parent().add_child(b)
	if(speed <= 900):
		speed += 10
