extends CharacterBody2D

@onready var player = get_node("../player")
@onready var beam: Area2D = $beam
@onready var collision_shape_2d: CollisionShape2D = $beam/CollisionShape2D
@onready var end_level: Area2D = $"../end_level"
@onready var laser_beam: AudioStreamPlayer2D = $laser_beam


var player_is_here = false
var rng = RandomNumberGenerator.new()
var bullet_scene = preload("res://Scenes/bullet.tscn")
var bullet_on_cooldown = false
var attack_seq = 1
var last_attack = 1
var BOSS_SPEED = 700
var ANG_SPEED = 1.3
var HP = 1000

func shoot(pp):
	if bullet_on_cooldown: return
	var bullet = bullet_scene.instantiate()
	bullet.global_position = position
	bullet.from = position
	bullet.to = pp
	bullet.SPEED = 200
	get_parent().add_child(bullet)
	bullet_on_cooldown = true
	$bullet_cd.start()
	
func _on_bullet_cd_timeout() -> void:
	bullet_on_cooldown = false
	$bullet_cd.stop()

func _physics_process(delta: float) -> void:
	if !player_is_here: return
	if attack_seq == 1:
		if $Timer.is_stopped(): $Timer.start()
		shoot(player.position)
	elif attack_seq == 2:
		if $Timer.is_stopped(): 
			$Timer.start()
			laser_beam.play()
			var theta = (position - player.position).angle() + PI/2.0
			collision_shape_2d.disabled = false
			beam.rotation = theta
			beam.visible = true
		
		var u = player.position - position
		var v = Vector2.LEFT.rotated(beam.rotation)
		if v.cross(u) >= 0:
			beam.rotation += ANG_SPEED * delta
		else: beam.rotation -= ANG_SPEED * delta
		
	elif attack_seq == 3:
		if $Timer.is_stopped(): $Timer.start()
		velocity = (player.position - position).normalized() * BOSS_SPEED * delta
		move_and_slide()

func _on_timer_timeout() -> void:
	attack_seq = 0
	collision_shape_2d.disabled = true
	beam.visible = false
	laser_beam.stop()
	$Timer.stop()
	$rest.start()

func _on_rest_timeout() -> void:
	$rest.stop()
	last_attack += 1
	attack_seq = (last_attack % 3) + 1

func _on_beam_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "player":
		player.take_damage(50)

func _on_beam_area_entered(area: Area2D) -> void:
	print("laser hits: ", area.name)
	if "Lock" in area.name:
		area.queue_free()

func take_damage(d): 
	HP -= d
	if HP < 0: HP = 0
	#print("Taking dmg, hp = ", HP)
	$"../CanvasLayer/ProgressBar".value = HP
	
	if HP == 0:
		end_level.goto_next_level()

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_is_here = true
