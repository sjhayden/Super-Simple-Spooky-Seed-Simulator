extends Label

func _ready():
	# Connect to the score_updated signal from the GameManager
	GameManager.kill_count.connect(update_kill_count_display)
	
	# Initialize the display with the current score
	update_kill_count_display(GameManager.get_kill_count())

func update_kill_count_display(new_num: int):
	text = "Kill Count: " + str(new_num)
