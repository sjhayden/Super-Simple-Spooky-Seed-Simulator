extends CharacterBody2D

const SPEED = 200.0
var last_direction = Vector2(0, 1)  # Downwards
var is_attacking = false

@export var plant_manager: PlantManager # Dependency injection yay
@onready var anim = $AnimatedSprite2D
@onready var damage_zone = $DamageZone

func _ready():
	# Connect the signal for when the attack animation finishes
	anim.animation_finished.connect(_on_animated_sprite_2d_animation_finished)

func _physics_process(_delta: float) -> void:
	Global.playerDamageZone = damage_zone
	
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if is_attacking:
		velocity = Vector2.ZERO
	else:
		last_direction = direction
		velocity = direction * SPEED
	
	move_and_slide()
	
	# Get the visible rectangle of the viewport
	var viewport_rect = get_viewport().get_visible_rect()

	# Define boundaries for player movement
	var min_x = viewport_rect.position.x
	var max_x = viewport_rect.end.x
	var min_y = viewport_rect.position.y
	var max_y = viewport_rect.end.y

	# Clamp the player's position to stay within the viewport
	global_position.x = clamp(global_position.x, min_x, max_x)
	global_position.y = clamp(global_position.y, min_y + 95, max_y)
	
	update_animations()
	
	if Input.is_action_just_pressed("attack") and not is_attacking:
		perform_attack()
		
	if Input.is_action_just_pressed("plant_harvest") and not is_attacking:
		plant_manager.plant_or_harvest(global_position)


func update_animations():
	if not is_attacking:
		anim.play("default")


func perform_attack():
	is_attacking = true
#	var animation_name = ""
	
	var damage_zone_collision = damage_zone.get_node("Hitbox")
	var wait_time = 0.2
	damage_zone_collision.disabled = false
	await get_tree().create_timer(wait_time).timeout
	damage_zone_collision.disabled = true
	
	anim.play("attack_down")
	is_attacking = false
	update_animations()
	
	return
	
	# Determine animation and hitbox offset based on the primary direction
#	if abs(last_direction.x) > abs(last_direction.y):
#		if last_direction.x > 0: # Right
#			attack_pivot.position = Vector2(20, 0)
#			animation_name = "attack_right"
#		else: # Left
#			attack_pivot.position = Vector2(-20, 0)
#			animation_name = "attack_left"
#	else:
#		if last_direction.y > 0: # Down
#			attack_pivot.position = Vector2(0, 20)
#			animation_name = "attack_down"
#		else: # Up
#			attack_pivot.position = Vector2(0, -20)
#			animation_name = "attack_up"
#
#	anim.play(animation_name)
	

func _on_animated_sprite_2d_animation_finished():
	# Check if the finished animation was an attack
	if anim.animation.begins_with("attack"):
		is_attacking = false
		update_animations()
		
