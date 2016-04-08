
pi = math.pi

p1 = 200
p2 = 200

p3 = 200
p4 = 200

logox = 10
logoy = 20

paddlespeed = 500
paddlewidth = 100

aispeed = 500

speedmultiplier = 1

paddlethickness = 20
paddleoffset = 20

windowwidth = 800
windowheight = 800

splashwidth = 520
splashheight = 220

lastWin = "Nobody"

lives = 3



aiMode = false

p1h = windowheight
p2h = windowheight

p3h = windowwidth
p4h = windowwidth

players = 2

players2 = true
players3 = false
players4 = false

deathThickness = 4


ballwidth = 20
ballheight = 20


lifethickness = 5

anglemultiplier = 8

bInGame = false


buttonRadius = 12
buttonThickness = 2
buttonWidth = 24
buttonHeight = 24
segments = 20

discoMode = false
cloneMode = false

function reset()
	balls = {
		{200, 200, 200, 100}
	}
	p1 = 200
	p2 = 200
	p3 = 200
	p4 = 200
	p1h = windowheight
	p2h = windowheight
	p3h = windowwidth
	p4h = windowwidth
	bInGame = false
	love.window.setMode(splashwidth, splashheight)
	blip1:play()
	paddlespeed = 500
	paddlewidth = 100

	aispeed = 500
	start = true
end

function setPlayers(amount)
	players = amount
	buttons[1][2] = false
	buttons[2][2] = false
	buttons[3][2] = false
	if amount == 2 then
		buttons[1][2] = true
	end
	if amount == 3 then
		buttons[2][2] = true
	end
	if amount == 4 then
		buttons[3][2] = true
	end
end

function setLives(amount)
	lives = amount
	buttons[4][2] = false
	buttons[5][2] = false
	buttons[6][2] = false
	if amount == 1 then
		buttons[4][2] = true
	end
	if amount == 3 then
		buttons[5][2] = true
	end
	if amount == 5 then
		buttons[6][2] = true
	end
end

function displayButtons()
	i = 1
	while buttons[i] do
		if buttons[i][1] == 'radio' then
			love.graphics.setColor(255, 255, 255)
			love.graphics.circle("fill", buttons[i][4], buttons[i][5], buttonRadius, segments)

			love.graphics.setColor(0, 0, 0)
			love.graphics.circle("fill", buttons[i][4], buttons[i][5], buttonRadius - buttonThickness, segments)

			love.graphics.setColor(255, 255, 255)
			if buttons[i][2] then
				love.graphics.circle("fill", buttons[i][4], buttons[i][5], buttonRadius - buttonThickness*2, segments)
			end
			love.graphics.print(buttons[i][3], buttons[i][4] + buttonTextOffset, buttons[i][5] - buttonRadius/2)

		else
			if buttons[i][1] == 'check' then
				love.graphics.setColor(255, 255, 255)
				love.graphics.rectangle("fill", buttons[i][4], buttons[i][5], buttonWidth, buttonHeight)

				love.graphics.setColor(0, 0, 0)
				love.graphics.rectangle("fill", buttons[i][4] + buttonThickness, buttons[i][5] + buttonThickness, buttonWidth - buttonThickness*2, buttonHeight - buttonThickness*2)

				love.graphics.setColor(255, 255, 255)
				if buttons[i][2] then
					love.graphics.rectangle("fill", buttons[i][4] + buttonThickness*2, buttons[i][5] + buttonThickness*2, buttonWidth - buttonThickness*4, buttonHeight - buttonThickness*4)
				end
				love.graphics.print(buttons[i][3], buttons[i][4] + buttonTextOffset, buttons[i][5] + buttonHeight/4)
			end
		end
		i = i + 1
	end
end

function operateButtons(x, y)
	i = 1
	while buttons[i] do
		if buttons[i][1] == 'radio' then
			if (x > buttons[i][4] - buttonRadius) and (x < buttons[i][4] + buttonRadius) and (y > buttons[i][5] - buttonRadius) and (y < buttons[i][5] + buttonRadius) then
				buttons[i][6](buttons[i][7])
			end
		elseif buttons[i][1] == 'check' then
			if (x > buttons[i][4]) and (x < buttons[i][4] + buttonWidth) and (y > buttons[i][5]) and (y < buttons[i][5] + buttonHeight) then
				buttons[i][6](buttons[i][7])
			end
		end
		i = i + 1
	end
end

function setDisco(i)
	if buttons[i][2] then
		buttons[i][2] = false
		discoMode = false
	else
		buttons[i][2] = true
		discoMode = true
	end
end

function setClone(i)
	if buttons[i][2] then
		buttons[i][2] = false
		cloneMode = false
	else
		buttons[i][2] = true
		cloneMode = true
	end
end

function setSpeed(i)
	if buttons[i][2] then
		buttons[i][2] = false
		speedmultiplier = 1
		paddlespeed = 500
		aispeed = 500
	else
		buttons[i][2] = true
		speedmultiplier = 1.8
		paddlespeed = 1000
		aispeed = 1000
	end
end

function setAI(i)
	if buttons[i][2] then
		buttons[i][2] = false
		aiMode = false
	else
		buttons[i][2] = true
		aiMode = true
	end
end

--Buttons
buttons = {
	-- 2 Player
	{'radio', true, "2 players", 220, 50, setPlayers, 2},
	-- 3 Player
	{'radio', false, "3 players", 220, 80, setPlayers, 3},
	-- 4 Player
	{'radio', false, "4 players", 220, 110, setPlayers, 4},

	-- 1 life
	{'radio', false, "1 life", 400, 50, setLives, 1},
	-- 3 lives
	{'radio', true, "3 lives", 400, 80, setLives, 3},
	-- 5 lives
	{'radio', false, "5 lives", 400, 110, setLives, 5},

	--Disco Mode
	{'check', false, "Disco mode", 208, 135, setDisco, 7},
	--Clone Mode
	{'check', false, "Clone mode", 388, 135, setClone, 8},
	--speed mode
	{'check', false, "Speed mode", 208, 165, setSpeed, 9},
	--ai mode
	{'check', false, "AI mode", 388, 165, setAI, 10}
}

balls = {
	{200, 200, math.random (-200, 200), math.random (-200, 200)}
}

buttonTextOffset = 30

startButtonX = 40
startButtonY = 120
startButtonW = 100
startButtonH = 30

function duplicatedBall(x, fx, fy)
	i = table.getn(balls) + 1
	if fx == -1 then
		fx = 0.5
	end
	if fy == -1 then
		fy = 0.5
	end
	balls[i] = {balls[x][1], balls[x][2], balls[x][3]*fx, balls[x][4]*fy}

end

start = true

function love.load(arg)
	logo = love.graphics.newImage('assets/logo.png')
	blip1 = love.audio.newSource("assets/blip1.wav")
	blip2 = love.audio.newSource("assets/blip2.wav")
	disco = love.audio.newSource('assets/disco.mp3')
	ascending = love.audio.newSource("assets/08 Ascending.mp3")
	love.window.setMode(splashwidth, splashheight)
	blip1:play()
	love.window.setTitle("4Pong v2")
end

function love.update(dt)
	if bInGame then
		if start then
			if discoMode then
				ascending:stop()
				disco:play()
				start = false
			else
				disco:stop()
				ascending:play()
				start = false
			end
		end
		countAlive = 0
		if p1h > 0 then
			countAlive = countAlive + 1
			lastWin = "Left player"
		end
		if p2h > 0 then
			countAlive = countAlive + 1
			lastWin = "Right player"
		end
		if p3h > 0 and players > 2 then
			countAlive = countAlive + 1
			lastWin = "Top player"
		end
		if p4h > 0 and players > 3 then
			countAlive = countAlive + 1
			lastWin = "Bottom player"
		end

		if countAlive == 1 then
			reset()
		end

		i = 1
		while balls[i] do
			if p1h > 0 then
				if balls[i][1] < paddleoffset + paddlethickness then
					if balls[i][2] + ballheight> p1 then
						if balls[i][2] < p1 + paddlewidth then
							if(balls[i][3] < 0) then
								balls[i][3] = balls[i][3] * -1 * speedmultiplier
							end
							balls[i][4] = (balls[i][2] - (p1 + (paddlewidth/2))) * anglemultiplier
							blip2:play()
						end
					end 
				end
			end

			if p2h > 0 then
				if balls[i][1] > windowwidth - (paddleoffset + paddlethickness) - ballwidth then
					if balls[i][2] + ballheight > p2 then
						if balls[i][2] < p2 + paddlewidth then
							if(balls[i][3] > 0) then
								balls[i][3] = balls[i][3] * -1 * speedmultiplier
							end
							balls[i][4] = (balls[i][2] - (p2 + (paddlewidth/2))) * anglemultiplier
							blip2:play()
						end
					end 
				end
			end

			if p3h > 0 then
				if players > 2 then
					if balls[i][2] < paddleoffset + paddlethickness then
						if balls[i][1] + ballwidth > p3 then
							if balls[i][1] < p3 + paddlewidth then
								if balls[i][4] < 0 then
									balls[i][4] = balls[i][4] * -1 * speedmultiplier
								end
								balls[i][3] = (balls[i][1] - (p3 + (paddlewidth/2))) * anglemultiplier
								blip2:play()
							end
						end
					end
				end
			end

			if p4h > 0 then
				if players > 3 then
					if balls[i][2] + ballheight > windowheight - (paddleoffset + paddlethickness) then
						if balls[i][1] + ballwidth > p4 then
							if balls[i][1] < p4 + paddlewidth then
								if balls[i][4] > 0 then
									balls[i][4] = balls[i][4] * -1 * speedmultiplier
								end
								balls[i][3] = (balls[i][1] - (p4 + (paddlewidth/2))) * anglemultiplier
								blip2:play()
							end
						end
					end
				end
			end

			balls[i][1] = balls[i][1] + balls[i][3] * dt
			balls[i][2] = balls[i][2] + balls[i][4] * dt

			if balls[i][1] < 0 then
				if(balls[i][3] < 0) then
					balls[i][3] = balls[i][3] * -1
				end
				p1h = p1h - windowheight/lives
				balls[i][1] = 0
				if cloneMode and p1h > 0 then
					duplicatedBall(i, 1, -1)
				end
				blip2:play()
			end

			if balls[i][1]  > windowwidth - ballwidth then
				if(balls[i][3] > 0) then
					balls[i][3] = balls[i][3] * -1
				end
				p2h = p2h - windowheight/lives
				balls[i][1] = windowwidth - ballwidth
				if cloneMode and p2h > 0 then
					duplicatedBall(i, 1, -1)
				end
				blip2:play()
			end

			if balls[i][2] < 0 then
				if balls[i][4] < 0 then
					balls[i][4] = balls[i][4] * -1
				end
				p3h = p3h - windowheight/lives

				balls[i][2] = 0
				if cloneMode and players > 2   and p3h > 0 then
					duplicatedBall(i, -1, 1)
				end
				blip2:play()
			end

			if balls[i][2] > windowheight - ballheight then
				if balls[i][4] > 0 then
					balls[i][4] = balls[i][4] * -1
				end
				p4h = p4h - windowheight/lives
				balls[i][2] = windowheight - ballheight
				if cloneMode and players > 3  and p4h > 0  then
					duplicatedBall(i, -1, 1)
				end
				blip2:play()
			end
			i = i + 1
		end


		if p1h > 0 then
			if(love.keyboard.isDown("a")) then
				p1 = p1 + paddlespeed * dt
			end
			if(love.keyboard.isDown("q")) then
				p1 = p1 - paddlespeed * dt
			end
		end

		if aiMode then
			i = 2
			hx = 1
			hy = 1
			ly = 1
			while i < table.getn(balls) do

				if balls[hx][1] > balls[i][1] then
					hx = i
				end
				if balls[hy][2] > balls[i][2] then
					hy = i
				end
				if balls[ly][2] < balls[ly][2] then
					ly = i
				end

				i = i + 1
			end

			if p2h > 0 then
				if balls[hx][2] > p2 + paddlewidth then
					p2 = p2 + aispeed * dt
				elseif balls[hx][2] < p2 then
					p2 = p2 - aispeed * dt
				end
			end

			if p3h > 0 then
				if balls[ly][1] > p3 + paddlewidth then
					p3 = p3 + aispeed * dt
				elseif balls[ly][1] < p3 then
					p3 = p3 - aispeed * dt
				end
			end

			if p4h > 0 then
				if balls[hy][1] > p4 + paddlewidth then
					p4 = p4 + aispeed * dt
				elseif balls[hy][1] < p4 then
					p4 = p4 - aispeed * dt
				end
			end

		else
			if p2h > 0 then
				if(love.keyboard.isDown("l")) then
					p2 = p2 + paddlespeed * dt
				end
				if(love.keyboard.isDown("o")) then
					p2 = p2 - paddlespeed * dt
				end
			end

			if p3h > 0 then
				if(love.keyboard.isDown("c")) then
					p3 = p3 + paddlespeed * dt
				end
				if(love.keyboard.isDown("x")) then
					p3 = p3 - paddlespeed * dt
				end
			end


			if p4h > 0 then
				if(love.keyboard.isDown("m")) then
					p4 = p4 + paddlespeed * dt
				end
				if(love.keyboard.isDown("n")) then
					p4 = p4 - paddlespeed * dt
				end
			end

		end

		if p1 < 0 then
			p1 = 0
		end
		if p1 > windowheight - paddlewidth then
			p1 = windowheight - paddlewidth
		end

		if p2 < 0 then
			p2 = 0
		end
		if p2 > windowheight - paddlewidth then
			p2 = windowheight - paddlewidth
		end

		if p3 < 0 then
			p3 = 0
		end
		if p3 > windowwidth - paddlewidth then
			p3 = windowwidth - paddlewidth
		end

		if p4 < 0 then
			p4 = 0
		end
		if p4 > windowwidth - paddlewidth then
			p4 = windowwidth - paddlewidth
		end

		if p1h < 0 then
			p1h = 0
		end
		if p2h < 0 then
			p2h = 0
		end
		if p3h < 0 then
			p3h = 0
		end
		if p4h < 0 then
			p4h = 0
		end
	end
end

function love.mousepressed(x, y, button, istouch)
	if not bInGame then
		--Player Select
		operateButtons(x, y)

		--Start Button
		if (x > startButtonX) and (x < startButtonX + startButtonW) and (y > startButtonY) and (y < startButtonY + startButtonH) then
			bInGame = true
			love.window.setMode(windowwidth, windowheight)
		end
	end
end

function love.draw()
	if bInGame then
		if discoMode then
			love.graphics.setColor(math.random (1, 255), math.random (1, 255), math.random (1, 255))
		else
			love.graphics.setColor(255, 255, 255)
		end

		love.graphics.rectangle("fill", 0, (windowheight - p1h)/2, lifethickness, p1h)
		love.graphics.rectangle("fill", paddleoffset, p1, paddlethickness, paddlewidth)
		love.graphics.setColor(0,0,0)
		love.graphics.print("Q", paddleoffset + 5 , p1 + 5)
		love.graphics.print("A", paddleoffset + 5 , p1 + paddlewidth - 17)
		if p1h == 0 then
			love.graphics.setColor(0, 0, 0)
			love.graphics.rectangle("fill", paddleoffset + deathThickness, p1 + deathThickness, paddlethickness - deathThickness*2, paddlewidth - deathThickness*2)
		end

		if discoMode then
			love.graphics.setColor(math.random (1, 255), math.random (1, 255), math.random (1, 255))
		else
			love.graphics.setColor(255, 255, 255)
		end
		love.graphics.rectangle("fill", windowwidth - paddlethickness - paddleoffset, p2, paddlethickness, paddlewidth)
		love.graphics.rectangle("fill", windowwidth - lifethickness, (windowheight - p2h)/2, lifethickness, p2h)
		love.graphics.setColor(0,0,0)
		love.graphics.print("O", windowwidth - paddlethickness - paddleoffset + 5 , p2 + 5)
		love.graphics.print("L", windowwidth - paddlethickness - paddleoffset + 5 , p2 + paddlewidth - 17)
		if p2h == 0 then
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("fill", windowwidth - paddlethickness - paddleoffset + deathThickness, p2 + deathThickness, paddlethickness - deathThickness*2, paddlewidth - deathThickness*2)
		end

		if players > 2 then
			if discoMode then
				love.graphics.setColor(math.random (1, 255), math.random (1, 255), math.random (1, 255))
			else
				love.graphics.setColor(255, 255, 255)
			end
			love.graphics.rectangle("fill", (windowwidth - p3h)/2, 0, p3h, lifethickness)
			love.graphics.rectangle("fill", p3, paddleoffset, paddlewidth, paddlethickness)
			love.graphics.setColor(0,0,0)
			love.graphics.print("X", p3 + 5, paddleoffset + 5)
			love.graphics.print("C", p3 + paddlewidth - 15, paddleoffset + 5)
			if p3h == 0 then
				love.graphics.setColor(0,0,0)
				love.graphics.rectangle("fill", p3 + deathThickness, paddleoffset + deathThickness, paddlewidth - deathThickness*2, paddlethickness - deathThickness*2)
			end
		end

		if players > 3 then
			if discoMode then
				love.graphics.setColor(math.random (1, 255), math.random (1, 255), math.random (1, 255))
			else
				love.graphics.setColor(255, 255, 255)
			end
			love.graphics.rectangle("fill", (windowwidth - p4h)/2, windowheight - lifethickness, p4h, lifethickness)		
			love.graphics.rectangle("fill", p4, windowheight - paddlethickness - paddleoffset, paddlewidth, paddlethickness)
			love.graphics.setColor(0,0,0)
			love.graphics.print("N", p4 + 5, windowheight - paddleoffset - 15)
			love.graphics.print("M", p4 + paddlewidth - 15, windowheight - paddleoffset - 15)
			if p4h == 0 then
				love.graphics.setColor(0,0,0)
				love.graphics.rectangle("fill", p4 + deathThickness, windowheight - paddlethickness - paddleoffset + deathThickness, paddlewidth - deathThickness*2, paddlethickness - deathThickness*2)
			end
		end 
		if discoMode then
			love.graphics.setColor(math.random (1, 255), math.random (1, 255), math.random (1, 255))
		else
			love.graphics.setColor(255, 255, 255)
		end
		i=1
		while balls[i] do
			if discoMode then
				love.graphics.circle("fill", balls[i][1] + ballwidth/2, balls[i][2] + ballheight/2, ballwidth/2, 100)
				love.graphics.setColor(math.random (1, 255), math.random (1, 255), math.random (1, 255))
				love.graphics.circle("fill", balls[i][1] + ballwidth/2, balls[i][2] + ballheight/2, ballwidth/3, 100)
				love.graphics.setColor(math.random (1, 255), math.random (1, 255), math.random (1, 255))
				love.graphics.circle("fill", balls[i][1] + ballwidth/2, balls[i][2] + ballheight/2, ballwidth/4, 100)
				love.graphics.setColor(math.random (1, 255), math.random (1, 255), math.random (1, 255))
				love.graphics.circle("fill", balls[i][1] + ballwidth/2, balls[i][2] + ballheight/2, ballwidth/6, 100)
				love.graphics.setColor(math.random (1, 255), math.random (1, 255), math.random (1, 255))
				love.graphics.circle("fill", balls[i][1] + ballwidth/2, balls[i][2] + ballheight/2, ballwidth/8, 100)
			else
				love.graphics.rectangle("fill", balls[i][1], balls[i][2], ballwidth, ballheight)
			end
			i = i + 1
		end
	else


		displayButtons()
		--Start Button

		love.graphics.rectangle("fill", startButtonX, startButtonY, startButtonW, startButtonH)
		love.graphics.setColor(0, 0, 0)
		love.graphics.print("Start Game", startButtonX + 15, startButtonY + 8)


		love.graphics.setColor(255, 255, 255)
		love.graphics.print(lastWin .. " won last game", 15, startButtonY + startButtonH + 10 + 8)
		love.graphics.draw(logo, logox, logoy)

	end
end