extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var been_called_before = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Label.visible = false;

func start():
	if not been_called_before:
		$AnimationPlayer.play("game_over");
	been_called_before = true;
