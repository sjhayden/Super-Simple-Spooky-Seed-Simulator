extends Node

# A custom signal that other nodes can connect to
signal num_corns_updated(new_score)

# Private variable to store the score
var _num_corns: int = 3

# Public property to get the current score
func get_num_corns() -> int:
	return _num_corns

# Method to add points and emit a signal
func change_num_corns(amount: int):
	_num_corns += amount
	emit_signal("num_corns_updated", _num_corns)
