
function on.enterKey()
	inGame = true
	platform.window:invalidate()
end

function on.escapeKey()
	bullets = bullets-1
	shoot = true
	animation=1
	platform.window:invalidate()
end

function on.charIn(ch) 
	if ch=="r" then
		inGame = false
		death = false
		platform.window:invalidate()
	elseif ch=="8" then
		if offsetD~=99 then
			fuel = fuel - .5
			starup=true
			offsetD=offsetD+9
		end
	elseif ch=="2" then		
		if offsetD>-100 then
			fuel = fuel - .5
			stardown=true
			offsetD=offsetD-9
		end
	elseif ch=="4" then
		if 140>offsetR then
			fuel = fuel - .5
			starleft=true
			offsetR=offsetR+9
		end
	elseif ch=="6" then
		if offsetR>-140 then
			fuel = fuel - .5
			starright=true
			offsetR=offsetR-9
		end
	elseif ch=="7" then
		if offsetD~=99 and 140>offsetR then
			fuel = fuel - .5
			starup=true
			starleft=true
			offsetD=offsetD+9
			offsetR=offsetR+9
		end
	elseif ch=="9" then
		if offsetD~=99 and offsetR>-140 then
			fuel = fuel - .5
			starup=true
			starright=true
			offsetD=offsetD+9
			offsetR=offsetR-9
		end
	elseif ch=="1" then
		if offsetD>-100 and 140>offsetR then
			fuel = fuel - .5
			stardown=true
			starleft=true
			offsetD=offsetD-9
			offsetR=offsetR+9
		end
	elseif ch=="3" then
		if offsetD>-100 and offsetR>-140 then
			fuel = fuel - .5
			stardown=true
			starright=true
			offsetD=offsetD-9
			offsetR=offsetR-9
		end
	elseif ch=="5" then
		bullets = bullets-1
		shoot = true
		animation=1
		platform.window:invalidate()
	end
end

function on.timer()
	timer.stop()
	platform.window:invalidate()
end

function on.arrowKey(key)
	if key=="right" then
		if offsetR>-140 then
			fuel = fuel - .5
			starright=true
			offsetR=offsetR-9
		end
	elseif key=="left" then	
		if 140>offsetR then
			fuel = fuel - .5
			starleft=true
			offsetR=offsetR+9
		end
	elseif key=="up" then
		if offsetD~=99 then
			fuel = fuel - .5
			starup=true
			offsetD=offsetD+9
		end
	elseif key=="down" then	
		if offsetD>-100 then
			fuel = fuel - .5
			stardown=true
			offsetD=offsetD-9
		end
	end
	platform.window:invalidate()
end

function on.paint(gc)


	if health==0 then
		lives = lives-1
		health = 100
	end
	
	theController()

	gc:fillRect(0,0,318,212)
	gc:setColorRGB(255,255,255)
	
	


	if inGame==true then
		
		gc:drawPolyLine({-5+offsetR,-10+offsetD, 325+offsetR,-10+offsetD, 325+offsetR,227+offsetD, -5+offsetR,227+offsetD, -5+offsetR,-10+offsetD})
		
		if shield>0 then
			diameter = 40
			gc:drawArc(159 - diameter/2, 106 - diameter/2, diameter,diameter,0,360)

		end
		
		if shoot==true then
			if animation==1 then
				lifeHit = false
				shieldHit = false
				fuelHit=false
				BulletHit = false
				enemyHit = false
				gc:fillRect(157,104,6,6)
				animation = animation+1
				if generateLife==true and fireposX-offsetR>heartx-9 and heartx+18>fireposX-offsetR and fireposY-offsetD>hearty-9 and hearty+18>fireposY-offsetD then
					lifeHit = true
				end
				if generatefuel==true and fireposX-offsetR>fuelx-9 and fuelx+18>fireposX-offsetR and fireposY-offsetD>fuely-9 and fuely+18>fireposY-offsetD then
					fuelHit=true
				end
				if generatefuel2==true and fireposX-offsetR>fuelx2-9 and fuelx2+18>fireposX-offsetR and fireposY-offsetD>fuely2-9 and fuely2+18>fireposY-offsetD then
					fuelHit2=true
				end
				if generateBullet==true and fireposX-offsetR>bulletx-9 and bulletx+18>fireposX-offsetR and fireposY-offsetD>bullety-9 and bullety+18>fireposY-offsetD then
					BulletHit=true
				end
				if generateEnemy==true and fireposX-offsetR>Enemy1xcoord-9 and Enemy1xcoord+18>fireposX-offsetR and fireposY-offsetD>Enemy1ycoord-9 and Enemy1ycoord+18>fireposY-offsetD then
					enemyHit=true
				end
				if generateShield==true and fireposX-offsetR>shieldx-9 and shieldx+18>fireposX-offsetR and fireposY-offsetD>shieldy-9 and shieldy+18>fireposY-offsetD then
					shieldHit=true
				end
			elseif animation==2 then
				animation = animation+1
				gc:fillRect(156,101,3,3)
				gc:fillRect(156,107,3,3)
				gc:fillRect(158,102,3,3)
				gc:fillRect(158,109,3,3)
			elseif animation==3 then
				animation = animation+1
				gc:fillRect(155,103,3,3)
				gc:fillRect(156,106,3,3)
				gc:fillRect(159,107,3,3)
				gc:fillRect(157,105,3,3)
			elseif animation==4 then
				animation = animation+1
				gc:fillRect(153,105,3,3)
				gc:fillRect(154,104,3,3)
				gc:fillRect(159,109,3,3)
				gc:fillRect(158,101,3,3)
			elseif animation==5 then
				gc:fillRect(154,105,3,3)
				gc:fillRect(156,102,3,3)
				gc:fillRect(159,107,3,3)
				gc:fillRect(158,104,3,3)
				shoot=false
				if lifeHit == true then
					if 9>lives then
						lives = lives + 1
					else
						health = 100
					end
					pts=pts+20
					generateLife=false
					needResource = needResource - 1
				end
				if fuelHit == true then
					generatefuel=false
					needResource = needResource - 1
					pts=pts+10
					fuel = 100
				end
				if fuelHit2 == true then
					generatefuel2=false
					needResource = needResource - 1
					pts=pts+10
					fuel = 100
				end
				if BulletHit == true then
					generateBullet=false
					needResource = needResource - 1
					pts=pts+10
					bullets = bullets + 5
				end
				if enemyHit == true then
					generateEnemy=false
					needEnemy = true
					pts=pts+100
				end
				if shieldHit == true then
					pts=pts+50
					needResource = needResource - 1
					generateShield = false
					shield = shield + 2
				end
			end	
		end


		if showFire>0 and enemyHit==false then						--The line that is drawn when an enemy shoots
			gc:drawLine(Enemy1xcoord+offsetR,Enemy1ycoord+offsetD,159,106)
			showFire = showFire-1		
		end		

		gc:fillRect(1+offsetR,1+offsetD,4,4)
		gc:fillRect(10+offsetR,15+offsetD,4,4)
		gc:fillRect(4+offsetR,156+offsetD,4,4)
		gc:fillRect(54+offsetR,54+offsetD,4,4)
		gc:fillRect(45+offsetR,146+offsetD,4,4)
		gc:fillRect(200+offsetR,132+offsetD,4,4)
		gc:fillRect(285+offsetR,23+offsetD,4,4)
		gc:fillRect(147+offsetR,164+offsetD,4,4)
		gc:fillRect(184+offsetR,137+offsetD,4,4)
		gc:fillRect(92+offsetR,72+offsetD,4,4)
		gc:fillRect(72+offsetR,169+offsetD,4,4)
		gc:fillRect(172+offsetR,53+offsetD,4,4)
		gc:fillRect(300+offsetR,84+offsetD,4,4)
		gc:fillRect(314+offsetR,138+offsetD,4,4)
		gc:fillRect(121+offsetR,37+offsetD,4,4)
		gc:fillRect(53+offsetR,92+offsetD,4,4)
		gc:fillRect(191+offsetR,96+offsetD,4,4)
		gc:fillRect(142+offsetR,143+offsetD,4,4)
		gc:fillRect(1+offsetR,172+offsetD,4,4)
		gc:fillRect(217+offsetR,89+offsetD,4,4)
		gc:fillRect(285+offsetR,125+offsetD,4,4)
		gc:fillRect(172+offsetR,68+offsetD,4,4)
		gc:fillRect(309+offsetR,201+offsetD,4,4)
		gc:fillRect(119+offsetR,-81+offsetD,4,4)
		gc:fillRect(-100+offsetR,-25+offsetD,4,4)
		gc:fillRect(340+offsetR,234+offsetD,4,4)
		gc:fillRect(338+offsetR,174+offsetD,4,4)
		gc:fillRect(-74+offsetR,83+offsetD,4,4)
		gc:fillRect(59+offsetR,-73+offsetD,4,4)
		gc:fillRect(-5+offsetR,62+offsetD,4,4)
		gc:fillRect(340+offsetR,-30+offsetD,4,4)
		gc:fillRect(-46+offsetR,259+offsetD,4,4)
		gc:fillRect(-48+offsetR,106+offsetD,4,4)
		stardown = false
		starup = false
		starleft = false
		starright = false

		if generateLife==true then
			heartx = heartx + heartstepSizeX + offsetR
			hearty = hearty + heartstepSizeY + offsetD
			gc:drawRect(heartx,hearty,9,9)
			gc:drawLine(heartx+4,hearty+7,heartx+4,hearty+7)
			gc:drawLine(heartx+3,hearty+6,heartx+5,hearty+6)
			gc:drawLine(heartx+2,hearty+5,heartx+6,hearty+5)
			gc:drawLine(heartx+2,hearty+4,heartx+6,hearty+4)
			gc:drawLine(heartx+3,hearty+3,heartx+3,hearty+3)
			gc:drawLine(heartx+5,hearty+3,heartx+5,hearty+3)
			heartx = heartx - offsetR
			hearty = hearty - offsetD
		end
		if generatefuel==true then
			fuelx = fuelx + fuelstepSizeX + offsetR
			fuely = fuely + fuelstepSizeY + offsetD
			gc:drawRect(fuelx,fuely,9,9)
			gc:drawLine(fuelx+3,fuely+7,fuelx+3,fuely+2)
			gc:drawLine(fuelx+4,fuely+2,fuelx+5,fuely+2)
			gc:drawLine(fuelx+4,fuely+4,fuelx+4,fuely+4)
			fuelx = fuelx - offsetR
			fuely = fuely - offsetD
		end	
		if generatefuel2==true then
			fuelx2 = fuelx2 + fuelstepSizeX2 + offsetR
			fuely2 = fuely2 + fuelstepSizeY2 + offsetD
			gc:drawRect(fuelx2,fuely2,9,9)
			gc:drawLine(fuelx2+3,fuely2+7,fuelx2+3,fuely2+2)
			gc:drawLine(fuelx2+4,fuely2+2,fuelx2+5,fuely2+2)
			gc:drawLine(fuelx2+4,fuely2+4,fuelx2+4,fuely2+4)
			fuelx2 = fuelx2 - offsetR
			fuely2 = fuely2 - offsetD
		end	
		if generateBullet==true and bulletHit==false then
			bulletx = bulletx + bulletstepSizeX + offsetR
			bullety = bullety + bulletstepSizeY + offsetD
			gc:drawRect(bulletx,bullety,9,9)
			gc:drawLine(bulletx+3,bullety+7,bulletx+3,bullety+2)
			gc:drawLine(bulletx+4,bullety+2,bulletx+4,bullety+2)
			gc:drawLine(bulletx+4,bullety+4,bulletx+4,bullety+4)
			gc:drawLine(bulletx+4,bullety+6,bulletx+4,bullety+6)
			gc:drawLine(bulletx+5,bullety+3,bulletx+5,bullety+3)
			gc:drawLine(bulletx+5,bullety+6,bulletx+5,bullety+5)
			bulletx = bulletx - offsetR
			bullety = bullety - offsetD
		end		
		if generateEnemy==true then
			Enemy1xcoord=Enemy1xcoord+offsetR
			Enemy1ycoord=Enemy1ycoord+offsetD
			gc:drawLine(Enemy1xcoord,Enemy1ycoord,Enemy1xcoord,Enemy1ycoord+1)
			gc:drawLine(Enemy1xcoord+1,Enemy1ycoord,Enemy1xcoord+1,Enemy1ycoord+2)
			gc:drawLine(Enemy1xcoord+2,Enemy1ycoord+1,Enemy1xcoord+2,Enemy1ycoord+6)
			gc:drawLine(Enemy1xcoord+3,Enemy1ycoord+4,Enemy1xcoord+3,Enemy1ycoord+8)
			gc:drawLine(Enemy1xcoord+4,Enemy1ycoord+3,Enemy1xcoord+4,Enemy1ycoord+9)
			gc:drawLine(Enemy1xcoord+5,Enemy1ycoord+2,Enemy1xcoord+5,Enemy1ycoord+3)
			gc:drawLine(Enemy1xcoord+5,Enemy1ycoord+5,Enemy1xcoord+5,Enemy1ycoord+6)
			gc:drawLine(Enemy1xcoord+8,Enemy1ycoord+2,Enemy1xcoord+8,Enemy1ycoord+3)
			gc:drawLine(Enemy1xcoord+8,Enemy1ycoord+5,Enemy1xcoord+8,Enemy1ycoord+6)
			gc:drawLine(Enemy1xcoord+6,Enemy1ycoord+1,Enemy1xcoord+6,Enemy1ycoord+3)
			gc:drawLine(Enemy1xcoord+6,Enemy1ycoord+5,Enemy1xcoord+6,Enemy1ycoord+7)
			gc:drawLine(Enemy1xcoord+7,Enemy1ycoord+1,Enemy1xcoord+7,Enemy1ycoord+3)
			gc:drawLine(Enemy1xcoord+7,Enemy1ycoord+5,Enemy1xcoord+7,Enemy1ycoord+7)
			gc:drawLine(Enemy1xcoord+13,Enemy1ycoord,Enemy1xcoord+13,Enemy1ycoord+1)
			gc:drawLine(Enemy1xcoord+12,Enemy1ycoord,Enemy1xcoord+12,Enemy1ycoord+2)
			gc:drawLine(Enemy1xcoord+11,Enemy1ycoord+1,Enemy1xcoord+11,Enemy1ycoord+6)
			gc:drawLine(Enemy1xcoord+10,Enemy1ycoord+4,Enemy1xcoord+10,Enemy1ycoord+8)
			gc:drawLine(Enemy1xcoord+9,Enemy1ycoord+3,Enemy1xcoord+9,Enemy1ycoord+9)

			Enemy1xcoord=Enemy1xcoord-offsetR
			Enemy1ycoord=Enemy1ycoord-offsetD
		end

		if shieldHit==false and generateShield==true then
			shieldx = shieldx + shieldstepSizeX + offsetR
			shieldy = shieldy + shieldstepSizeY + offsetD
			gc:drawRect(shieldx,shieldy,9,9)
			gc:drawLine(shieldx+2,shieldy+7,shieldx+5,shieldy+7)
			gc:drawLine(shieldx+6,shieldy+6,shieldx+6,shieldy+6)
			gc:drawLine(shieldx+5,shieldy+5,shieldx+3,shieldy+5)
			gc:drawLine(shieldx+2,shieldy+4,shieldx+2,shieldy+4)
			gc:drawLine(shieldx+3,shieldy+3,shieldx+6,shieldy+3)
			shieldx = shieldx - offsetR
			shieldy = shieldy - offsetD
		end

		
		gc:setColorRGB(0,0,0) 
		gc:fillPolygon({100,211, 220,211, 220,185, 201,159, 119,159, 100,185, 100,211})		--Makes it so there are no stars in the dash
		gc:setColorRGB(255,255,255)

		gc:drawLine(100,211,220,211) 								--Draws bottom of Dash
		gc:drawLine(100,210,220,210) 								--Thickens botton of Dash
		gc:drawLine(100,211,100,185)								--Draws Left side of Dash
		gc:drawLine(220,211,220,185)								--Draws Right side of Dash
		gc:drawLine(100,185,119,159)								--Draws Left Diagonal of Dash
		gc:drawLine(220,185,201,159)								--Draws Right Diagonal of Dash
		gc:drawLine(201,159,119,159)								--Draws top of Dash
		gc:drawLine(159,102,159,92) 								--Draws upper target line
		gc:drawLine(159,110,159,120) 								--Draws lower target line
		gc:drawLine(155,106,145,106) 								--Draws left target line
		gc:drawLine(163,106,173,106) 								--Draws right target line
		gc:drawArc(159 - 9/2, 106 - 9/2, 9,9,0,360)
		gc:drawArc(159 - 20/2, 106 - 20/2, 20,20,0,360)
		--stats
		drawHeartxcoord = 120
		drawHeartycoord = 200
		drawLife = lives
		
		while drawLife >0 do
			gc:drawLine(drawHeartxcoord+4,drawHeartycoord+7,drawHeartxcoord+4,drawHeartycoord+7)
			gc:drawLine(drawHeartxcoord+3,drawHeartycoord+6,drawHeartxcoord+5,drawHeartycoord+6)
			gc:drawLine(drawHeartxcoord+2,drawHeartycoord+5,drawHeartxcoord+6,drawHeartycoord+5)
			gc:drawLine(drawHeartxcoord+2,drawHeartycoord+4,drawHeartxcoord+6,drawHeartycoord+4)
			gc:drawLine(drawHeartxcoord+3,drawHeartycoord+3,drawHeartxcoord+3,drawHeartycoord+3)
			gc:drawLine(drawHeartxcoord+5,drawHeartycoord+3,drawHeartxcoord+5,drawHeartycoord+3)
			drawLife = drawLife - 1
			drawHeartxcoord = drawHeartxcoord+9
		end
		
		
		
		displayB = "B:"..bullets
		gc:drawString(tostring(displayB), 120, 185, "bottom")
			
		displayF = "F:"..fuel
		gc:drawString(tostring(displayF), 160, 185, "bottom")
		
		gc:drawRect(118,195,85,4)		

		if health>85 then
			gc:drawLine(120,197,136,197)
			gc:drawLine(136,197,152,197)
			gc:drawLine(152,197,168,197)
			gc:drawLine(168,197,184,197)
			gc:drawLine(184,197,201,197)
		elseif health>65 and 86>health then
			gc:drawLine(120,197,136,197)
			gc:drawLine(136,197,152,197)
			gc:drawLine(152,197,168,197)
			gc:drawLine(168,197,184,197)
		elseif health>45 and 66>health then
			gc:drawLine(120,197,136,197)
			gc:drawLine(136,197,152,197)
			gc:drawLine(152,197,168,197)
		elseif health>25 and 46>health then
			gc:drawLine(120,197,136,197)
			gc:drawLine(136,197,152,197)
		elseif health>0 and 26>health then
			gc:drawLine(120,197,136,197)
		end

		timer.start(0.1) 									--Keeps the screen refreshing
	elseif death=="true" then
		blocks = true
		deadX=0
		deadY=0
		while blocks==true and deadAnimate>0 do
			color=math.random(5)
			if color==1 then
				gc:setColorRGB(255,255,255)
			elseif color==2 then
				gc:setColorRGB(166,166,166)
			elseif color==3 then
				gc:setColorRGB(119,119,119)
			elseif color==4 then
				gc:setColorRGB(66,66,66)
			elseif color==5 then
				gc:setColorRGB(0,0,0)
			end

			gc:fillRect(deadX,deadY,5,5)
			deadX = deadX+5

			if deadX==320 then
				deadY = deadY + 5
				deadX = 0
			end
			if deadY==220 then
				blocks=false
			end
			
		end
		if deadAnimate > 0 then
			deadAnimate = deadAnimate - 1
		else
			deadAnimate = 0
		end
		if deadAnimate == 0 then
			gc:setColorRGB(0,0,0)
			gc:fillRect(0,0,318,212)
			gc:setColorRGB(255,255,255)
			displayDeath = "You Have Died!"
			restart = "Press r to Restart"
			gc:drawString(displayDeath,(platform.window:width()-gc:getStringWidth(displayDeath))/2,platform.window:height()/2, "middle")
			gc:drawString(restart,(platform.window:width()-gc:getStringWidth(restart))/2,platform.window:height()-gc:getStringHeight(restart),"bottom")
		else
			timer.start(0.1) 
		end

		else
			pts = 0											--Points (Displayed in upper-left corner)
			message = "Welcome to nFighter!"
			message2 = "Press Enter to Start"
			gc:drawString(message,(platform.window:width()-gc:getStringWidth(message))/2,platform.window:height()/2, "middle")
			gc:drawString(message2,(platform.window:width()-gc:getStringWidth(message2))/2,platform.window:height()-gc:getStringHeight(message2),"bottom")
			offsetR = 0
			offsetD = 0
			starleft = true	
			fireposX = 159 --virtual position of target
			fireposY = 106 --virtual position of target
			needResource = 0
			needEnemy = true
			generateEnemy = false
			generateLife = false
			generatefuel = false
			generateBullet = false
			generateShield=false
			lives = 9
			health = 100
			takenHealth = 0
			showFire = 0
			fuel = 100
			bullets	= 50
			fuelHit=false
			shieldHit=false
			bulletHit=false
			heartHit = false
			deadMessage = false
			deadAnimate = 5
			death="false"
			showFire = 5
			shield = 0

			shieldx = 0
			bulletx = 0
			fuelx = 0
			heartx = 0
			fuelx2 = 0

			fuely2 = 0
			bullety = 0
			shieldy = 0
			fuely = 0
			hearty = 0

			fuelMinus = false
			fuelMinus2 = false
			heartMinus = false
			bulletMinus = false	
			shieldMinus = false		
	end			

	if lives==0 or 0>fuel or 1>bullets then
		inGame=false
		death="true"
	end

	points = "Pts:"..pts
	gc:drawString(tostring(points), 0, 0, "top")

end

function generationControl()										--Controls the generation of all items
	if shieldx>418 and shieldMinus == false then
		generateShield = false
		needResource = needResource - 1
		shieldHit = true
		shieldMinus = true
	end
	if bulletx>418 and bulletMinus == false then
		generateBullet = false
		needResource = needResource -1
		BulletHit = true
		bulletMinus = true
	end
	if heartx>418 and heartMinus == false then
		generateLife = false
		needResource = needResource - 1
		heartHit = true
		heartMinus = true
	end
	if fuelx>419 and fuelMinus == false then
		generatefuel = false
		needResource = needResource - 1
		fuelHit = true
		fuelMinus = true
	end
	if fuelx2>419 and fuelMinus2 == false then
		generatefuel2 = false
		needResource = needResource - 1
		fuelHit2 = true
		fuelMinus2 = true
	end


	if 6>needResource then
		crateGen = math.random(6)
	else
		crateGen = 0
	end

	if crateGen==1 and generateLife==false then
		heartxS = -150										--heart crate x start
		heartyS = math.random(-50,262)								--heart crate y start
		heartxF = 470										--heart crate x end
		heartyF = math.random(-50,262)								--heart crate y end
		heartstepSizeX = (heartxF - heartxS)/400
		heartstepSizeY = (heartyF - heartyS)/400
		heartHit=false
		heartx = heartxS
		hearty = heartyS
		generateLife = true
		needResource=needResource+1
	end
	if crateGen==2 and generatefuel==false then
		fuelxS = -150										--fuel crate x start
		fuelyS = math.random(-50,262)								--fuel crate y start
		fuelxF = 470										--fuel crate x end
		fuelyF = math.random(-50,262)								--fuel crate y end
		fuelstepSizeX = (fuelxF - fuelxS)/400
		fuelstepSizeY = (fuelyF - fuelyS)/400
		fuelHit=false
		fuelx = fuelxS
		fuely = fuelyS
		generatefuel = true
		needResource=needResource+1
	end
	if crateGen==3 and generateBullet==false then
		bulletxS = -150										--Bullet crate x start
		bulletyS = math.random(-50,262)								--Bullet crate y start
		bulletxF = 470										--Bullet crate x end
		bulletyF = math.random(-50,262)								--Bullet crate y end
		bulletstepSizeX = (bulletxF - bulletxS)/400
		bulletstepSizeY = (bulletyF - bulletyS)/400
		bulletHit=false
		bulletx = bulletxS
		bullety = bulletyS
		generateBullet = true
		needResource=needResource+1
	end
	if crateGen==4 and generateShield==false then
		shieldxS = -150										--Shield crate x start
		shieldyS = math.random(-50,262)								--Shield crate y start
		shieldxF = 470										--Shield crate x end
		shieldyF = math.random(-50,262)								--Shield crate y end
		shieldstepSizeX = (shieldxF - shieldxS)/400
		shieldstepSizeY = (shieldyF - shieldyS)/400
		shieldHit=false
		shieldx = shieldxS
		shieldy = shieldyS
		generateShield = true
		needResource=needResource+1
	end
	if crateGen==5 and generatefuel2==false then
		fuelxS2 = -150										--fuel crate x start
		fuelyS2 = math.random(-50,262)								--fuel crate y start
		fuelxF2 = 470										--fuel crate x end
		fuelyF2 = math.random(-50,262)								--fuel crate y end
		fuelstepSizeX2 = (fuelxF2 - fuelxS2)/400
		fuelstepSizeY2 = (fuelyF2 - fuelyS2)/400
		fuelHit2=false
		fuelx2 = fuelxS2
		fuely2 = fuelyS2
		generatefuel2 = true
		needResource=needResource+1
	end
	platform.window:invalidate() 									-- recall graph engine
end

function enemyControl()
	Enemy1xcoord = math.random(90,260)
	Enemy1ycoord = math.random(1,212)
	generateEnemy = true
	needEnemy = false
end

function theController()
		if needResource==nil then
			needResource=0
		elseif 6>needResource then
			generationControl()
		end

		if needEnemy==true and generateEnemy == false then
			startTime=timer.getMilliSecCounter()
			enemyControl()
			needEnemy=false
		elseif needEnemy==false then
			testTime=timer.getMilliSecCounter()
			endTime=testTime - startTime

			if endTime>5000 and 6000>endTime and 1>takenHealth and enemyHit==false then
				takenHealth = takenHealth+1
				if shield>0 then
					health = health-25
					shield = shield - 1
				else
					health = health-50
				end

				showFire=5
			elseif endTime>10000 and 11000>endTime and 2>takenHealth and enemyHit==false then
				takenHealth = takenHealth+1
				if shield>0 then
					health = health-25
					shield = shield - 1
				else
					health = health-50
				end

				showFire = 5
			elseif endTime>15000 and 16000>endTime and 3>takenHealth and enemyHit==false then
				takenHealth = takenHealth+1
				if shield>0 then
					health = health-25
					shield = shield - 1
				else
					health = health-50
				end

				showFire = 5
			elseif endTime>19000 and 20000>endTime and 4>takenHealth and enemyHit==false then
				takenHealth = takenHealth + 1
				if shield>0 then
					health = health-25
					shield = shield - 1
				else
					health = health-50
				end

				showFire = 5
			elseif endTime>20000 then
				generateEnemy = false
				needEnemy=true
				takenHealth = 0
				enemyHit = false
			end
		end
	platform.window:invalidate() 									-- recall graph engine
end