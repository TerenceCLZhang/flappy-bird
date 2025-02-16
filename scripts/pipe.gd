extends Area2D


func _on_body_entered(body: Node2D) -> void:
	var game = body.get_parent()
	for child in game.get_children():
		if child.name == "Score":
			child.increase_score()
