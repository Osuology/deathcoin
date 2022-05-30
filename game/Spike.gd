extends StaticBody2D

export var damage = 10;
export var dcs = 10;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HitBox_area_entered(area):
	if get_tree().get_nodes_in_group("players").has(area.get_parent()):
		var player = area.get_parent();
		player.change_drop_amt(dcs);
		player.damage(10);
