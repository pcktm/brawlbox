extends Node2D

export var strength = 20;

func _input(event):
	if event is InputEventMouseMotion:
		var offset = Vector2(320 - event.position.x, 180 - event.position.y);
		offset = offset/strength;
		position = Vector2(320+offset.x, 180+offset.y);
