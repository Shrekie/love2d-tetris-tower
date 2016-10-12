player = {}
player.newPos = 0
player.restitution = 0
player.rotateDegrees = 0
player.currentShape = {}

function player.load()
	blockManager.generatePiece()
end

function player.update(dt)

	if love.keyboard.isDown("d") then --press the right arrow key to push the ball to the right
		player.controlMethod("right")
	elseif love.keyboard.isDown("a") then --press the left arrow key to push the ball to the left
		player.controlMethod("left")
	end

end

function player.controlMethod(command)

	if command == "right" then
		player.newPos=player.currentShape.body:getX() + 5
		if player.currentShape.type == "L" then
			player.currentShape.body:setX(player.newPos)
			player.currentShape.body2:setX(player.newPos)
		elseif player.currentShape.type == "I" then
			player.currentShape.body:setX(player.newPos)
		end
	end

	if command == "left" then
		player.newPos=player.currentShape.body:getX() - 5
		if player.currentShape.type == "L" then
			player.currentShape.body:setX(player.newPos)
			player.currentShape.body2:setX(player.newPos)
		elseif player.currentShape.type == "I" then
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
end