--[[ 
	Tic Tac Toe

	Author: Fábio Moreira
	fa.moreira23@gmail.com
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

GRID_HEIGHT, GRID_WIDTH = 3, 3

--[[ assets ]]
local xSprite = love.graphics.newImage('graphics/x.png')
local oSprite = love.graphics.newImage('graphics/o.png')

--[[ data structures ]]
local grid = {
	{"", "", ""},
	{"", "", ""},
	{"", "", ""}
}

function love.load()
	-- remove smoothness from rendering, giving a more aesthethic retro aspect
	love.graphics.setDefaultFilter('nearest','nearest')

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
end

function love.update(dt)

end

function love.draw()
	push:start()
	drawGrid()
	push:finish()
end

function drawGrid()

	-- draw lines of the grid

	for y = 1, GRID_HEIGHT do
		for x = 1, GRID_WIDTH do
			if grid[y][x] == "" then
				-- draw nothing
			elseif grid [y][x] == "X" then
				-- draw X sprite at x * y location
				love.graphics.draw(xSprite)
			else
				-- draw O sprite at x * Y location
				love.graphics.draw(oSprite)
			end 
		end
	end
end
