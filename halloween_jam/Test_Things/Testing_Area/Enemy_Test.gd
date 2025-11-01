extends CharacterBody2D


@export var speed = 100
@export var health = 100
@export var attackRange = 200
@export var attackDelay = 1
@onready var player = %Player
@onready var nav_agent = $NavigationAgent2D
@onready var line_of_sight = $RayCast2D

func Hit(damage):
	health -= damage
	if health <= 0:
		queue_free()

func _physics_process(delta: float) -> void:
	var path_distance = nav_agent.distance_to_target()
	line_of_sight.target_position = to_local(player.global_position)
	line_of_sight.force_raycast_update()
	if path_distance > attackRange or line_of_sight.is_colliding():
		var next_point = nav_agent.get_next_path_position()
		var dir = global_position.direction_to(next_point)
		velocity = dir * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()


func _on_timer_timeout() -> void:
	nav_agent.target_position = player.global_position
