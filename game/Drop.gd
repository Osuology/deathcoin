extends KinematicBody2D

enum Type {
	Coins,
}

var type = Type.Coins;
var amount;

func _init(init_amount := 10):
	amount = init_amount;

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Idle");

func _process(delta):
	pass

func _on_Area2D_area_entered(area):
	if get_tree().get_nodes_in_group("players").has(area.get_parent()) and not area.get_parent().state.dead():
		if type == Type.Coins:
			Globals.add_coins(amount);
		queue_free();
