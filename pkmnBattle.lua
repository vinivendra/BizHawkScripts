
require "ocr"

require "png"

function getBattleInfo(image)
	-- Compensate for animation
	local pixel = image:getPixel(146, 111)
	local offset = 0
	if pixel.R > 100 then
		offset = 1
	end

	local foeName = parseString(image, 20, 21)
	local myName = parseString(image, 142, 79 + offset)

	return {
		foeName = foeName,
		myName = myName
	}
end

