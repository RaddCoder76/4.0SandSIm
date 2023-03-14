extends Node

var DEBUG_MODE = false
@export var SIZE = 8
var MOVEBUFFER = 10

var positionSpotHolder = []

var particleList = []

@export var attemptList = 0
func _process(delta):
	positionSpotHolder = []
	if Input.is_action_just_pressed("q"):
		DEBUG_MODE = !DEBUG_MODE
	if Input.is_action_just_pressed("Restart"):
		get_tree().reload_current_scene()



