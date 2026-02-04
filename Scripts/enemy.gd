extends CharacterBody2D

@export var speed := 50
var direction := -1

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var die_sound: AudioStreamPlayer2D = $DieSound

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_wall() or (is_on_floor() and not ray_cast_2d.is_colliding()):
		direction *= -1

	if direction == 1:
		animated_sprite_2d.flip_h = false
		ray_cast_2d.position.x = 12
	elif direction == -1:
		animated_sprite_2d.flip_h = true
		ray_cast_2d.position.x = -12
	
	velocity.x = speed * direction
	move_and_slide()

func _on_killzone_body_entered(body):
	if body.name == "Player" or body.is_in_group("Player"):
		die_sound.play()
		if body.has_method("die"):
			body.die()
