extends CharacterBody2D

const SPEED = 200.0
var last_direction = Vector2(0, 1)  # Downwards
var is_attacking = false

@onready var anim = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var attack_pivot = $AttackPivot
@onready var hitbox_collision = $AttackPivot/SwordHit/HitBox

func _ready():
	# Connect the signal for when the attack animation finishes
	anim.animation_finished.connect(_on_animated_sprite_2d_animation_finished)

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if is_attacking:
		velocity = Vector2.ZERO
	else:
		last_direction = direction
		velocity = direction * SPEED
	
	move_and_slide()
	update_animations()
	
	if Input.is_action_just_pressed("attack") and not is_attacking:
		perform_attack()


func update_animations():
	if not is_attacking:
		anim.play("default")


func perform_attack():
	is_attacking = true
	var animation_name = ""
	
	# Determine animation and hitbox offset based on the primary direction
	if abs(last_direction.x) > abs(last_direction.y):
		if last_direction.x > 0: # Right
			attack_pivot.position = Vector2(20, 0)
			animation_name = "attack_right"
		else: # Left
			attack_pivot.position = Vector2(-20, 0)
			animation_name = "attack_left"
	else:
		if last_direction.y > 0: # Down
			attack_pivot.position = Vector2(0, 20)
			animation_name = "attack_down"
		else: # Up
			attack_pivot.position = Vector2(0, -20)
			animation_name = "attack_up"
	
	anim.play(animation_name)
	

func _on_animated_sprite_2d_animation_finished():
	# Check if the finished animation was an attack
	if anim.animation.begins_with("attack"):
		is_attacking = false
		update_animations()
		
