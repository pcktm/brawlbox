extends KinematicBody2D

export var knockbackDamping = 1.2;
export var knockbackTreshold = 0.2;
export(float) var maxKnockback;
export var gravityStrength = 1.0;
export var jumpStrength = 300;
export(int) var moveSpeed;
export(int) var maxSpeed;
export(int) var maxHP;

var velocity = Vector2(0,0);
var knockback = Vector2(0,0);

onready var HP = maxHP;
onready var sprite = $Sprite as Node2D;
onready var spriteScaleX = sprite.scale.x;
onready var animPlayer = $AnimationPlayer as AnimationPlayer;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func die(_byGem):
	pass;

func harm(strength: float, dist: Vector2):
	HP = HP - 1;
	if HP <= 0: die(false);
	knockback = strength * dist.normalized() * Vector2(1, 0.03);

func applyGravityForce():
	velocity.y += 9.8 * gravityStrength;
	if velocity.y > maxSpeed: velocity.y = maxSpeed;

func applyKnockbackForce():
	velocity += knockback;
	knockback /= knockbackDamping;
	if knockback.length() < knockbackTreshold:
		knockback = Vector2.ZERO;

func checkKnockback(group: String, strength: float, strengthOther:float):
	for i in range(0, get_slide_count()):
		var coll = get_slide_collision(i);
		if not coll.collider is Node2D: continue;
		var other = coll.collider as Node2D;
		if(other.is_in_group(group)):
			var dist = position - other.position;
			harm(strength, dist);
			other.harm(strengthOther, -dist);
