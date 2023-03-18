extends Area2D

var G

#CONSTANT VARS 
@export var CANMOVE = true
@export var moveSpeed = 1

var rnd = RandomNumberGenerator.new()

# position = Vector2(), exclude = [], collision_mask = 4294967295, collide_with_bodies/areas = false/true, 


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ INPUT DIRECTION LIST AND TYPE @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
@export  var particleType = "Sand"
var didIMove = false
######################################################################################################################################################################################################

func _ready():
	G = get_tree().current_scene.get_node(".")
	#await get_tree().create_timer(.01).timeout
	if CANMOVE:
		add_to_group("P")
		G.AddToActiveParticles(self)




#@export var lifeTime : int = 20
#var tick = 0
func _process(delta):
	DebugColor()

func Update():
	if CANMOVE:
		didIMove = false
		#G.AddToActiveParticles(self)
		
		var _positions = GetAvaiblePositionsInDirection(Vector2(0,1), 1) # [null/collider, pos]
		
		if _positions.size() > 0:
			var finalPos = G.GetFinalPos(_positions)
			
			if finalPos != null:
				Move(finalPos)
				return
		
		#G.AddToActiveParticles(self)

	
func Move(_pos : Vector2):
	G.AddToSpotList(self, _pos)
	CheckAround()
	G.AddToActiveParticles(self)
	didIMove = true
	global_position = _pos
	await get_tree().create_timer(.01).timeout
	G.RemoveFromSpotList(self, _pos)



#COMPLETE
# return a [] that holds emptys Vectors positions in directions
func GetAvaiblePositionsInDirection(_dir : Vector2, _strength : int) -> Array:
	var _return = []
	for _s in _strength:
		var _pos = global_position + ((_dir * G.SIZE) * (_s + 1))
		
		var _result = CheckPos(_pos) # bool
		if _result == true: #no hit
			_return.append(_pos)
		else:
			return _return
	#print("pos that work " + str(_return))
	return _return
	



# COMPLETE	
#return [null/collider, pos]
func CheckPos(_position = Vector2(), _excludeList = [self], _limit = 1) -> bool:
	var _point = PhysicsPointQueryParameters2D.new()
	_point.exclude = _excludeList
	_point.position = _position
	
	##_point.collision_mask = 0
	
	_point.collide_with_areas = true
	
	var _result = get_world_2d().direct_space_state.intersect_point(_point, _limit)

	if _result.size() > 0:
		return false
	return true

func GetPos(_pos):
	var _point = PhysicsPointQueryParameters2D.new()
	_point.exclude = [self]
	_point.position = _pos
	#_point.collision_mask = 0
	_point.collide_with_areas = true
	
	var _result = get_world_2d().direct_space_state.intersect_point(_point, 1)
	
	if _result.size() > 0:
		return _result[0].collider
	return null
	

# COMPLETE
func DebugColor():
	if CheckPos(global_position):
		modulate = Color.BLACK
	elif !didIMove:
		modulate = Color.RED
	else:
		modulate = Color.CORAL


func CheckAround():
	$ParticleDetector/CollisionShape2D.disabled = true
	await  get_tree().create_timer(1).timeout
	$ParticleDetector/CollisionShape2D.disabled = false
	

