require "physics"
require "platform"
require "player"
require "blockManager"
require "camera"

game = {}
game.score = 0
game.width = 400
game.height = 600
game.topspawn = game.height/2
game.highest = game.topspawn
game.textPos = {}

function game.cameraMovement()

	if game.textPos.x ~= player.currentShape.body:getX()/4 then
		if game.textPos.x < player.currentShape.body:getX()/4 then
			game.textPos.x = game.textPos.x + 0.5

		elseif game.textPos.x > player.currentShape.body:getX()/4 then
			game.textPos.x = game.textPos.x - 0.5
		end
	end

	if game.textPos.y ~= camera.y+100 then
		if game.textPos.y < camera.y+100 then
			game.textPos.y = game.textPos.y + 0.5

		elseif game.textPos.y > camera.y+100 then
			game.textPos.y = game.textPos.y - 0.5
		end
	end

	if camera.y ~= game.highest - blockManager.topspawnSpace then
		if camera.y + 100 < (game.highest - blockManager.topspawnSpace) then
			camera.y = camera.y + 1
			love.graphics.setColor(200,100,100)

		elseif camera.y - 100 > (game.highest - blockManager.topspawnSpace) then
			camera.y = camera.y - 1
			love.graphics.setColor(100,200,100)
		end
	else
		love.graphics.setColor(100,100,100)
	end

	if camera.x ~= player.currentShape.body:getX() - game.width/2 then
		if camera.x + 30 < (player.currentShape.body:getX() - game.width/2) then
			camera.x = camera.x + 1
		elseif camera.x - 30 > (player.currentShape.body:getX() - game.width/2) then
			camera.x = camera.x - 1
		end
	end

end

function love.load()
	font = love.graphics.newFont(15)
	love.graphics.setFont(font)
	physics.load()
	platform.load()
	player.load()
	love.graphics.setBackgroundColor(70, 70, 230,50)
  	love.window.setMode(game.width, game.height)
  	
  	game.textPos.x = player.currentShape.body:getX()/4
    game.textPos.y = camera.y+100 

  	camera:scale(1)
end

function love.update(dt)

	--game score move
	if game.score > game.topspawn then
		game.score = game.topspawn
	end

	physics.world:update(dt)
	player.update(dt)
    blockManager.update()
    game.cameraMovement()
end

function love.draw()
	camera:set()
	love.graphics.print((-1*math.floor(game.score)) , game.textPos.x, game.textPos.y)
	platform.draw()
	blockManager.drawNonPlayerPieces()
    camera:unset()
end