local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight



local physics = require("physics")
physics.start()
physics.setGravity(0,0)
--physics.setDrawMode( "hybrid" )

local normDeltaY
local normDeltaX
local count = 0
local charged = false
local velPlayer = 200
local flag = true
local obj
local texto
local player
local enemy
local joyTouching = false
local shoot=false


 --local bkg = display.newImage( "stripes.png", centerX, centerY ) 

--display.setDefault( "background", 3, 5, 5 )
local bkg = display.newImage( "ground.jpg", centerX, centerY )
texto = display.newText( "battle", display.contentCenterX + 300, 25, native.systemFontBold, 26 )
texto:setFillColor(0,0,0) 
textHp = display.newText( "10", display.contentCenterX - 100, 25, native.systemFontBold, 26 )
textHp2 = display.newText( "10", display.contentCenterX - 300 , 25, native.systemFontBold, 26 )

textYou = display.newText( "You:", display.contentCenterX - 150, 25, native.systemFontBold, 26 )
textEnemy = display.newText( "Enemy:", display.contentCenterX - 360 , 25, native.systemFontBold, 26 )   
textCharged = display.newText( "charged", display.contentCenterX + 100, 25, native.systemFontBold, 26 )
textCharged:setFillColor(0,0,0)
textHp:setFillColor(0,0,0)
textHp2:setFillColor(0,0,0)
textYou:setFillColor(0,0,0)
textEnemy:setFillColor(0,0,0)

 local borderBottom = display.newRect( 0, _H , _W*2 , 20 )
borderBottom:setFillColor( "black")    -- make invisible
physics.addBody( borderBottom, "static", borderBodyElement )


 --display.newRect( x, y, width, height ) 
  
local borderTop1 = display.newRect( 0, 0, _W*2 , 20 )
borderTop1:setFillColor( "black")    -- make invisible
physics.addBody( borderTop1, "static", borderBodyElement ) 

 
 local borderLeft = display.newRect( 0, 0, 20 , _H*2 )
borderLeft:setFillColor("black" )    -- make invisible
physics.addBody( borderLeft, "static", borderBodyElement )



local borderRight = display.newRect( _W , 20, 20, _H*2 )
borderRight:setFillColor("black")   -- make invisible
physics.addBody( borderRight, "static", borderBodyElement )



local box = display.newRect( centerX , centerY , 768, 500 )
box.strokeWidth = 4
box:setStrokeColor( 192/255, 192/255, 192/255 )
box.alpha=0.01



--upperY = box_spec
--lowerY = 
--upperX =
--lowerX =


 local joyClick2 = display.newCircle(80,550, 20)
 local joyClick = display.newCircle(80,550, 90)


 local joyClick3 = display.newCircle(880,550, 20)
 local joyClick4 = display.newCircle(880,550, 90)

 
joyClick.alpha=0.3
joyClick2.alpha=0.5
joyClick3.alpha=0.5
joyClick4.alpha=0.3

 local enemyClick = display.newCircle(100,100, 65)

 local enemy = display.newCircle(100,100, 35)
 
 --local enemy = display.newRect( 100 , 100 , 80, 80 )

 --physics.addBody( enemy , "dynamic", { density = 1.0 , friction = 0 , bounce = 0 , radius = 35 })
 physics.addBody( enemy , "dynamic" , { density = 0.5 , friction = 0 , bounce = 0} )
 enemy.isFixedRotation = true
 enemy:setFillColor(  0.8 )
 enemyClick:setFillColor(  1 )
 enemyClick.alpha = 0.01
 enemy.atacking=false
 enemy.hp=10
 enemy.name="inimigo"
 
print( centerY - box.height/2 )
print( _H - 70 )
print(centerX - box.width/2)
print( _W - 96 )
 



--local player = display.newRect( centerX, centerY, 30, 30 )
local player = display.newCircle(centerX,centerY, 25)
local youClick = display.newCircle(player.x,player.y, 65)
 physics.addBody( player , "dynamic", { density = 1.0 , friction = 0 , bounce = 0 , radius = 15 })
 player.isFixedRotation = true
 player:setFillColor( 0.2 )
 youClick:setFillColor( 0.9 )
 youClick.alpha = 0
 --youClick:setStrokeColor( 192/255, 192/255, 192/255 )
 --youClick.strokeWidth = 2
 player.atacking=false
 player.hp=10
 player.name="player"




local function onLocalCollision( self, event )
   
   if(event.phase =="began")then
   if(event.other.name=="inimigo")then
    print("col")
   if(enemy.atacking==true) then player.hp = player.hp-1 
   textHp.text= player.hp
   end
   if(player.atacking==true)then enemy.hp = enemy.hp-1
     textHp2.text= enemy.hp 
   end
   --if(player.atacking and inimigo.atacking) then 
     --if( math.abs(player.getLinearVelocity))


        --end

end
end
end


local function onLocalCollision2( self, event )
   
   if(event.phase =="began")then


  display.remove(self)


   end
end


 
 
 
 ----- Listener --------



function playerLaunched(event)

if(charged)then
 if ( event.phase=="began" or event.phase == "moved" ) then
 flag = false	
 -- Tentar isso tambem if(event.phase == "began" or event.phase == "moved") then
 
 display.getCurrentStage():setFocus(player)
 player:setLinearVelocity(0,0)
 
 elseif event.phase == "ended" then

 obj = display.newCircle(player.x,player.y, 15)
 obj:setFillColor( 0.5 )
 physics.addBody( obj , "dinamic", { density = 1.0 , friction = 0 , bounce = 0 , radius = 15 })

 obj:applyLinearImpulse(((event.xStart - event.x)/10) , ((event.yStart - event.y)/10 ) , obj.x , obj.y )

timer.performWithDelay(1000, function()

display.remove(obj) end  , 1 )

 flag=true
 display.getCurrentStage():setFocus(nil)
 textCharged:setFillColor( 0 , 0, 0 )
 charged=false



 
 end

end
end




 local function screenTouch( event )
  if (event.phase == "began") then
  if(joyTouching==false)then
    speed = 500
    raio = 16
    raioy= 16
    if(event.x>player.x)then     raio=16            end
    if(event.x<player.x)then     raio=-16           end
    if(event.y>player.x)then     raioy=16            end
    if(event.y<player.x)then     raioy=-16           end

deltaX = event.x - player.x
deltaY = event.y - player.y
normDeltaX = deltaX / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
normDeltaY = deltaY / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))

    -- sin, cos = math.sin( angle ), math.cos( angle )

    -- sinT.text = sin
    -- cosT.text = cos
    

    bullet = display.newRect( 0, 0, 6, 6 )
    
    bullet.x = player.x+raio
    bullet.y = player.y+raioy
    

    physics.addBody( bullet )
    
    print(normDeltaX)
    print(normDeltaY)
    

    bullet:setLinearVelocity( normDeltaX  * speed, normDeltaY  * speed )
    bullet.collision = onLocalCollision2
    bullet:addEventListener( "collision", bullet )  
     -- bullet:setLinearVelocity( 100 , 0 )
     
  end
  end
end

local function screenTouch2( event )
 if (event.phase == "began") then
  shoot = true
    speed = 500
    raio = 16
    raioy= 16
    if(event.x>joyClick.x)then     raio=16            end
    if(event.x<joyClick.x)then     raio=-16           end
    if(event.y>joyClick.x)then     raioy=16            end
    if(event.y<joyClick.x)then     raioy=-16           end

deltaX = event.x - joyClick.x
deltaY = event.y - joyClick.y
normDeltaX = deltaX / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
normDeltaY = deltaY / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))

    -- sin, cos = math.sin( angle ), math.cos( angle )

    -- sinT.text = sin
    -- cosT.text = cos
    

    bullet = display.newRect( 0, 0, 6, 6 )
    
    bullet.x = player.x+raio
    bullet.y = player.y+raioy
    

    physics.addBody( bullet )
    
    print(normDeltaX)
    print(normDeltaY)
    

    bullet:setLinearVelocity( normDeltaX  * speed, normDeltaY  * speed )
    bullet.collision = onLocalCollision2
    bullet:addEventListener( "collision", bullet )  
     -- bullet:setLinearVelocity( 100 , 0 )
     
  end

if ( event.phase=="ended")then

shoot=false

end

  
end


local function screenTouch3( event )
 
   if (event.phase == "began") then
  shoot = true
    speed = 500
    raio = 16
    raioy= 16
    if(event.x>joyClick4.x)then     raio=16            end
    if(event.x<joyClick4.x)then     raio=-16           end
    if(event.y>joyClick4.x)then     raioy=16            end
    if(event.y<joyClick4.x)then     raioy=-16           end

deltaX = event.x - joyClick4.x
deltaY = event.y - joyClick4.y
normDeltaX = deltaX / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
normDeltaY = deltaY / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))

    -- sin, cos = math.sin( angle ), math.cos( angle )

    -- sinT.text = sin
    -- cosT.text = cos
    

    bullet = display.newRect( 0, 0, 6, 6 )
    
    bullet.x = player.x+raio
    bullet.y = player.y+raioy
    

    physics.addBody( bullet )
    
    print(normDeltaX)
    print(normDeltaY)
    

    bullet:setLinearVelocity( normDeltaX  * speed, normDeltaY  * speed )
    bullet.collision = onLocalCollision2
    bullet:addEventListener( "collision", bullet )  
     -- bullet:setLinearVelocity( 100 , 0 )
     
  end


  if ( event.phase=="ended")then

shoot=false

end

end



	


function touch1(event)

if(event.phase=="began")then
joyTouching=true
deltaX = event.xStart - joyClick2.x
deltaY = event.yStart - joyClick2.y
dx = deltaX / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
dy = deltaY / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
--player:applyForce(  dx *2000,  dy *2000, player.x , player.y )
--player:applyLinearImpulse(  dx * 20 ,  dy *20 , player.x , player.y )
player:setLinearVelocity(dx * 200 ,  dy * 200 )



end

if ( event.phase=="ended")then

joyTouching=false

end



end 



function touch2(event)

if(event.phase=="began")then
if(shoot==false)then
deltaX = event.xStart - player.x
deltaY = event.yStart - player.y
dx = deltaX / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
dy = deltaY / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
--player:applyForce(  dx *2000,  dy *2000, player.x , player.y )
--player:applyLinearImpulse(  dx * 20 ,  dy *20 , player.x , player.y )
player:setLinearVelocity(dx * 200 ,  dy * 200 )



end
end


end 





function enemyTouch(event)
if(event.phase=="began")then
deltaX = enemy.x - player.x
deltaY = enemy.y - player.y
dx = deltaX / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
dy = deltaY / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
--player:applyForce(  dx *2000,  dy *2000, player.x , player.y )
player:applyLinearImpulse(  dx * 150 ,  dy *150 , player.x , player.y )
--player:applyForce(  dx *1000,  dy *1000, player.x , player.y )

 player.atacking=true
 enemy.atacking=false
 timer.performWithDelay(600,function()

 	player.atacking=false
  

 end , 1 )


end

end	



 
 function playerMove(event)
 


if ( event.phase=="began")then
--[[
if(flag)then
deltaX = event.x - player.x
deltaY = event.y - player.y
normDeltaX = deltaX / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
normDeltaY = deltaY / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
--]]
player:setLinearVelocity( 0 , 0 ) 

--player:setLinearVelocity( normDeltaX  * velPlayer, normDeltaY  * velPlayer )

end


end
 
   
  
 
 
 
function update()
 

 
 enemy:applyLinearImpulse( normDeltaX * math.random(88,158) , normDeltaY * math.random(88,158)  , enemy.x , enemy.y)
 --enemy:setLinearVelocity( normDeltaX * 50 , normDeltaY *50 )
 --enemy:applyForce(  normDeltaX *2000,  normDeltaY *2000, enemy.x , enemy.y )

 enemy.atacking=true
 player.atacking=false
 timer.performWithDelay(600,function()
 	
 	enemy.atacking=false

 end , 1 )
 


--if(enemy.x==player.x)then enemy:setLinearVelocity(0,0)end
--if(enemy.y==player.y)then enemy:setLinearVelocity(0,0)end

  
  
 end

function update2()

enemyClick.x=enemy.x
enemyClick.y=enemy.y
youClick.x=player.x
youClick.y=player.y
if(enemy.x>864-70)then enemy:applyLinearImpulse( -15 , 0 , enemy.x , enemy.y ) end
if(enemy.x<96+70)then enemy:applyLinearImpulse(  15 , 0 , enemy.x , enemy.y ) end
if(enemy.y>570-70)then enemy:applyLinearImpulse( 0 , -15 , enemy.x , enemy.y ) end
if(enemy.y<70+70)then enemy:applyLinearImpulse(  0 , 15 , enemy.x , enemy.y ) end

 end 




function intoRadius()




end	

 
 local function calcule()
 

 if(player.atacking==true)then texto.text="you atacking" 
  	
 end
  if(enemy.atacking==true)then texto.text="enemy atacking"
  
end
if(enemy.atacking==false and player.atacking==false)then texto.text="none atacking" end


 deltaX = player.x - enemy.x
deltaY = player.y - enemy.y
normDeltaX = deltaX / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
normDeltaY = deltaY / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
 
 end
 
 
function charging()

count = count + 1
if(count==5)then
charged=true
textCharged:setFillColor( 1 , 1, 1 )
count=0
end


end	

function stop()

enemy:setLinearVelocity(0,0)

end	

function para()

player:setLinearVelocity(0,0)

end 
 
function para1()

player:setLinearVelocity(0,0)

end  
 
 

function twoTap( event )
 if (event.numTaps == 2 ) then
 print( "The object was double-tapped." )

deltaX = event.x - player.x
deltaY = event.y - player.y
dx = deltaX / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
dy = deltaY / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
--player:applyForce(  dx *2000,  dy *2000, player.x , player.y )
player:applyLinearImpulse(  dx * 30,  dy *30 , player.x , player.y )

 return true;
 elseif (event.numTaps == 1 ) then
 print("The object was tapped once.")
 end
 end
 
function twoTapStop( event )
 if (event.numTaps == 2 ) then
 print( "The object was double-tapped." )

player:setLinearVelocity(0,0)

 return true;
 elseif (event.numTaps == 1 ) then
 print("The object was tapped once.")
 end
 end



player.collision = onLocalCollision
player:addEventListener( "collision", player )  
--youClick:addEventListener("touch", playerMove )
--Runtime:addEventListener( "tap" , twoTapStop )

  
 --timer.performWithDelay( 100 , funcao , -1 )
 --player:addEventListener("touch", playerLaunched )
 --charge = timer.performWithDelay(700 ,charging , -1)
 --enemyClick:addEventListener("touch", enemyTouch )

 Runtime:addEventListener( "touch", touch2 )
 joyClick:addEventListener("touch", screenTouch2 )
 joyClick2:addEventListener("touch", para )
 joyClick3:addEventListener("touch", para1)
 joyClick4:addEventListener("touch", screenTouch3)

 --Runtime:addEventListener( "touch" , enemyTouch2 ) 
 --timer.performWithDelay( 1900 , update , -1 )
 --timer.performWithDelay( 1 , update2 , -1 )
 --timer.performWithDelay( 1 , calcule , -1 )
 --timer.performWithDelay(1500,stop,-1)

 
 
 
 
 
 
 