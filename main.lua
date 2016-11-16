require "physics"
require "platform"
require "player"
require "blockManager"
require "camera"

game = {}
game.score = "0"
game.width = 400
game.height = 600
game.topspawn = game.height/2
game.highest = game.topspawn

function game.cameraMovement()

	if camera.y ~= game.highest - blockManager.topspawnSpace then
		if camera.y < (game.highest - blockManager.topspawnSpace) then
			camera.y = camera.y + 1
		elseif camera.y > (game.highest - blockManager.topspawnSpace) then
			camera.y = camera.y - 1
		end
	end

	if camera.x ~= player.currentShape.body:getX() - game.width/2 then
		if camera.x < (player.currentShape.body:getX() - game.width/2) then
			camera.x = camera.x + 1
		elseif camera.x > (player.currentShape.body:getX() - game.width/2) then
			camera.x = camera.x - 1
		end
	end

end

function love.load()
	physics.load()
	platform.load()
	player.load()
	love.graphics.setBackgroundColor(104, 136, 248) --set the background color to a nice blue
  	love.window.setMode(game.width, game.height) 
  	camera:scale(1)
end

function love.update(dt)

	physics.world:update(dt)
	player.update(dt)
	if string.len(physics.collision.text) > 768 then    -- cleanup when 'text' gets too long
        physics.collision.text = ""
    end
    blockManager.update()
    game.cameraMovement()
end

function love.draw()
	camera:set()
	platform.draw()
	blockManager.drawNonPlayerPieces()
	love.graphics.print(game.score .. " score", player.currentShape.body:getX() - game.width/2 + 10, game.highest - (blockManager.topspawnSpace-10))
    camera:unset()
end