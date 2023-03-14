extends Area2D

# 0 = false

# !0 = true




#CONSTANT VARS 

@export var CANMOVE = true

@onready var ani = $AnimationPlayer
var rnd = RandomNumberGenerator.new()
var timeSinceLastMove = 0
var hasMoved = true


var iMoved = false

# position = Vector2(), exclude = [], collision_mask = 4294967295, collide_with_bodies/areas = false/true, 
var _point = PhysicsPointQueryParameters2D.new()


######################################################################################################################################################################################################

#Set Start Propetys 
func _ready():
	#Set _point vars 
	Global.particleList.append(self)
	_point.collide_with_areas = true
	_point.collide_with_bodies = false

#Do this on exit
func _exit_tree():
	Global.particleList.erase(self)


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ INPUT DIRECTION LIST AND TYPE @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
var directionList = []
@export  var particleType = "Sand"
func _init():
	directionList = [Vector2(position.x, position.y + Global.SIZE),
	Vector2(position.x + Global.SIZE, position.y + Global.SIZE),
	Vector2(position.x - Global.SIZE, position.y + Global.SIZE)] 
	#print("X: " + str(global_position.x) + " : " + str(position.y) + str(Global.SIZE))
	iMoved = true


func _physics_process(delta):
	if CANMOVE:
		CallListFromGlobal()






func CallListFromGlobal():
	#print(directionList)
	var tempPosition = FindNewPosition(directionList)
	#print(str(directionList) + "\n\n\n : " + str(tempPosition))
	if VerifyPosition(tempPosition):
		Move(tempPosition)
	else:
		timeSinceLastMove += 1


#returns the position they find
func FindNewPosition(posToCheck = []):
	for p in posToCheck:
		var pos = CheckPos(p)[1]
		#print(pos)
		if !pos:
			
			Global.positionSpotHolder.append([self, p])
			return p# found new position that is not taken
	return position#found no spots
	

func VerifyPosition(_pos):
	for spot in Global.positionSpotHolder:
		if spot[1] == _pos and self != spot[0]:
			return false
	return true

func Move(_pos = Vector2()):
	timeSinceLastMove = 0
	position = _pos









#COMPLETE
#return [[true, particleType] if hit, [false] if no hit
func CheckPos(_pos = Vector2(), _exclude = [self]):
	_point.position = _pos
	_point.exclude = _exclude
	
	var result = get_world_2d().direct_space_state.intersect_point(_point, 32)
	if result.size() > 0:
		#dont move
		return [result[0].collider , true]
	return [null , false]







func DebugDisplay():
	#print(CheckPos(position))
	if CheckPos(position):
		modulate = Color.BLACK
	elif timeSinceLastMove >= Global.MOVEBUFFER:
		modulate = Color.RED
	else:
		modulate = Color.YELLOW
		#modulate.h = rnd.randi_range(0, 66)
		#modulate.s = 100
		#modulate.v = 100
		
