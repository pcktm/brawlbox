extends Node2D

enum ENGINE_STATE {MENU, ARENA, LOADING}
var currentState = ENGINE_STATE.LOADING;

# Called when the node enters the scene tree for the first time.
func _ready():
	var menu = preload("res://scenes/arenas/Classic.tscn");
	add_child(menu.instance())
	currentState = ENGINE_STATE.ARENA;


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
