extends Node2D

@export var particle = load("res://Scenes/Particles/Particle.tscn") as PackedScene
@export var timeLeft = 1.0
var Main

func _ready():
	$Timer.wait_time = timeLeft
	Main = get_tree().get_first_node_in_group("Main")

func _process(delta):
	if Input.is_action_just_pressed("t") and !Main.DEBUG_MODE:
		on = !on

var on = false
func _on_timer_timeout():
	if on and !Main.DEBUG_MODE:
		var instance = particle.instantiate()
		instance.global_position = global_position
		get_tree().current_scene.add_child(instance)
	pass # Replace with function body.
