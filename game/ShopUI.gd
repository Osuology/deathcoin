extends CanvasLayer

var BodyPart = preload("res://BodyPart.tscn");

var selected = -1;

# Called when the node enters the scene tree for the first time.
func _ready():
	$ItemList.add_item("(5) Purchase Body Part");
	$ItemList.add_item("(20) Purchase Perk");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		selected += 1;
		$ItemList.select(selected);
	elif Input.is_action_just_pressed("ui_accept"):
		$ItemList.emit_signal("item_activated", selected);

func add_body_part():
	if Globals.death_coins >= 5:
		Globals.add_coins(-5);
		var new_part = BodyPart.instance();
		var rand = randi() % 8;
		var pos_offset = Vector2.ZERO;
		match rand:
			0:
				pos_offset = Vector2(16, 0);
			1:
				pos_offset = Vector2(16, 16);
			2:
				pos_offset = Vector2(0, 16);
			3:
				pos_offset = Vector2(-16, 16);
			4:
				pos_offset = Vector2(-16, 0);
			5:
				pos_offset = Vector2(-16, -16);
			6:
				pos_offset = Vector2(0, -16);
			7:
				pos_offset = Vector2(16, -16);
		new_part.position = get_node("../").current_position()+pos_offset;
		get_tree().get_nodes_in_group("Body")[0].add_child(new_part);

func _on_ItemList_item_activated(index):
	print("item select-",index);
	if index == 0:
		add_body_part();
