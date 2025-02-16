extends Node2D

const PIPE = preload("res://scenes/pipe.tscn")
const PIPE_MIN_MAX_Y = [150, 450]
const PIPE_SPEED = 200
const END_MENU = preload("res://scenes/end_screen.tscn")
var game_started = false
var game_over = false
var tween: Tween

signal restart_game


func _process(delta: float) -> void:
	if !game_started: check_game_start()
	elif !game_over: move_pipes(delta)


func check_game_start() -> void:
	if !game_started and Input.is_action_pressed("jump"):
		game_started = true
		$Pipes/Timer.wait_time = 2
		$Pipes/Timer.start()


func spawn_pipe() -> void:
	var rng = RandomNumberGenerator.new()
	var pipe = PIPE.instantiate()
	pipe.position = Vector2(get_viewport().get_size().x + 100, rng.randf_range(PIPE_MIN_MAX_Y[0], PIPE_MIN_MAX_Y[1]))
	$Pipes.add_child(pipe)


func move_pipes(delta: float) -> void:
	for pipe in $Pipes.get_children():
		if pipe is Area2D:
			pipe.position.x -= PIPE_SPEED * delta
			if pipe.position.x == -100: pipe.queue_free()


func _on_bird_stop_game() -> void:
	game_over = true
	$Score.visible = false
	tween = create_tween()
	tween.tween_property($EndGameFlash, "modulate:a", 1, 0.1)
	$EndGameFlash/Timer.start()


func _on_game_over_timer_timeout() -> void:
	tween = create_tween()
	tween.tween_property($EndGameFlash, "modulate:a", 0, 0.3)
	show_end_pop_up()


func _on_pipe_timer_timeout() -> void:
	if !game_over:
		spawn_pipe()
		$Pipes/Timer.wait_time = 1.5
		$Pipes/Timer.start()
	

func show_end_pop_up() -> void:
	var end_menu = END_MENU.instantiate()
	end_menu.position = Vector2(end_menu.pivot_offset.x, end_menu.pivot_offset.y)
	add_child(end_menu)


func restart() -> void:
	restart_game.emit()
	for child in get_children():
		if child.name == "Pipes":
			for pipe in child.get_children():
				if pipe is not Timer: pipe.queue_free()
		elif child.name == "EndScreen":
			child.queue_free()
	game_started = false
	game_over = false
