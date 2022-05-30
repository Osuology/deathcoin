extends Node

signal coins_changed(coins);

var global_cam = false;

var death_coins = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_coins(amount):
	death_coins = amount;
	emit_signal("coins_changed", death_coins);

func add_coins(amount):
	death_coins += amount;
	emit_signal("coins_changed", death_coins);

func get_attr(string):
	match string:
		"deathcoin":
			return death_coins;

func set_attr(string, amount):
	match string:
		"deathcoin":
			set_coins(amount);

func add_attr(string, amount):
	set_attr(string, get_attr(string)+amount);

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
