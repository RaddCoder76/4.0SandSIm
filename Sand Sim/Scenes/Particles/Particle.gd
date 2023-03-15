extends Area2D


#CONSTANT VARS 
@export var CANMOVE = true


var rnd = RandomNumberGenerator.new()
@export var timeSinceLastMove = 0
var hasMoved = true



# position = Vector2(), exclude = [], collision_mask = 4294967295, collide_with_bodies/areas = false/true, 


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ INPUT DIRECTION LIST AND TYPE @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
@export  var particleType = "Sand"

######################################################################################################################################################################################################

#Set Start Propetys 
func _ready():
	#Set _point vars 
	if CANMOVE:
		Global.particleList.append(self)
	

#Do this on exit
func _exit_tree():
	Global.particleList.erase(self)



func _physics_process(delta):
	return
	if CANMOVE:
		CallFrame()

func CallFrame():
	DebugDisplay()
	var posList = [Vector2(position.x, position.y + Global.SIZE), Vector2(position.x + Global.SIZE , position.y + Global.SIZE),
	Vector2(position.x - Global.SIZE , position.y + Global.SIZE)]
	var result = CheckPos(posList)
	if result[0][0]:
		print(result)
		Move(result[0][1])

func Move(_pos = Vector2()):
	timeSinceLastMove = 0
	position = _pos





func VerifyPosition(_pos):
	for spot in Global.positionSpotHolder:
		if spot[1] == _pos and self != spot[0]:
			return false
	return true










#COMPLETE
#takes in a list of vector2s and return a list that: [[true/false, position/whatIHit]]
func CheckPos(_listOfPos = [Vector2()], _exclude = [self]):
	var whatIHit = null
	var returnList = []
	for _pos in _listOfPos:
		var _point = PhysicsPointQueryParameters2D.new()
		_point.collide_with_areas = true
		_point.collide_with_bodies = false
		_point.exclude = _exclude
		_point.set("position", _pos)
		
		
		var result = get_world_2d().direct_space_state.intersect_point(_point, 32)
		if result.size() > 0:
			print([false, result[0].collider])
			returnList.append([false, result[0].collider])
		else:
			returnList.append([true, _pos])
	
	return returnList







func DebugDisplay():
	var results = CheckPos(position)
	#print(results)
	#if !results[0]:
	#	modulate = Color.BLACK
	#elif timeSinceLastMove >= Global.MOVEBUFFER:
	#	modulate = Color.RED
	#elif results[0]:
	#	modulate = Color.YELLOW
		#modulate.h = rnd.randi_range(0, 66)
		#modulate.s = 100
		#modulate.v = 100
		
