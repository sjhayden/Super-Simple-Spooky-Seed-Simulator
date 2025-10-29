extends Node2D

var enemy_scene = preload("res://Scenes/jack_o_lantern.tscn")
@onready var spawning_timer = $SpawningTimer


func _on_spawning_timer_timeout() -> void:
	spawn_enemy()


func _on_first_enemy_timer_timeout() -> void:
	spawn_enemy() # TODO: make special first enemy
	spawning_timer.start()
	

func spawn_enemy() -> void:
	print("spawn")
	# Create a new instance of the enemy scene.
	var enemy = enemy_scene.instantiate()

	# Choose a random location on Path2D.
	var spawn_location = $SpawningPath/SpawnLocation
	spawn_location.progress_ratio = randf()

	# Set the enemy's position to the random location.
	enemy.position = spawn_location.position

	# Set the enemy's direction perpendicularish to the path direction.
	# necessary if enemies will walk on their own?
	var direction = spawn_location.rotation + PI / 2 + randf_range(-PI / 4, PI / 4)
	enemy.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(150.0, 0.0)
	enemy.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(enemy)
