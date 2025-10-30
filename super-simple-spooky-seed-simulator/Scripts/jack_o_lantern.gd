extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var hesitation = $HesitationTimer
@onready var bite_timer = $BiteTimer
var hits_taken := 0
var target # Vector2 or null
var SPEED := 100
var SIGHT_RADIUS := 1000
var BITE_RANGE := 20
var eaten_plants_locations = {} # keeps track of plants this jack has already found dead so they don't just stay their eating a dead plant

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
	target = find_nearest_plant_position()

func _physics_process(_delta: float) -> void:
	if target == null:
		velocity = Vector2(0, 0)
	elif global_position.distance_to(target) <= BITE_RANGE:
		try_to_bite()
	else:
		var direction = global_position.angle_to_point(target)
		velocity = Vector2(SPEED, 0.0).rotated(direction)
		
	move_and_slide()
	
func find_nearest_plant():
	var plants = get_tree().get_nodes_in_group("Plants")
	var closest_distance := SIGHT_RADIUS
	var closest_plant: CornPlant
	var distance
	for plant:CornPlant in plants:
		if plant.global_position in eaten_plants_locations: continue
		distance = global_position.distance_to(plant.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_plant = plant
	return closest_plant
	
func find_nearest_plant_position():
	var plant = find_nearest_plant()
	if plant == null:
		return null
	return plant.global_position
	
func find_plant_in_range():
	var plants = get_tree().get_nodes_in_group("Plants")
	for plant:CornPlant in plants:
		if global_position.distance_to(plant.global_position) <= BITE_RANGE:
			return plant
	return null


func _on_recalibration_timer_timeout() -> void:
	recalibrate()
	
func recalibrate() -> void:
	var new_target = find_nearest_plant_position()
	if new_target == target: return
	target = null
	hesitation.start()
	await hesitation.timeout
	target = new_target
	
func try_to_bite():
	target = null
	bite_timer.start()
	while true:
		await bite_timer.timeout
		var plant: CornPlant = find_plant_in_range()
		if plant == null:
			bite_timer.stop()
			recalibrate()
			return
		if plant.num_corns <= 0:
			eaten_plants_locations[plant.global_position] = true
			bite_timer.stop()
			recalibrate()
			return
		plant.bite()
	
	
