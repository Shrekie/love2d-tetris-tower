physics = {}
physics.oneMeter = 20
physics.collision = {}
physics.collision.newContact = false
physics.collision.currentpiece = "User_square 0"
physics.collision.text = ""   -- we'll use this to put info text on the screen later
physics.collision.persisting = 0    -- we'll use this to store the state of repeated callback calls

function physics.load()
	love.physics.setMeter(physics.oneMeter) --the height of a meter our worlds will be 64px
	physics.world = love.physics.newWorld(0, 6.81*physics.oneMeter, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
	physics.world:setCallbacks(physics.beginContact, physics.endContact, physics.preSolve, physics.postSolve)
end

function physics.beginContact(a, b, coll)
    x,y = coll:getNormal()
    if a:getUserData() == physics.collision.currentpiece then
        a:setRestitution(0)
        a:getBody():setAngularVelocity(0)
        a:getBody():setLinearVelocity( 0, 0 )
    elseif b:getUserData() == physics.collision.currentpiece then
        b:setRestitution(0)
        b:getBody():setAngularVelocity(0)
        b:getBody():setLinearVelocity( 0, 0 )
    end
    physics.collision.text = physics.collision.text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y
end
 
function physics.endContact(a, b, coll)
    physics.collision.persisting = 0
    --a:setRestitution(0)
    --a:getBody():setAngularVelocity(0)
    --a:getBody():setLinearVelocity( 0, 0 )
    --b:setRestitution(0)
    --b:getBody():setAngularVelocity(0)
    --b:getBody():setLinearVelocity( 0, 0 )
    physics.collision.text = physics.collision.text.."\n"..a:getUserData().." uncolliding with "..b:getUserData()
end

function physics.preSolve(a, b, coll)

    if a:getUserData() == physics.collision.currentpiece then
    	physics.collision.newContact = true
        --a:setRestitution(0)
        --a:getBody():setAngularVelocity(0)
        --a:getBody():setLinearVelocity( 0, 0 )
    	physics.collision.text = physics.collision.text.."\n"..a:getUserData()
    elseif b:getUserData() == physics.collision.currentpiece then
    	physics.collision.newContact = true
        --b:setRestitution(0)
        --b:getBody():setAngularVelocity(0)
        --b:getBody():setLinearVelocity( 0, 0 )
    	physics.collision.text = physics.collision.text.."\n"..b:getUserData()
    end

end
 
function physics.postSolve(a, b, coll, normalimpulse, tangentimpulse)
    --a:setRestitution(0)
    --a:getBody():setAngularVelocity(0)
    --a:getBody():setLinearVelocity( 0, 0 )
    --b:setRestitution(0)
    --b:getBody():setAngularVelocity(0)
    --b:getBody():setLinearVelocity( 0, 0 )
end