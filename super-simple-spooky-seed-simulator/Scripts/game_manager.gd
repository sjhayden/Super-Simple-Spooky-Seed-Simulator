extends Node

# A custom signal that other nodes can connect to
signal num_corns_updated(new_score)
signal kill_count(new_count)

# Private variable to store the score
var _num_corns: int = 3
var _num_killed: int = 0

# Public property to get the current score
func get_num_corns() -> int:
	return _num_corns

func get_kill_count() -> int:
	return _num_killed

# Method to add points and emit a signal
func change_num_corns(amount: int):
	_num_corns += amount
	emit_signal("num_corns_updated", _num_corns)

func update_num_killed():
	_num_killed += 1
	emit_signal("kill_count", _num_killed)
