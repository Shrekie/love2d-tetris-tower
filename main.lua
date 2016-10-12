require "physics"
require "platform"
require "player"
require "blockManager"

game = {}
game.width = 600
game.height = 800

function love.load()
	physics.load()
	platform.load()
	player.load()
	love.graphics.setBackgroundColor(104, 136, 248) --set the background color to a nice blue
  	love.window.setMode(game.width, game.height) --set the window dimensions to 650 by 650
end

function love.update(dt)
	physics.world:update(dt)
	player.update(dt)
	if string.len(physics.collision.text) > 768 then    -- cleanup when 'text' gets too long
        physics.collision.text = ""
    end
    blockManager.update()
end

function love.draw()
	platform.draw()
	blockManager.drawNonPlayerPieces()
	love.graphics.print(physics.collision.text, 10, 10)
end