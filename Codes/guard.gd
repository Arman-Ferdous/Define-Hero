extends CharacterBody2D

#signal shoot_bullet(from: Vector2, to: Vector2)
var bullet_scene = preload("res://Scenes/bullet.tscn")
var bullet_on_cooldown = false

var player_inside = false
@export var use_torch = true
@onready var player = get_node("../player")
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var can_see_report: Label = $CanSeeReport

const OUTER_RADIUS = 8000
const INNER_RADIUS = 4500

func _ready() -> void:
	if use_torch == false:
		$PointLight2D.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	#print(body.name)
	if (body.name == "player"):
		player_inside = true
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body.name == "player"):
		player_inside = false
		
func shoot(pp):
	if bullet_on_cooldown: return
	var bullet = bullet_scene.instantiate()
	bullet.global_position = position
	bullet.from = position
	bullet.to = pp
	get_parent().add_child(bullet)
	bullet_on_cooldown = true
	$bullet_cd.start()
	
func _on_bullet_cd_timeout() -> void:
	bullet_on_cooldown = false
	$bullet_cd.stop()

func _physics_process(delta: float) -> void:
	var dist: int = position.distance_squared_to(player.position)
	
	if player_inside:
		var direct_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(position, player.position, 1, [self])
		var result = direct_state.intersect_ray(query)	
		var player_seen = str(result["collider"]).find("player") != -1
		
		if player_seen and dist <= INNER_RADIUS:
			can_see_report.text = "!"
			shoot(player.position)
		elif player_seen and dist <= OUTER_RADIUS and !Input.is_action_pressed("sneak"):
			can_see_report.text = "!"
			shoot(player.position)
		else:
			can_see_report.text = ""
	else: can_see_report.text = ""
	#if player_inside:
		#ray_cast_2d.set_enabled(true)
