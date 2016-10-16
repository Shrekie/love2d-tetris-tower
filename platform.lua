platform = {}
platform.height = 50

function platform.load()

	platform.body = love.physics.newBody(physics.world, game.width/2, game.height-50/2)
	platform.shape = love.physics.newRectangleShape(physics.oneMeter*6, platform.height) 
	platform.fixture = love.physics.newFixture(platform.body, platform.shape) 
	platform.fixture:setRestitution(0)
	platform.fixture:setUserData("Ground")

end

function platform.draw()
	love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
	love.graphics.polygon("fill", platform.body:getWorldPoints(platform.shape:getPoints()))
end