extends Node2D

@export var tile_map: TileMapLayer
var corn_plant_scene = preload("res://Scenes/corn_plant.tscn")

func plant(player_coords: Vector2) -> void:
	var tile_coords = tile_map.local_to_map(self.to_local(player_coords))
	var tile_data = tile_map.get_cell_tile_data(tile_coords)
	if tile_data.get_custom_data("plantable"):
#		TODO: check if there is already a plant there
		var corn_plant = corn_plant_scene.instantiate()
		add_child(corn_plant)
		corn_plant.position = tile_map.map_to_local(tile_coords)
		
func _input(event):
#	planting with mouse click for testing
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		plant(get_global_mouse_position())
