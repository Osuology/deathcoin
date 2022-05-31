extends KinematicBody2D

export var speed = 100;
export var sprint_speed = 100;

# =====================================
# 	Instances
# =====================================

var Drop = preload("res://Drop.tscn");

# =====================================

var state = BodyPartState.new();

var drop_amount = 10;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not state.dead():
		pass
	elif state.matches(BodyPartState.State.Dying):
		$Light2D.enabled = false;
		if not $AnimationPlayer.is_playing():
			yield(get_tree().create_timer(1.0), "timeout");
			state.change_state(BodyPartState.State.Dead);
	elif state.matches(BodyPartState.State.Dead):
		queue_free();

func _physics_process(delta):
	if state.controllable():
		var move_x = Input.get_axis("left", "right"); 
		var move_y = Input.get_axis("up", "down"); 
		if move_x != 0 or move_y != 0:
			if Input.is_action_pressed("sprint"):
				move_and_slide(Vector2(move_x, move_y)*sprint_speed);
			else:
				move_and_slide(Vector2(move_x, move_y)*speed);

func change_drop_amt(amount):
	drop_amount = amount;

func damage(amount):
	state.damage(amount);
	
	var drop = Drop.instance();
	drop.amount = drop_amount;
	drop.position = position;
	get_tree().get_nodes_in_group("DropContainer")[0].add_child(drop);
