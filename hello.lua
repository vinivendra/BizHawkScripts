-- This template lives at `.../Lua/.template.lua`.

-- local example = require "bye"
-- require "png"

function table.shallow_copy(t)
	local t2 = {}
	for k,v in pairs(t) do
		t2[k] = v
	end
	return t2
end

local frameCounter = 0

local events = {
	{ hold = { "B" } },
	{ press = { "A" } },
	-- { release = { "B" } },
	{ press = { "A" } },
	{ press = { "A" } },
	{ press = { "A" } },
	{ press = { "A" } },
	{ press = { "A" } },
	{ press = { "A" } },
	{ press = { "A" } },
}

local heldButtons = { }

function processEvent()
	if #events > 0 then
		local event = events[1]
		local inputs = { }

		-- If it's a command to hold a button, record that
		-- button as being held then return
		if event.hold then
			for index, button in ipairs(event.hold) do
				heldButtons[button] = true
			end
			table.remove(events, 1)
			return
		end

		-- If it's a command to release a button, record that
		-- button as no longer being held then return
		if event.release then
			for index, button in ipairs(event.release) do
				heldButtons[button] = false
			end
			table.remove(events, 1)
			return
		end

		-- If it's a command to press a button, press that button then delay
		if event.press then
			-- Default delay of 60 frames
			if not event.delay then
				event.delay = 60
			end

			-- If the action hasn't yet been performed, perform it
			if not event.done then
				event.done = true
				
				local input = table.shallow_copy(heldButtons)
				for index, button in ipairs(event.press) do
					input[button] = true
				end

				console.log(input)
				joypad.set(input)
			else
				-- If the action has been performed

				-- Count down the delay
				if event.delay > 0 then
					event.delay = event.delay - 1
					-- console.log(event.delay)
				else
					table.remove(events, 1)
				end

				-- Press the held buttons
				local input = table.shallow_copy(heldButtons)
				-- console.log(input)
				joypad.set(input)
			end
		end
	end
end

while true do
    frameCounter = frameCounter + 1

	-- client.screenshot("test2.png")
	-- local img = pngImage("test2.png")
	-- local pixel = img:getPixel(img.width, 1)
	-- r = pixel.R
	-- g = pixel.G
	-- b = pixel.B
	-- a = pixel.A
	
	
	processEvent()

	emu.frameadvance();
end
