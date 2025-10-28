class_name CornPlant
extends Node2D

func _ready() -> void:
	print("planted")

func harvest():
	print("harvested")
	queue_free()
