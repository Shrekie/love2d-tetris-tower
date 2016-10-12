platform = {}
platform.height = 50

function platform.load()

	platform.body = love.physics.newBody(physics.world, game.width/2, game.height-50/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
	platform.shape = love.physics.newRectangleShape(game.width/4, platform.height) --make a rectangle with a width of 650 and a height of 50
	platform.fixture = love.physics.newFixture(platform.body, platform.shape) --attach shape to body
	platform.fixture:setRestitution(0)
	platform.fixture:setUserData("Ground")

end

function platform.draw()
	love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
	love.graphics.polygon("fill", platform.body:getWorldPoints(platform.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
end