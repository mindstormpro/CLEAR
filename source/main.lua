import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import("blendate")

local pd = playdate
local gfx = playdate.graphics

--- TODOs:
--- make tiles... well... tileable
--- add dynamic loading
--- make a bunch of tiles          IN PROGRESS
--- stress test blendate and maybe rewrite the library to ditch the animation objects and just store the imagetable, x, y, and R values (and maybe z?)
--- scale models down (by 2?)      IN PROGRESS

local tiles = {}

local tileMetadata = Blendate("tiles/TileMetadata.json")

----------------TILES-----------------------
----- FLOOR1
--tiles.Floor1 = tileMetadata:loadRotation("tiles/Floor1")
--tiles.Floor1.paused = true

----- WALL1
tiles.Wall1 = tileMetadata:loadRotation("tiles/Wall1")
tiles.Wall1.paused = true

function pd.update()
    gfx.clear()
    tiles.Wall1:draw(50, 30)
    tiles.Wall1.frame = pd.getCrankPosition() / 2
    print("frame #: " .. tiles.Wall1.frame)
end