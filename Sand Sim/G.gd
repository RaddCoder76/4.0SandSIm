extends Node

var DEBUG_MODE = true
@export var SIZE = 8
var MOVEBUFFER = 10

var rnd = RandomNumberGenerator.new()
# [particle, positiontheywant]
var positionSpotHolder = []

var activeParticles = []


func _process(delta):
	if Input.is_action_just_pressed("q"):
		DEBUG_MODE = !DEBUG_MODE
	if Input.is_action_just_pressed("Restart"):
		get_tree().reload_current_scene()
		

func IsOnSpotList(_pos):
	for _spot in GetSpotList():
		if _spot[1] == _pos:
			return true
	return false
	

func IsOnActiveList(_p):
	for _spot in activeParticles:
		if _spot == _p:
			return true
	return false

func GetFinalPos(_list : Array):
	var finalPos = null
	for _posToVerify in _list:
		if !IsOnSpotList(_posToVerify):
			finalPos = _posToVerify
		else :
			return finalPos
	
	return finalPos

func _physics_process(delta):
	if DEBUG_MODE:
		if Input.is_action_just_pressed("e"):
			activeParticles.shuffle()
			var _list = activeParticles
			activeParticles = []
			for _p in _list:
				#_p.CANMOVE = true
				_p.Update()
	else:
		activeParticles.shuffle()
		var _list = activeParticles
		activeParticles = []
		for _p in _list:
			if _p != null:
				#_p.CANMOVE = true
				
				_p.Update()


func AddToActiveParticles(_p):
	if !IsOnActiveList(_p) and _p.CANMOVE:
		#_p.tick = 0
		#_p.isActive = true
		activeParticles.append(_p)

func RemoveFromActiveParticles(_p):
	if IsOnActiveList(_p):
		activeParticles.erase(_p)

func GetActiveParticles():
	return activeParticles

func AddToSpotList(_p, _pos : Vector2):
	positionSpotHolder.append([_p, _pos])

func RemoveFromSpotList(_p, _pos):
	positionSpotHolder.erase([_p, _pos])

func GetSpotList():
	return positionSpotHolder
