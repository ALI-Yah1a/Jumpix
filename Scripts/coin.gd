extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var pickup_sound = $PickupSound

func _ready():
	animated_sprite_2d.play("idle")

func _on_body_entered(body):
	
	if body.name == "Player" :
		score.add_point()
		collect()
		
		
func collect():
	$CollisionShape2D.disabled = true
	pickup_sound.play()
	animated_sprite_2d.play("collected")
	await animated_sprite_2d.animation_finished
	queue_free()
	
