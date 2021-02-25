extends "res://scripts/Entity.gd"

export var gravityFallStrength = 2;
export var attackCD = 250;

var isJumping = false;
var nextAttackTime = 0;

onready var attackPoint = $AttackPoint;
onready var damageSound = $DamageSound;
onready var shootSound = $ShootSound;
onready var camera = $"../Camera" as Camera2D

var alive = true;

func _ready():
	pass # Replace with function body.

func getInput():
	print(velocity)
	velocity.x = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left")) * moveSpeed;
	if velocity.y == 0:
		if(is_on_floor() and Input.is_action_pressed("move_up")):
			isJumping = true;
			camera.shake(5)
			velocity.y = -1 * jumpStrength;
		else: isJumping = false;
	
	if(Input.is_action_just_released("move_up") or velocity.y > 0):
		isJumping = false;
	

func applyGravityForce():
	if isJumping:
		velocity.y += 9.8 * gravityStrength;
	else: 
		velocity.y += 9.8 * gravityFallStrength;
	if(velocity.y > maxSpeed): velocity.y = maxSpeed;

func _physics_process(_delta):
	getInput();
	applyGravityForce();
	checkKnockback("knockback", 500, 200);
	applyKnockbackForce();
	velocity = move_and_slide(velocity, Vector2.UP);
	if velocity.x == 0:
		animPlayer.current_animation = "idle"
	else: animPlayer.current_animation = "walk"
	if(velocity.x < -0.1):
		sprite.scale = Vector2(spriteScaleX * -1, sprite.scale.y);
	else: sprite.scale = Vector2(spriteScaleX, sprite.scale.y);
	get_parent().wrapAroundBoundary(self);
