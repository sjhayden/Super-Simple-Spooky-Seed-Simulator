class_name PlantManager
extends Node2D

@export var tile_map: TileMapLayer
var corn_plant_scene = preload("res://Scenes/corn_plant.tscn")
var plants: Dictionary[Vector2i, CornPlant] = {}

func plant_or_harvest(player_coords: Vector2i) -> void:
	var tile_coords = tile_map.local_to_map(self.to_local(player_coords))
	var tile_data = tile_map.get_cell_tile_data(tile_coords)
	if tile_data.get_custom_data("plantable"):
		if tile_coords not in plants or plants[tile_coords] == null:
			var corn_plant = corn_plant_scene.instantiate()
			add_child(corn_plant)
			corn_plant.position = tile_map.map_to_local(tile_coords)
			plants[tile_coords] = corn_plant
		else:
			plants[tile_coords].harvest()
		
