extends "res://Scenes/Particles/Particle.gd"


func PickColor():
	var rnd = RandomNumberGenerator.new()
	rnd.randomize()
	
	modulate.g8 = rnd.randi_range(50, 100)

func Move(_pos : Vector2):
	tick = 0
	ActivateSurrondingParticles(global_position)
	G.AddToSpotList(self, _pos)
	G.AddToActiveParticles(self)
	didIMove = true
	global_position = _pos
	await get_tree().create_timer(.01).timeout
	G.RemoveFromSpotList(self, _pos)


var downTick = 0
func Update():
	isActive = false
	if CANMOVE:
		tick += 1
		didIMove = false
		#G.AddToActiveParticles(self)
		
		var _positions = GetAvaiblePositionsInDirection(Vector2(0,1), 1) # [null/collider, pos]
		
		if _positions.size() > 0:
			var finalPos = G.GetFinalPos(_positions)
			
			if finalPos != null:
				#downTick = 0
				Move(finalPos)
				downTick = 0
				return
		else:
			downTick += 1
		if downTick < 1000:
			var _leftPos = GetAvaiblePositionsInDirection(Vector2(-1,0), 1) # [null/collider, pos]
			var _downLeftPos = GetAvaiblePositionsInDirection(Vector2(-1,1), 2) # [null/collider, pos]
					
			var _rightPos = GetAvaiblePositionsInDirection(Vector2(1,0), 1) # [null/collider, pos]
			var _downRightPos = GetAvaiblePositionsInDirection(Vector2(1,1), 2) # [null/collider, pos]
				
			var leftPos
			if _leftPos.size() > 0:
				leftPos = G.GetFinalPos(_leftPos)
				
				
			var rightPos
			if _rightPos.size() > 0:
				rightPos = G.GetFinalPos(_rightPos)
				
				
				
			var downLeftPos
			if _downLeftPos.size() > 0:
				downLeftPos = G.GetFinalPos(_downLeftPos)
				
			var downRightPos
			if _downRightPos.size() > 0:
				downRightPos = G.GetFinalPos(_downRightPos)
				
				
			if leftPos != null and rightPos != null and downLeftPos != null and downRightPos != null:
				rnd.randomize()
				if rnd.randi_range(0,1):
					Move(downLeftPos)
					return
				else:
					Move(downRightPos)
					return
				
			if leftPos != null:
					Move(leftPos)
					return
			if rightPos != null:
				Move(rightPos)
				return

		
		
		
		
		#if tick < lifeTime:
		#	G.AddToActiveParticles(self)
