extends Label

func _ready():
	# Connect to the score_updated signal from the GameManager
	GameManager.num_corns_updated.connect(update_num_corns_display)
	
	# Initialize the display with the current score
	update_num_corns_display(GameManager.get_num_corns())

func update_num_corns_display(new_num: int):
	text = "Candy Corns: " + str(new_num)
