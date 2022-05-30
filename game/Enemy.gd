extends KinematicBody2D

var speed = 32;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var closest_player;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):


	for x in get_tree().get_nodes_in_group("players"):
		if closest_player == null:
			closest_player = x;
		elif is_instance_valid(closest_player) and x.position.distance_to(position) < closest_player.position.distance_to(position):
			closest_player = x;

	if is_instance_valid(closest_player):
		var vel = Vector2.ZERO;
		if closest_player.position.x < position.x:
			vel.x = -speed;
		elif closest_player.position.x > position.x:
			vel.x = speed;

		if closest_player.position.y < position.y:
			vel.y = -speed;
		elif closest_player.position.y > position.y:
			vel.y = speed;
		
		if abs(vel.x) == abs(vel.y):
			var sign_x = sign(vel.x);
			var sign_y = sign(vel.y);
			vel = Vector2(sign_x*8, sign_y*8);

		print(vel);
		move_and_slide(vel);
	else:
		closest_player = null;
#
#	if is_instance_valid(closest_player):
#		var path_points = get_tree().get_nodes_in_group("nav")[0].get_simple_path(position, closest_player.position);
#
#		var closest;
#		for x in path_points:
#			if not closest:
#				closest = x;
#			elif x.distance_to(position) < closest.distance_to(position):
#				closest = x;
#
#		var vel = Vector2.ZERO;
#		if closest.x < position.x:
#			vel.x = -4;
#		elif closest.x > position.x:
#			vel.x = 4;
#
#		if closest.y < position.y:
#			vel.y = -4;
#		elif closest.y > position.y:
#			vel.y = 4;
#
#		move_and_slide(vel);
