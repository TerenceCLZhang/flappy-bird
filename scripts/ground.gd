extends Area2D

const GROUND_SPEED = 200.0
const AUTO_SCROLL_SPEED = Vector2(-GROUND_SPEED, 0.0)


func _ready() -> void:
	ground_moving()


func _on_bird_stop_game() -> void:
	$Parallax2D.autoscroll = Vector2.ZERO


func ground_moving() -> void:
	$Parallax2D.autoscroll = AUTO_SCROLL_SPEED


func _on_game_restart_game() -> void:
	ground_moving()
