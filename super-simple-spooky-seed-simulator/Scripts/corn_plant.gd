class_name CornPlant
extends Node2D

@onready var anim := $AnimatedSprite2D
@onready var grow_timer := $GrowTimer
var growth_level = 0
const anim_growing_strings = ["sprout", "growing", "full_grown"]
const anim_eating_string = ["eaten_3", "eaten_2", "eaten_1"]
const MAX_GROWTH_LEVEL = 2
var num_corns = 3

func _ready() -> void:
	anim.play(anim_growing_strings[growth_level]) # unnecessary?

func harvest():
	if growth_level == MAX_GROWTH_LEVEL or num_corns == 0:
		GameManager.change_num_corns(num_corns)
		queue_free()
		
func bite():
	grow_timer.stop()
	if growth_level == 0:
		anim.play("eaten_sprout")
		num_corns = 0
	elif growth_level == 1:
		anim.play("eaten_growing")
		num_corns = 0
	elif growth_level == MAX_GROWTH_LEVEL:
		if num_corns > 0: num_corns -= 1
		anim.play(anim_eating_string[num_corns])


func _on_grow_timer_timeout() -> void:
	if growth_level < MAX_GROWTH_LEVEL:
		growth_level += 1
	anim.play(anim_growing_strings[growth_level])
	if growth_level >= MAX_GROWTH_LEVEL:
		grow_timer.stop()
	
		
	
