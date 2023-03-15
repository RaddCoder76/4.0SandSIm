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
	if result[0] == false:
		print(result)
		Move(result[1])

func Move(_pos = Vector2()):
	timeSinceLastMove = 0
	position = _pos





func VerifyPosition(_pos):
	for spot in Global.positionSpotHolder:
		if spot[1] == _pos and self != spot[0]:
			return false
	return true










#COMPLETE
#return [[true, particleType] if hit, [false] if no hit
func CheckPos(_listOfPos = [Vector2()], _exclude = [self]):
	var lastThingIHit = null
	for _pos in _listOfPos:
		var _point = PhysicsPointQueryParameters2D.new()
		_point.collide_with_areas = true
		_point.collide_with_bodies = false
		_point.exclude = _exclude
		_point.set("position", _pos)
		
		
		var result = get_world_2d().direct_space_state.intersect_point(_point, 32)
		if result.size() == 0: #did not detect them
			return [false, _pos]
		else:# Hit something
			lastThingIHit = result[0].collider
	return [true, lastThingIHit]







func DebugDisplay():
	#print(CheckPos(position))
	if CheckPos(position)[1]:
		modulate = Color.BLACK
	elif timeSinceLastMove >= Global.MOVEBUFFER:
		modulate = Color.RED
	elif !CheckPos(position)[1]:
		modulate = Color.YELLOW
		#modulate.h = rnd.randi_range(0, 66)
		#modulate.s = 100
		#modulate.v = 100
		
