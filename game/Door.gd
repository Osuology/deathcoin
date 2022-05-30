extends StaticBody2D

export var req = "deathcoin";
export var req_amount = 5;

var can_be_opened = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_be_opened and Input.is_action_just_pressed("purchase"):
		try_open();

func _on_Area2D_body_entered(body):
	if get_tree().get_nodes_in_group("players").has(body):
		$Label.text = str(req_amount) + " " + req + " to open this door.";
		can_be_opened = true;

func _on_Area2D_body_exited(body):
	if get_tree().get_nodes_in_group("players").has(body):
		$Label.text = "";
		can_be_opened = false;

func try_open():
	if Globals.get_attr(req) >= req_amount:
		var cs = get_node("CollisionShape2D");
		cs.set_deferred("disabled", true);
		$Area2D/CollisionShape2D.set_deferred("disabled", true);
		$Sprite.visible = false;
		if get_node("Sprite2"):
			$Sprite2.visible = false;
		Globals.add_attr(req, -req_amount);
