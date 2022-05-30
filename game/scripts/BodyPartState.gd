extends Resource

class_name BodyPartState

enum State {
	Idle,
	Walking,
	Sprinting,
	Attacking,
	Dying,
	Dead,
};

var Selected = false;
var States = [];

var Health = 5;

func _init():
	States.push_back(State.Idle);

func selected():
	return Selected;

func change_selected():
	set_selected(not selected());

func set_selected(select):
	Selected = select;

func matches(state):
	return States.has(state);

func get_state():
	return States.front();

func change_state(state):
	pop_state();
	push_state(state);

func pop_state():
	return States.pop_front();

func push_state(state):
	States.push_front(state);

# ======================================
# 	Complex Logic
# ======================================

func controllable():
	return not dead() and Selected;

func dead():
	return matches(State.Dying) or matches(State.Dead);

func damage(amount):
	Health -= 5;
	if Health <= 0:
		change_state(State.Dying);

# ======================================
