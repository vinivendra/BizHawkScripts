

require "png"



ocrDictionary = {

  A = {

    character = "A",

    width = 4,

    height = 7,

    bytes = {

      {0,1,1,0},

      {1,0,0,1},

      {1,0,0,1},

      {1,1,1,1},

      {1,0,0,1},

      {1,0,0,1},

      {1,0,0,1},

    }

  },

  B = {

    character = "B",

    width = 4,

    height = 7,

    bytes = {

      {1,1,1,0},

      {1,0,0,1},

      {1,0,0,1},

      {1,1,1,0},

      {1,0,0,1},

      {1,0,0,1},

      {1,1,1,0},

    }

  },

  E = {

    character = "E",

    width = 4,

    height = 7,

    bytes = {

      {1,1,1,1},

      {1,0,0,0},

      {1,0,0,0},

      {1,1,1,0},

      {1,0,0,0},

      {1,0,0,0},

      {1,1,1,1},

    }

  },

  I = {

    character = "I",

    width = 3,

    height = 7,

    bytes = {

      {1,1,1},

      {0,1,0},

      {0,1,0},

      {0,1,0},

      {0,1,0},

      {0,1,0},

      {1,1,1},

    }

  },

  L = {

    character = "L",

    width = 4,

    height = 7,

    bytes = {

      {1,0,0,0},

      {1,0,0,0},

      {1,0,0,0},

      {1,0,0,0},

      {1,0,0,0},

      {1,0,0,0},

      {1,1,1,1},

    }

  },

  Q = {

    character = "Q",

    width = 4,

    height = 8,

    bytes = {

      {0,1,1,0},

      {1,0,0,1},

      {1,0,0,1},

      {1,0,0,1},

      {1,0,0,1},

      {1,0,1,1},

      {0,1,1,0},

      {0,0,0,1},

    }

  },

  R = {

    character = "R",

    width = 4,

    height = 7,

    bytes = {

      {1,1,1,0},

      {1,0,0,1},

      {1,0,0,1},

      {1,1,1,0},

      {1,0,0,1},

      {1,0,0,1},

      {1,0,0,1},

    }

  },

  S = {

    character = "S",

    width = 4,

    height = 7,

    bytes = {

      {0,1,1,0},

      {1,0,0,1},

      {1,0,0,0},

      {0,1,1,0},

      {0,0,0,1},

      {1,0,0,1},

      {0,1,1,0},

    }

  },

  T = {

    character = "T",

    width = 3,

    height = 7,

    bytes = {

      {1,1,1},

      {0,1,0},

      {0,1,0},

      {0,1,0},

      {0,1,0},

      {0,1,0},

      {0,1,0},

    }

  },

  U = {

    character = "U",

    width = 4,

    height = 7,

    bytes = {

      {1,0,0,1},

      {1,0,0,1},

      {1,0,0,1},

      {1,0,0,1},

      {1,0,0,1},

      {1,0,0,1},

      {0,1,1,0},

    }

  },

}



local allLetters = {

  "A",

  "B",

  "C",

  "D",

  "E",

  "F",

  "G",

  "H",

  "I",

  "J",

  "K",

  "L",

  "M",

  "N",

  "O",

  "P",

  "Q",

  "R",

  "S",

  "T",

  "U",

  "V",

  "W",

  "X",

  "Y",

  "Z",

}



function parseString(image, xStart, yStart)

  local result = ""

  while true do

    local letter = findLetter(image, xStart, yStart)

    if letter then

      result = result .. letter.character

      xStart = xStart + letter.width + 1

    else

      return result

    end

  end

end



function findLetter(image, xStart, yStart)

  for i=1,26 do

    letter = allLetters[i]

    local letterInfo = ocrDictionary[letter]

    if letterInfo and checkLetter(image, letterInfo, xStart, yStart) then

      return ocrDictionary[letter]

    end

  end

end



function checkLetter(image, letter, xStart, yStart)

    for j=1,letter.height do

      for i=1,letter.width do

        local pixel = image:getPixel(xStart+i, yStart+j)

        local value = 0

        if pixel.R < 100 then

          value = 1

        end



        if letter.bytes[j][i] ~= value then

          return false

        end



      -- io.write(value .. " ")

      end

    -- print("")

    end

    return true

end

