extends Control


@onready var label = $"Particle Count"

func _process(delta):
	var _count = 0
	for _p in get_tree().get_nodes_in_group("P"):
		_count+=1 
	
	label.text = " " + str(_count) + " : " + str(Engine.get_frames_per_second())
