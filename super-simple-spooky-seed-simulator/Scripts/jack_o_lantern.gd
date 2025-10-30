extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
var hits_taken := 0
var target # Vector2 or null
var SPEED := 100
var SIGHT_RADIUS := 500

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area == Global.playerDamageZone:
		hits_taken += 1
		if hits_taken == 1:
			anim.play("after_1_hit")
		if hits_taken == 2:
			anim.play("after_2_hits")
		if hits_taken == 3:
			GameManager.update_num_killed()
			queue_free()
			
func _ready() -> void:
	target = find_nearest_plant()

func _physics_process(_delta: float) -> void:
	if target != null:
		var direction = global_position.angle_to_point(target)
		velocity = Vector2(SPEED, 0.0).rotated(direction)
		
	move_and_slide()
	
func find_nearest_plant():
	var plants = get_tree().get_nodes_in_group("Plants")
	var closest_distance := SIGHT_RADIUS
	var closest_plant: CornPlant
	var distance
	for plant:CornPlant in plants:
		distance = global_position.distance_to(plant.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_plant = plant
	if closest_plant == null:
		return null
	return closest_plant.global_position
