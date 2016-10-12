player = {}
player.newPos = 0
player.restitution = 0
player.rotateDegrees = 0
player.dtotal = 0
player.move = false
player.currentShape = {}

function player.load()
	blockManager.generatePiece()
end

function player.update(dt)

	-- incremental movement
	player.dtotal = player.dtotal + dt
	if player.dtotal >= 0.08 then
		player.move = true
		player.dtotal = player.dtotal - 0.08
	else
		player.move	= false
	end

	if love.keyboard.isDown("d") and player.move == true  then --press the right arrow key to push the ball to the right
		player.controlMethod("right")
	elseif love.keyboard.isDown("a") and player.move == true then --press the left arrow key to push the ball to the left
		player.controlMethod("left")
	end

end

function player.controlMethod(command)

	if command == "right" then
		player.newPos=player.currentShape.body:getX() + (physics.oneMeter/1.91)
		if player.currentShape.type == "L" then
			player.currentShape.body:setX(player.newPos)
			player.currentShape.body2:setX(player.newPos)
		elseif player.currentShape.type == "I" or player.currentShape.type == "D" then
			player.currentShape.body:setX(player.newPos)
		end
	end

	if command == "left" then
		player.newPos=player.currentShape.body:getX() - (physics.oneMeter/1.91)
		if player.currentShape.type == "L" then
			player.currentShape.body:setX(player.newPos)
			player.currentShape.body2:setX(player.newPos)
		elseif player.currentShape.type == "I" or player.currentShape.type == "D" then
			player.currentShape.body:setX(player.newPos)
		end
	end

	if command == "rotate" then
		if player.currentShape.type == "L" then
			player.currentShape.body:setAngle(math.rad(player.rotateDegrees))
			player.currentShape.body2:setAngle(math.rad(player.rotateDegrees))
		end
		if player.currentShape.type == "I" then
			player.currentShape.body:setAngle(math.rad(player.rotateDegrees))
		end
	end

end

function love.keyreleased(key)

	if key == "space" then
		player.rotateDegrees = player.rotateDegrees + 90
		if player.rotateDegrees == 360 then
			player.rotateDegrees = 0
		end
		player.controlMethod("rotate")
	end

end

function player.newPiece(currentShape)
	player.currentShape.playerActive = false
	player.currentShape = currentShape
	player.currentShape.playerActive = true
	player.rotateDegrees = 0
	game.zoomAmount = 0
end