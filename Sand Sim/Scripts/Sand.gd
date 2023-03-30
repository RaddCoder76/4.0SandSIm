extends "res://Scenes/Particles/Particle.gd"



func PickColor():
	var rnd = RandomNumberGenerator.new()
	rnd.randomize()
	modulate = Color.WHITE
	modulate.g8 = rnd.randi_range(100, 150)
	

func Move(_pos : Vector2):
	tick = 0
	moveSpeed += 1
	ActivateSurrondingParticles(global_position)
	G.AddToSpotList(self, _pos)
	G.AddToActiveParticles(self)
	didIMove = true
	global_position = _pos
	await get_tree().create_timer(.01).timeout
	G.RemoveFromSpotList(self, _pos)

func Update():
	isActive = false
	if CANMOVE:
		tick += 1
		didIMove = false
		#G.AddToActiveParticles(self)
		
		var res = GetPos(Vector2(global_position.x, global_position.y + G.SIZE))
		if res != null and res.particleType == "Water":
			res.Move(global_position)
			Move(Vector2(global_position.x, global_position.y + G.SIZE))
			return
		
		res = GetPos(Vector2(global_position.x - G.SIZE, global_position.y + G.SIZE))
		if res != null and res.particleType == "Water":
			res.Move(global_position)
			Move(Vector2(global_position.x-G.SIZE, global_position.y + G.SIZE))
			return
		
		res = GetPos(Vector2(global_position.x + G.SIZE, global_position.y + G.SIZE))
		if res != null and res.particleType == "Water":
			res.Move(global_position)
			Move(Vector2(global_position.x+G.SIZE, global_position.y + G.SIZE))
			return
		
		
		
		var _downPos = GetAvaiblePositionsInDirection(Vector2(0,1), 1) # [null/collider, pos]
		
		if _downPos.size() > 0:
			var finalPos = G.GetFinalPos(_downPos)
			
			if finalPos != null:
				Move(finalPos)
				return
		
		var _leftPos = GetAvaiblePositionsInDirection(Vector2(-1,1), 1) # [null/collider, pos]
		var _rightPos = GetAvaiblePositionsInDirection(Vector2(1,1), 1) # [null/collider, pos]
		
		var leftPos
		if _leftPos.size() > 0:
			leftPos = G.GetFinalPos(_leftPos)
		var rightPos
		if _rightPos.size() > 0:
			rightPos = G.GetFinalPos(_rightPos)
		
		if leftPos != null and rightPos != null:
			rnd.randomize()
			if rnd.randi_range(0,1):
				Move(leftPos)
				return
			else:
				Move(rightPos)
				return
		
		if leftPos != null:
			Move(leftPos)
			return
		if rightPos != null:
			Move(rightPos)
			return
		
	#	if tick < lifeTime:
	#		G.AddToActiveParticles(self)
	#		return
		moveSpeed = 1
