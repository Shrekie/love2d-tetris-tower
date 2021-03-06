blockManager = {}
blockManager.oldPieces = {}
blockManager.pieces = 0 -- amount of pieces on board
blockManager.pieceStructures = 3
blockManager.topspawnSpace = physics.oneMeter*10

function blockManager.shapeRandomizer()

	local ranPick = math.random(4)

	blockManager.newShape.color = {}
	blockManager.newShape.color[1] = math.random(255)
	blockManager.newShape.color[2] = math.random(255)
	blockManager.newShape.color[3] = math.random(255)

	blockManager.newShape.color[4] = blockManager.newShape.color[1] + 3
	blockManager.newShape.color[5] = blockManager.newShape.color[2] + 3
	blockManager.newShape.color[6] = blockManager.newShape.color[1] + 3

	if ranPick == 1 then

		-- L SHAPE
		blockManager.newShape.type = "L"
		blockManager.newShape.body2 = love.physics.newBody(physics.world, game.width/2, game.topspawn, "dynamic")
		blockManager.newShape.body2:setAngularDamping( 1 )
		blockManager.newShape.body2:setLinearDamping( 1 )
		blockManager.newShape.shape2 = love.physics.newRectangleShape(0,0, physics.oneMeter*3,physics.oneMeter)
		blockManager.newShape.fixture2 = love.physics.newFixture(blockManager.newShape.body2, blockManager.newShape.shape2, 5)
		blockManager.newShape.fixture2:setFriction(0.5)
		blockManager.newShape.fixture2:setRestitution(0)
		blockManager.newShape.fixture2:setDensity(0.4)
		blockManager.newShape.fixture2:setUserData("User_square "..blockManager.pieces)

		blockManager.newShape.body = love.physics.newBody(physics.world, game.width/2, game.topspawn, "dynamic")
		blockManager.newShape.body:setAngularDamping( 1 )
		blockManager.newShape.body:setLinearDamping( 1 )
		blockManager.newShape.shape = love.physics.newRectangleShape(physics.oneMeter*2,physics.oneMeter/2, physics.oneMeter,physics.oneMeter*2)
		blockManager.newShape.fixture = love.physics.newFixture(blockManager.newShape.body, blockManager.newShape.shape, 5)
		blockManager.newShape.fixture:setFriction(0.5)
		blockManager.newShape.fixture:setRestitution(0)
		blockManager.newShape.fixture:setDensity(0.4)
		blockManager.newShape.fixture:setUserData("User_square "..blockManager.pieces)

		blockManager.newShape.joint = love.physics.newWeldJoint( blockManager.newShape.body, blockManager.newShape.body2, 0, 0, false )

	elseif ranPick == 2 then

		-- I horizontal ledge SHAPE
		blockManager.newShape.type = "I"
		blockManager.newShape.body = love.physics.newBody(physics.world, game.width/2, game.topspawn, "dynamic")
		blockManager.newShape.body:setAngularDamping( 1 )
		blockManager.newShape.body:setLinearDamping( 1 )
		blockManager.newShape.shape = love.physics.newRectangleShape(0,0, physics.oneMeter*4,physics.oneMeter)
		blockManager.newShape.fixture = love.physics.newFixture(blockManager.newShape.body, blockManager.newShape.shape, 5)
		blockManager.newShape.fixture:setFriction(0.5)
		blockManager.newShape.fixture:setRestitution(0)
		blockManager.newShape.fixture:setDensity(0.4)
		blockManager.newShape.fixture:setUserData("User_square "..blockManager.pieces)

	elseif ranPick == 3 then

		-- I horizontal ledge SHAPE
		blockManager.newShape.type = "D"

		blockManager.newShape.body = love.physics.newBody(physics.world, game.width/2, game.topspawn, "dynamic")
		blockManager.newShape.body:setAngularDamping( 1 )
		blockManager.newShape.body:setLinearDamping( 1 )
		blockManager.newShape.shape = love.physics.newRectangleShape(0,0, physics.oneMeter*2,physics.oneMeter*2)
		blockManager.newShape.fixture = love.physics.newFixture(blockManager.newShape.body, blockManager.newShape.shape, 5)
		blockManager.newShape.fixture:setFriction(0.5)
		blockManager.newShape.fixture:setRestitution(0)
		blockManager.newShape.fixture:setDensity(0.4)
		blockManager.newShape.fixture:setUserData("User_square "..blockManager.pieces)

	

	elseif ranPick == 4 then

		-- I horizontal ledge SHAPE
		blockManager.newShape.type = "Z"

		blockManager.newShape.body = love.physics.newBody(physics.world, game.width/2, game.topspawn, "dynamic")
		blockManager.newShape.body:setAngularDamping( 1 )
		blockManager.newShape.body:setLinearDamping( 1 )
		blockManager.newShape.shape = love.physics.newRectangleShape(0,0, physics.oneMeter*2,physics.oneMeter)
		blockManager.newShape.fixture = love.physics.newFixture(blockManager.newShape.body, blockManager.newShape.shape, 5)
		blockManager.newShape.fixture:setFriction(0.5)
		blockManager.newShape.fixture:setRestitution(0)
		blockManager.newShape.fixture:setDensity(0.4)
		blockManager.newShape.fixture:setUserData("User_square "..blockManager.pieces)

		blockManager.newShape.body2 = love.physics.newBody(physics.world, game.width/2, game.topspawn, "dynamic")
		blockManager.newShape.body2:setAngularDamping( 1 )
		blockManager.newShape.body2:setLinearDamping( 1 )
		blockManager.newShape.shape2 = love.physics.newRectangleShape(physics.oneMeter,physics.oneMeter, physics.oneMeter*2,physics.oneMeter)
		blockManager.newShape.fixture2 = love.physics.newFixture(blockManager.newShape.body2, blockManager.newShape.shape2, 5)
		blockManager.newShape.fixture2:setFriction(0.5)
		blockManager.newShape.fixture2:setRestitution(0)
		blockManager.newShape.fixture2:setDensity(0.4)
		blockManager.newShape.fixture2:setUserData("User_square "..blockManager.pieces)

		blockManager.newShape.joint = love.physics.newWeldJoint( blockManager.newShape.body, blockManager.newShape.body2, 0, 0, false )

	end

end

-- draws shadow below shape
function blockManager.drawDropShadow(shape)

	love.graphics.setColor( 255, 255, 255, 50 )
	local firstBodyPoints = {shape.body:getWorldCenter()}

	if shape.type == "D" then
		love.graphics.setLineWidth(physics.oneMeter*2)
		love.graphics.line(firstBodyPoints[1],firstBodyPoints[2],firstBodyPoints[1],game.height)
	end

	if shape.type == "Z" then

		if player.rotateDegrees == 0 then
			love.graphics.setLineWidth(physics.oneMeter*3+2)
			love.graphics.line(firstBodyPoints[1]+(physics.oneMeter/2),firstBodyPoints[2],firstBodyPoints[1]+(physics.oneMeter/2),game.height)
		elseif player.rotateDegrees == 180 then
			love.graphics.setLineWidth(physics.oneMeter*3+2)
			love.graphics.line(firstBodyPoints[1]-(physics.oneMeter/2),firstBodyPoints[2],firstBodyPoints[1]-(physics.oneMeter/2),game.height)

		elseif player.rotateDegrees == 90 then
			love.graphics.setLineWidth(physics.oneMeter*2+2)
			love.graphics.line(firstBodyPoints[1]-(physics.oneMeter/2),firstBodyPoints[2],firstBodyPoints[1]-(physics.oneMeter/2),game.height)
		else
			love.graphics.setLineWidth(physics.oneMeter*2+2)
			love.graphics.line(firstBodyPoints[1]+(physics.oneMeter/2),firstBodyPoints[2],firstBodyPoints[1]+(physics.oneMeter/2),game.height)
		end

	end

	if shape.type == "I" then

		if (player.rotateDegrees == 0) or (player.rotateDegrees == 180) then
			love.graphics.setLineWidth(physics.oneMeter*4+2)
		else
			love.graphics.setLineWidth(physics.oneMeter+2)
		end

		love.graphics.line(firstBodyPoints[1],firstBodyPoints[2],firstBodyPoints[1],game.height)

	end

	if shape.type == "L" then

		if (player.rotateDegrees == 0) then

			love.graphics.setLineWidth(physics.oneMeter*4+2)
			love.graphics.line(((firstBodyPoints[1]-physics.oneMeter*2)+physics.oneMeter/2),
				firstBodyPoints[2],((firstBodyPoints[1]-physics.oneMeter*2)+physics.oneMeter/2),game.height)

		elseif player.rotateDegrees == 180 then

			love.graphics.setLineWidth(physics.oneMeter*4+2)
			love.graphics.line(((firstBodyPoints[1]+physics.oneMeter*2)-physics.oneMeter/2),
				firstBodyPoints[2],((firstBodyPoints[1]+physics.oneMeter*2)-physics.oneMeter/2),game.height)

		else
			love.graphics.setLineWidth(physics.oneMeter*2+2)
			love.graphics.line(firstBodyPoints[1],firstBodyPoints[2],firstBodyPoints[1],game.height)
		end
		

	end

end

function blockManager.drawBodies(thisShape)


	if thisShape.type == "L" or thisShape.type == "Z" then
		love.graphics.setColor(thisShape.color[1], thisShape.color[2], thisShape.color[3])
		love.graphics.polygon("fill", thisShape.body:getWorldPoints(thisShape.shape:getPoints()))
		love.graphics.setColor(thisShape.color[4], thisShape.color[5], thisShape.color[6])
		love.graphics.polygon("fill", thisShape.body2:getWorldPoints(thisShape.shape2:getPoints()))
	elseif thisShape.type == "I" or thisShape.type == "D" then
		love.graphics.setColor(thisShape.color[1], thisShape.color[2], thisShape.color[3])
		love.graphics.polygon("fill", thisShape.body:getWorldPoints(thisShape.shape:getPoints()))
	end

	if thisShape.playerActive == true then
		blockManager.drawDropShadow(thisShape)
	end


end

function blockManager.update()

	if physics.collision.newContact == true then
		blockManager.generatePiece()
	end

	blockManager.checkTopHeight()
	blockManager.checkDestroy()

end

function blockManager.drawNonPlayerPieces()
	love.graphics.setColor(193, 47, 14)
	for i,v in ipairs(blockManager.oldPieces) do
		blockManager.drawBodies(v)
	end
end

function blockManager.checkDestroy()
	for i,v in ipairs(blockManager.oldPieces) do
		if v.body:getY() > (game.height + 30) then
			if v.playerActive == true then
				blockManager.generatePiece()
			end
		table.remove(blockManager.oldPieces, i)
		end
	end
end

function blockManager.checkTopHeight()
	-- Renews game.topspawn to highest piece height
	for i,v in ipairs(blockManager.oldPieces) do

		if v.body:getY() < (game.highest + blockManager.topspawnSpace) then
			game.highest = v.body:getY()
			game.topspawn = (game.highest - blockManager.topspawnSpace)
			love.graphics.translate(0,game.topspawn)
		end
		
	end
end

function blockManager.generatePiece()

	-- Store piece
	-- Generate new piece
	blockManager.pieces = blockManager.pieces + 1
	blockManager.newShape = {}
	blockManager.shapeRandomizer()
	player.newPiece(blockManager.newShape)
	physics.collision.currentpiece = "User_square "..blockManager.pieces
	physics.collision.newContact = false
	table.insert(blockManager.oldPieces,blockManager.newShape)

end