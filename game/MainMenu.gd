extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var focus_index = 2;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Level1.set_process(false);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		match focus_index:
			0:
				$CanvasLayer/HBoxContainer/Options.grab_focus();
				focus_index = 1;
			1:
				$CanvasLayer/HBoxContainer/QuitGame.grab_focus();
				focus_index = 2;
			2:
				$CanvasLayer/HBoxContainer/StartGame.grab_focus();
				focus_index = 0;
	elif Input.is_action_just_pressed("ui_up"):
		match focus_index:
			0:
				$CanvasLayer/HBoxContainer/QuitGame.grab_focus();
				focus_index = 2;
			1:
				$CanvasLayer/HBoxContainer/StartGame.grab_focus();
				focus_index = 0;
			2:
				$CanvasLayer/HBoxContainer/Options.grab_focus();
				focus_index = 1;


func _on_StartGame_pressed():
	get_tree().change_scene("res://Game.tscn");

func _on_Options_pressed():
	pass # Replace with function body.

func _on_QuitGame_pressed():
	get_tree().quit();


