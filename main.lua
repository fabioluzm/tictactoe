--[[ 
	Tic Tac Toe Game

	Author: Fábio Moreira
	fa.moreira23@gmail.com

	"based on Colden Ogdsen 
	CS50 twitch.tv/cs50tv "
	cogden@cs50.harvard.edu

	sprites drawned with aseprite software
	https://www.aseprite.org/
]]

--[[ libraries ]]
local push = require 'lib/push'


--[[ Contants ]]
-- virtual resolution to simulate gameboy advance
VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 144

-- window game resolution
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- grid size
GRID_HEIGHT, GRID_WIDTH = 3, 3

-- grid tile size
GRID_TILE_SIZE = 40

-- sprite padding
SPRITE_PADDING = 4


--[[ assets ]]
-- sprites
local xSprite = love.graphics.newImage('graphics/x.png')
local oSprite = love.graphics.newImage('graphics/o.png')

-- fonts
local retroFont = love.graphics.newFont('fonts/pressstart.ttf', 8)


--[[ data structures ]]
local grid = {
	{"", "", ""},
	{"", "", ""},
	{"", "", ""}
}
local currentPlayer = 1
local selectedX, selectedY = 1, 1


function love.load()
	-- remove smoothness from rendering, giving a more aesthethic retro aspect
	love.graphics.setDefaultFilter('nearest','nearest')

	-- fonts to be loaded
	love.graphics.setFont(retroFont)

	-- window game title
	love.window.setTitle('TicTacToe')

	-- setup  game screen based on virtual resolution
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		vsync = true,
		resizable = false
	}) 
end


function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end

	if key == 'left' or key == 'a'then
		if selectedX > 1 then
			selectedX = selectedX - 1
		end
	elseif key == 'right' or key == 'd' then
		if selectedX < 3 then
			selectedX = selectedX + 1
		end
	elseif key == 'up'or key == 'w' then
		if selectedY > 1 then
			selectedY = selectedY - 1
		end
	elseif key == 'down' or key == 's' then
		if selectedY < 3 then
			selectedY = selectedY + 1
		end
	elseif key == 'space' or key == 'enter' then
		if grid[selectedY][selectedX] == "" then
			if currentPlayer == 1 then
				grid[selectedY][selectedX] = 'X'
				currentPlayer = 2
			else
				grid[selectedY][selectedX] = 'O'
				currentPlayer = 1
			end
		end
	end
end

function love.update(dt)

end


function love.draw()
	push:start()
	drawGrid()
	love.graphics.print('Player ' .. currentPlayer .. "'s turn", 1, 1)
	push:finish()
end


function drawGrid()
	--[[ calculate margins ]]
	local xMargin = VIRTUAL_WIDTH - (GRID_TILE_SIZE * GRID_WIDTH)
	local yMargin =  VIRTUAL_HEIGHT - (GRID_TILE_SIZE * GRID_HEIGHT)

	--[[ set line width ]]
	love.graphics.setLineWidth(2)
	

	--[[ draw lines of the grid ]]	
	-- vertical lines
	love.graphics.line(xMargin/2 + GRID_TILE_SIZE, yMargin/2,
		xMargin/2 + GRID_TILE_SIZE, VIRTUAL_HEIGHT - yMargin/2)
	
	love.graphics.line(VIRTUAL_WIDTH - xMargin/2 - GRID_TILE_SIZE, yMargin/2,
		VIRTUAL_WIDTH - xMargin/2 - GRID_TILE_SIZE, VIRTUAL_HEIGHT - yMargin/2)
	
	-- horizontal lines
	love.graphics.line(xMargin/2, yMargin/2 + GRID_TILE_SIZE,
		VIRTUAL_WIDTH - xMargin/2, yMargin/2 + GRID_TILE_SIZE)

	love.graphics.line(xMargin/2, VIRTUAL_HEIGHT - yMargin/2 - GRID_TILE_SIZE,
		VIRTUAL_WIDTH - xMargin/2, VIRTUAL_HEIGHT - yMargin/2 - GRID_TILE_SIZE)
	
	--[[ draw the sprites within the lines ]]
	for y = 1, GRID_HEIGHT do
		for x = 1, GRID_WIDTH do
			local xOffset = xMargin/2 + GRID_TILE_SIZE * (x - 1)
			local yOffset = yMargin/2 + GRID_TILE_SIZE * (y - 1)
			if grid[y][x] == "" then
				-- draw nothing
			elseif grid [y][x] == "X" then
				-- draw "X" sprite at x * y location
				love.graphics.draw(xSprite, xOffset + SPRITE_PADDING, yOffset + SPRITE_PADDING)
			else
				-- draw "O" sprite at x * Y location
				love.graphics.draw(oSprite, xOffset + SPRITE_PADDING, yOffset + SPRITE_PADDING)
			end
			if x == selectedX and y == selectedY then
				-- overlays selected tile
				love.graphics.setColor(1, 1, 1, 0.5)
				love.graphics.rectangle('fill', xOffset, yOffset, GRID_TILE_SIZE, GRID_TILE_SIZE)
				love.graphics.setColor(1, 1, 1, 1)
			end
		end
	end
end
