extends Node2D

var ShopUI = preload("res://ShopUI.tscn");
var shop_ui = null;

var current_player;

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	
	players()[0].get_node("Camera2D").make_current();
	players()[0].state.set_selected(true);
	
	current_player = players()[0];
	
	for x in range(0, len(players())):
		if x*16 < players()[x].get_node("Sprite").texture.get_width():
			players()[x].get_node("Sprite").region_rect = Rect2(x*16, 0, 16, 16);
		else:
			var x_value = x*16 - players()[x].get_node("Sprite").texture.get_width();
			players()[x].get_node("Sprite").region_rect = Rect2(x_value, 16, 16, 16);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if len(players()) >= 1:
	
		if Input.is_action_just_pressed("big_camera"):
			Globals.global_cam = not Globals.global_cam;
			if Globals.global_cam:
				$Body/Camera2D.make_current();
			else:
				current_player.get_node("Camera2D").make_current();
		
		if Input.is_action_just_released("change_up") or current_player.state.dead():
			change_player(not Globals.global_cam);
		elif Input.is_action_just_released("change_down"):
			change_player(not Globals.global_cam);
		elif Input.is_action_just_pressed("open_menu"):
			if shop_ui:
				remove_child(shop_ui);
				shop_ui = null;
				print("Unshowing Shop UI");
			else:
				shop_ui = ShopUI.instance();
				print("Showing Shop UI");
				add_child(shop_ui);
	else:
		$UI.make_all_invisible();
		$GameOver.start();

func current_position():
	return current_player.position;

func change_player(change_cam := true):
	for x in players():
		if not x.state.dead() and x != current_player:
			print(x.position);
			change_player_from(current_player, change_cam);
			current_player = x;
			change_player_to(current_player, change_cam);
			break;

func change_player_from(current_player, change_cam := true):
	if change_cam:
		current_player.get_node("Camera2D").current = false;
	current_player.state.set_selected(false);

func change_player_to(current_player, change_cam := true):
	if change_cam:
		current_player.get_node("Camera2D").current = true;
	current_player.state.set_selected(true);

func players():
	return get_tree().get_nodes_in_group("players");


func _on_Area2D_body_entered(body):
	pass # Replace with function body.
