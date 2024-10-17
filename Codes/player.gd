extends CharacterBody2D

@export var animationPlaying = false
@export var hasSword = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var end_level = get_node("../end_level")
@onready var hud = get_node("../CanvasLayer/HUD/hp")
@onready var death_screen = get_node("../CanvasLayer/death_screen")

var player_HP = 100
const SPEED = 5000.0
const SNEAK_SPEED = SPEED * 0.35

func _ready() -> void:
	hud.text = str(player_HP)

func _physics_process(delta: float) -> void:
	if animationPlaying:
		animated_sprite_2d.play("idle")
		return
		
	var d1 := Input.get_axis("move_left", "move_right")
	var d2 := Input.get_axis("move_up", "move_down")
	
	velocity = Vector2(d1, d2).normalized()
	
	if !velocity.is_zero_approx():
		rotation = velocity.angle() + PI / 2
		if Input.is_action_pressed("sneak"):
			velocity *= SNEAK_SPEED * delta
			animated_sprite_2d.play("sneak")
		else: 
			velocity *= SPEED * delta
			animated_sprite_2d.play("run")
	else:
		if Input.is_action_pressed("sneak"):
			animated_sprite_2d.play("sneak_idle")
		else: animated_sprite_2d.play("idle")
	
	# print(str(delta) + ": " + str(velocity.x) + " " + str(velocity.y) + " " + str(position))
	move_and_slide()

func _process(delta: float) -> void:
	if hasSword and Input.is_action_just_pressed("attack"):
		#print("Attack!!")
		$sword_attack.play("attack")
		
func take_damage(val):
	#print("DMG taken = " + str(val))
	if get_parent().name == "level_7": return
	if val > 0: $player_hurt.play()
	player_HP = max(min(player_HP - val, 100), 0)
	hud.text = str(player_HP)
	if player_HP == 0:
		death_screen.player_died()
		#end_level.restart_level()
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	#print(body.name, " hit by sword")
	if body.name == "boss" or "minion" in body.name:
		body.take_damage(50)
