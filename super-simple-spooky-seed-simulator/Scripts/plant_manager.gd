extends Node2D

@export var tile_map: TileMapLayer

func plant(player_coords: Vector2) -> void:
	var tile_coords = tile_map.local_to_map(self.to_local(player_coords))
	var tile_data = tile_map.get_cell_tile_data(tile_coords)
	if tile_data.get_custom_data("plantable"):
		print("plant")
		
func _input(event):
#	planting with mouse click for testing
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		plant(get_global_mouse_position())
