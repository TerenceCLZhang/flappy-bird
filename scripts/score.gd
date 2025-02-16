extends Label


func increase_score() -> void:
	text = str(int(text) + 1)
	$Point.play()


func _on_game_restart_game() -> void:
	text = "0"
	visible = true


func _on_bird_stop_game() -> void:
	visible = false
	set_best_score()


func set_best_score() -> void:
	if int(text) > Global.save_data.best_score:
		Global.save_data.best_score = int(text)
		Global.save_data.save()
