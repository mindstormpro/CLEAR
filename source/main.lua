import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import("blendate") -- not sure I can push this to github since it's a paid thing

local pd = playdate
local gfx = playdate.graphics

--- TODOs:
--- make tiles... well... tileable IN PROGRESS
--- add dynamic loading
--- make a bunch of tiles          IN PROGRESS
--- stress test blendate and maybe rewrite the library to ditch the animation objects and just store the imagetable, x, y, and R values (and maybe z?) DONE
--- scale models down (by 2?)      DONE
--- rewrite the framework          DONE
--- figure out the tile offsets    URGENT - IN PROGRESS
--- make modding framework         URGENT       I need to do this soon since if I do it later it will be hard to implement around everything else (use the loadPDZ function)

local tilew, tileh, ySquish = 46, 46, 0.7
local tiles = {}

local tileMetadata = Blendate("tiles/TileMetadata.json")

local pivotX, pivotY = 5, 5

----------------TILES-----------------------
local function addTile(path, tx, ty)
    return {
        img = tileMetadata:loadRotation(path),
        tx = tx,
        ty = ty,
        dx = tx - pivotX,
        dy = ty - pivotY
    }

end


table.insert(tiles, addTile("tiles/Corner1", 3, 2))
table.insert(tiles, addTile("tiles/Corner1", 2, 2))
table.insert(tiles, addTile("tiles/Corner1", 2, 3))
table.insert(tiles, addTile("tiles/Corner1", 3, 3))

local sin, cos, crankAngle, crankChange, dx, dy
local radAngle = 0
function pd.update()
    gfx.clear()
    
    crankAngle =  pd.getCrankPosition()
    radAngle = math.rad(crankAngle * -1)
    sin = math.sin(radAngle)
    cos = math.cos(radAngle)

    for i = 1, #tiles do
        tiles[i].img[(math.floor(crankAngle / 2) + 1) % 180 + 1]:draw(((tiles[i].dx * cos - tiles[i].dy * sin) * tilew) + 200, ((tiles[i].dy * cos + tiles[i].dx * sin) * tileh * ySquish) + 120)
    end
    
end