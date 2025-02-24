extends CharacterBody2D

const JUMP_FORCE := 375.0
const GRAVITY := 1000.0
var game_started := false
var game_over := false
var tween: Tween

signal stop_game


func _ready() -> void:
	position = Vector2(128, 338)


func _process(delta: float) -> void:
	if game_over:
		if position.y < 600: apply_gravity(delta)
		else: return
	else:
		if !game_started: position.y += sin(Time.get_ticks_msec() / 150.0) * delta * 50
		else: apply_gravity(delta)
		fly()
	get_bird_direction()
	move_and_slide()


func apply_gravity(delta: float) -> void:
	velocity.y += GRAVITY * delta


func fly() -> void:
	if Input.is_action_pressed("jump") and !game_over and position.y > -50:
		if !game_started: game_started = true
		velocity.y = -JUMP_FORCE
		$Sounds/Wind.play()


func get_bird_direction() -> void:
	if game_started and !game_over:
		tween = create_tween()
		if velocity.y < 0: tween.tween_property(self, "rotation_degrees", -25, 0.1)
		elif velocity.y >= 0: tween.tween_property(self, "rotation_degrees", 90, 0.75)


func _on_ground_body_entered(_body: Node2D) -> void:
	end_game()


func end_game() -> void:
	if !game_over:
		game_over = true
		$AnimatedSprite2D.stop()
		$Sounds/Hit.play()
		stop_game.emit()
