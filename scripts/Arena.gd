extends Node2D

export var arenaName = "Map"

export(float) var left;
export(float) var right;
export(float) var top;
export(float) var bottom;

var player;

# Called when the node enters the scene tree for the first time.
func _ready():
	player = preload("res://scenes/Player.tscn").instance()
	add_child(player)
	player.position = $Player1Spawn.position

func wrapAroundBoundary(node: Node2D, spawnOffset = 0):
	if (node.position.x > right + spawnOffset): node.position = Vector2(right + spawnOffset, node.position.y);
	if (node.position.x < left - spawnOffset): node.position = Vector2(left - spawnOffset, node.position.y);
	if (node.position.y > bottom): node.position = Vector2(node.position.x, top);
	if (node.position.y < top): node.position = Vector2(node.position.x, bottom);

func _physics_process(_delta):
	pass
