blockManager = {}
blockManager.oldPieces = {}
blockManager.pieces = 0 -- amount of pieces on board
blockManager.pieceStructures = 2

function blockManager.shapeRandomizer()
	ranPick = math.random(2)

	if ranPick == 1 then

		-- L SHAPE
		blockManager.newShape.type = "L"
		blockManager.newShape.body2 = love.physics.newBody(physics.world, game.width/2, 0, "dynamic")
		blockManager.newShape.body2:setAngularDamping( 1 )
		blockManager.newShape.body2:setLinearDamping( 1 )
		blockManager.newShape.shape2 = love.physics.newRectangleShape(0,0, physics.oneMeter*3,physics.oneMeter)
		blockManager.newShape.fixture2 = love.physics.newFixture(blockManager.newShape.body2, blockManager.newShape.shape2, 5)
		blockManager.newShape.fixture2:setFriction(1)
		blockManager.newShape.fixture2:setRestitution(0)
		blockManager.newShape.fixture2:setDensity(0.6)
		blockManager.newShape.fixture2:setUserData("User_square "..blockManager.pieces)

		blockManager.newShape.body = love.physics.newBody(physics.world, game.width/2, 0, "dynamic")
		blockManager.newShape.body:setAngularDamping( 1 )
		blockManager.newShape.body:setLinearDamping( 1 )
		blockManager.newShape.shape = love.physics.newRectangleShape(physics.oneMeter*2,physics.oneMeter/2, physics.oneMeter,physics.oneMeter*2)
		blockManager.newShape.fixture = love.physics.newFixture(blockManager.newShape.body, blockManager.newShape.shape, 5)
		blockManager.newShape.fixture:setFriction(1)
		blockManager.newShape.fixture:setRestitution(0)
		blockManager.newShape.fixture:setDensity(0.6)
		blockManager.newShape.fixture:setUserData("User_square "..blockManager.pieces)

		blockManager.newShape.joint = love.physics.newWeldJoint( blockManager.newShape.body, blockManager.newShape.body2, 0, 0, false )

	elseif ranPick == 2 then

		-- I horizontal ledge SHAPE
		blockManager.newShape.type = "I"
		blockManager.newShape.body = love.physics.newBody(physics.world, game.width/2, 0, "dynamic")
		blockManager.newShape.body:setAngularDamping( 1 )
		blockManager.newShape.body:setLinearDamping( 1 )
		blockManager.newShape.shape = love.physics.newRectangleShape(0,0, physics.oneMeter*4,physics.oneMeter)
		blockManager.newShape.fixture = love.physics.newFixture(blockManager.newShape.body, blockManager.newShape.shape, 5)
		blockManager.newShape.fixture:setFriction(1)
		blockManager.newShape.fixture:setRestitution(0)
		blockManager.newShape.fixture:setDensity(0.6)
		blockManager.newShape.fixture:setUserData("User_square "..blockManager.pieces)

	end

end

-- draws shadow below shape
function blockManager.drawDropShadow(shape)

	love.graphics.setColor( 255, 255, 255, 50 )
	firstBodyPoints = {shape.body:getWorldCenter()}

	if shape.type == "I" then

		if (player.rotateDegrees == 0) or (player.rotateDegrees == 180) then
			love.graphics.setLineWidth(physics.oneMeter*4)
		else
			love.graphics.setLineWidth(physics.oneMeter)
		end

		love.graphics.line(firstBodyPoints[1],firstBodyPoints[2],firstBodyPoints[1],game.height)

	end

	if shape.type == "L" then

		if (player.rotateDegrees == 0) then
			love.graphics.setLineWidth(physics.oneMeter*4)
			love.graphics.line(((firstBodyPoints[1]-physics.oneMeter*2)+physics.oneMeter/2),firstBodyPoints[2],((firstBodyPoints[1]-physics.oneMeter*2)+physics.oneMeter/2),game.height)
		elseif player.rotateDegrees == 180 then
			love.graphics.setLineWidth(physics.oneMeter*4)
			love.graphics.line(((firstBodyPoints[1]+physics.oneMeter*2)-physics.oneMeter/2),firstBodyPoints[2],((firstBodyPoints[1]+physics.oneMeter*2)-physics.oneMeter/2),game.height)
		else
			love.graphics.setLineWidth(physics.oneMeter*2)
			love.graphics.line(firstBodyPoints[1],firstBodyPoints[2],firstBodyPoints[1],game.height)
		end
		

	end

end

function blockManager.drawBodies(thisShape)

	if thisShape.type == "L" then
		love.graphics.setColor(193, 47, 14)
		love.graphics.polygon("fill", thisShape.body:getWorldPoints(thisShape.shape:getPoints()))
		love.graphics.polygon("fill", thisShape.body2:getWorldPoints(thisShape.shape2:getPoints()))
	elseif thisShape.type == "I" then
		love.graphics.setColor(193, 47, 14)
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

end

function blockManager.drawNonPlayerPieces()
	love.graphics.setColor(193, 47, 14)
	for i,v in ipairs(blockManager.oldPieces) do
		blockManager.drawBodies(v)
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