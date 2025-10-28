class_name CornPlant
extends Node2D

@onready var anim := $AnimatedSprite2D
@onready var grow_timer := $GrowTimer
var growth_level = 0
const anim_strings = ["sprout", "growing", "full_grown"]
const MAX_GROWTH_LEVEL = 2

func _ready() -> void:
	anim.play(anim_strings[growth_level]) # unnecessary?

func harvest():
	if growth_level == MAX_GROWTH_LEVEL:
		print("harvested")
		queue_free()


func _on_grow_timer_timeout() -> void:
	if growth_level < MAX_GROWTH_LEVEL:
		growth_level += 1
	anim.play(anim_strings[growth_level])
	if growth_level >= MAX_GROWTH_LEVEL:
		grow_timer.stop()
		
	
