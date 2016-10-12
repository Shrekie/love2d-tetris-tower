require "physics"
require "platform"
require "player"
require "blockManager"
require "camera"

game = {}
game.width = 600
game.height = 800

function love.load()
	physics.load()
	platform.load()
	player.load()
	love.graphics.setBackgroundColor(104, 136, 248) --set the background color to a nice blue
  	love.window.setMode(game.width, game.height) --set the window dimensions to 650 by 650
  	camera:scale(1)
end

function love.update(dt)

	physics.world:update(dt)
	player.update(dt)
	if string.len(physics.collision.text) > 768 then    -- cleanup when 'text' gets too long
        physics.collision.text = ""
    end
    blockManager.update()

   	--[[

	y-axis camera follow - test
	
   	game.dtotal = game.dtotal + dt
	if game.dtotal >= 0.01 then
		game.zoomAmount = game.zoomAmount + 1.3
		game.dtotal = game.dtotal - 0.01
	else
	
	end
	camera.y = ((player.currentShape.body:getY() - 20)-game.zoomAmount)

	--]]

    camera.x = player.currentShape.body:getX() - game.width/2
end

function love.draw()
	camera:set()
	platform.draw()
	blockManager.drawNonPlayerPieces()
	love.graphics.print(physics.collision.text, 10, 10)
	camera:unset()
end