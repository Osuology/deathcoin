extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("coins_changed", self, "coins_changed");

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func make_all_invisible():
	$Money.visible = false;

func coins_changed(coins):
	$Money.text = "Deathcoin: " + str(Globals.death_coins);
