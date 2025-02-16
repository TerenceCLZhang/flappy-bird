extends Control

var game: Node2D
@onready var score_val = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/VBoxContainer/VBoxContainer2/ScoreValue
@onready var best_val = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/VBoxContainer/VBoxContainer3/BestValue


func _ready() -> void:
	var current_game_score = get_current_game_score()
	var best_score = Global.save_data.best_score
	score_val.text = current_game_score
	best_val.text = str(best_score)
	$Die.play()


func get_current_game_score() -> String:
	game = get_parent()
	for label in game.get_children():
		if label is Label:
			return label.text
	printerr("ERROR: Could not find score label.")
	return "0"


func _on_restart_button_pressed() -> void:
	game = get_parent()
	game.restart()
