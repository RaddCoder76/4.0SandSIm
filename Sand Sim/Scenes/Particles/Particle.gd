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
	var result = CheckDir(Vector2(0,1), 1)
	if result[0]:
		print(result)
		Move(result[1])
	else:
		timeSinceLastMove+=1

func Move(_pos = Vector2()):
	timeSinceLastMove = 0
	position += _pos





func VerifyPosition(_pos):
	for spot in Global.positionSpotHolder:
		if spot[1] == _pos and self != spot[0]:
			return false
	return true










#COMPLETE
#takes in a list of vector2s and return a list that: [[true/false, position/whatIHit]]
func CheckDir(_dir = Vector2(0,1), _dis = 1 , _exclude = [self]):
	var returnList
	if _dis > 0:
		for _num in _dis:
			var _pos = (_dir.normalized() * (_num + 1))
			var _point = PhysicsPointQueryParameters2D.new()
			_point.collide_with_areas = true
			_point.collide_with_bodies = false
			_point.exclude = _exclude
			_point.set("position", _pos)
			
			
			var result = get_world_2d().direct_space_state.intersect_point(_point, 32)
			if result.size() > 0 and _num == 0:
				print([false, result[0].collider])
				return [false, result[0].collider]
			elif result.size() == 0:
				returnList = [true, _pos]
		print(returnList)
		return returnList







func DebugDisplay():
	var results = CheckDir(position, 0)
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
		
