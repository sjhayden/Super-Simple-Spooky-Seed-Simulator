extends Node2D

var enemy_scene = preload("res://Scenes/jack_o_lantern.tscn")
@onready var spawning_timer = $SpawningTimer


func _on_spawning_timer_timeout() -> void:
	spawn_enemy()


func _on_first_enemy_timer_timeout() -> void:
	spawn_enemy() # TODO: make special first enemy
	spawning_timer.start()
	

func spawn_enemy() -> void:
	# Create a new instance of the enemy scene.
	var enemy:CharacterBody2D = enemy_scene.instantiate()

	# Choose a random location on Path2D.
	var spawn_location = $SpawningPath/SpawnLocation
	spawn_location.progress_ratio = randf()

	# Set the enemy's position to the random location.
	enemy.position = spawn_location.position

	add_child(enemy)
