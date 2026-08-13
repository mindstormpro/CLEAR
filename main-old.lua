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
--- stress test blendate and maybe rewrite the library to ditch the animation objects and just store the imagetable, x, y, and R values (and maybe z?)
--- scale models down (by 2?)      DONE
--- rewrite the framework          IN PROGRESS
local tilew, tileh, ySquish = 30, 30, 0.7
local tiles = {}

local tileMetadata = Blendate("tiles/TileMetadata.json")

local pivotX, pivotY = 5, 5

----------------TILES-----------------------


----- WALL1
tiles.Wall1 = {}
tiles.Wall1.img = tileMetadata:loadRotation("tiles/Wall1")
tiles.Wall1.tx = 0
tiles.Wall1.dx = tiles.Wall1.tx - pivotX
tiles.Wall1.ty = 0
tiles.Wall1.dy = tiles.Wall1.ty - pivotY

local sin, cos, crankAngle, crankChange, dx, dy
local radAngle = 0
function pd.update()
    gfx.clear()
    
    crankAngle = pd.getCrankPosition()
    radAngle = math.rad(crankAngle * -1)
    sin = math.sin(radAngle)
    cos = math.cos(radAngle)
    
    tiles.Wall1.img[math.floor(crankAngle / 2) + 1]:draw(((tiles.Wall1.dx * cos - tiles.Wall1.dy * sin) * tilew) + 200, ((tiles.Wall1.dy * cos + tiles.Wall1.dx * sin) * tileh * ySquish) + 120)
end