extends RigidBody2D

@onready var anim = $AnimatedSprite2D
var hits_taken = 0

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
