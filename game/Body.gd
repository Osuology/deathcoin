extends Node2D

var BodyPart = preload("res://BodyPart.tscn");

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x = 0;
	var y = 0;
	var count = 0;
	var furthest_dist = 0.0;
	var furthest_vec = Vector2(1, 1);
	for child in get_children():
		if get_tree().get_nodes_in_group("players").has(child):
			count += 1;
			x += child.position.x;
			y += child.position.y;
		
			for child2 in get_children():
				if get_tree().get_nodes_in_group("players").has(child2):
					if abs(child2.position.distance_to(child.position)) > furthest_dist:
						furthest_vec = child2.position - child.position;
	if count > 0:
		x /= count;
		y /= count;
	$Camera2D.position = Vector2(x, y);
	
	# The idea of the zoom is that as the max distance between players grows, the zoom shifts UP!!! TO ZOOM OUT
	# However, it needs to shift in a logarithmic form where it gets lower, slower and slower because zoom has a large effect.
	
	var x_1 = 1;
	if abs(furthest_vec.x) > 0:
		x_1 = len(get_tree().get_nodes_in_group("players"))*abs(furthest_vec.x)/140;
		if x_1 < 1:
			x_1 = 1;
	
	var y_1 = 1;
	if abs(furthest_vec.y) > 0:
		y_1 = len(get_tree().get_nodes_in_group("players"))*abs(furthest_vec.y)/140;
		if y_1 < 1:
			y_1 = 1;
	
	if y_1 > x_1:
		$Camera2D.zoom = Vector2(y_1, y_1);
	else:
		$Camera2D.zoom = Vector2(x_1, x_1);
