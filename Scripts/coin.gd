extends Area2D

@onready var sprite = $AnimatedSprite2D
@onready var pickup_sound = $PickupSound

func _ready():
	sprite.play("idle")

func _on_body_entered(body):
	if body.name == "Player" :
		collect()

func collect():
	$CollisionShape2D.disabled = true
	pickup_sound.play()
	sprite.play("collect")
	await sprite.animation_finished
	queue_free()
