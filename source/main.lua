import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import("blendate") -- not sure I can push this to github since it's a paid thingy, TODO: Ask

local pd = playdate
local gfx = playdate.graphics

--- TODOs:
--- make tiles... well... tileable IN PROGRESS
--- add dynamic loading
--- make a bunch of tiles                    IN PROGRESS
--- stress test blendate and maybe rewrite the library to ditch the animation objects and just store the imagetable, x, y, and R values (and maybe z?) DONE
--- scale models down (by 2?)                DONE
--- rewrite the framework                    DONE
--- figure out the tile offsets              URGENT - DONE BUT MIGHT NEED TWEAKS    I have to make the tiles draw from the bottom-left corner because different tiles have different heights
--- make modding framework                   URGENT       I need to do this soon since if I do it later it will be hard to implement around everything else (use the loadPDZ function)
--- time to do a whole frigin rewrite        DONE!!! FINALLY
--- Rewrite the blendate.lua script          KINDA URGENT
--- Separate this game into multiple files   URGENT 

local tilew, tileh, ySquish = 43, 43, 0.7
local tiles, tileList

local tileMetadata = Blendate("tiles/TileMetadata.json")

local centerX, centerY = 5, 5

----------------TILES-----------------------
local function initTileSystem(w, h, cx, cy)  -- this basically just 
    tiles, tileList = {}, {}, {}
    centerX, centerY = cx, cy
    for i = 1, w do
        tiles[i] = {}
        for x = 1, h do
            tiles[i][x] = {}
        end
    end

end

local function sortTiles()
    table.sort(tileList, function (tile1, tile2)
        
        if tiles[tile1[1]][tile1[2]].dist < tiles[tile2[1]][tile2[2]].dist then 
            return true 
        else 
            return false 
        end
    end)
end

local function addTile(path, tx, ty, rot)
    if not (tiles[tx][ty].img == nil) then
        print("A tile already exists at " .. tx .. ", " .. ty .. "!")
        return
    end
    local tempTile = {
        img = tileMetadata:loadRotation(path),
        tx = tx,
        x, ------ for the temp calculations each frame
        y, ------ ^^^
        frame, -- ^^^
        dist,
        ty = ty,
        rot = rot * 90,
        dx = tx - centerX,
        dy = ty - centerY
    }
    tempTile.w, tempTile.h = tempTile.img[1]:getSize()
    table.insert(tileList, {tx, ty})
    tiles[tx][ty] = tempTile
end

initTileSystem(10, 10, 5, 5)
addTile("tiles/Corner1", 5, 5, 0)
addTile("tiles/Wall1", 5, 6, 1)
addTile("tiles/Wall1", 6, 5, 0)
addTile("tiles/Floor1", 6, 6, 0)
addTile("tiles/DeadEnd1", 4, 6, 0)
addTile("tiles/Floor1", 3, 6, 0)
addTile("tiles/Floor1", 3, 5, 0)
addTile("tiles/Wall1", 4, 5, 0)

local sin, cos, crankAngle, crankChange, dx, dy
local radAngle = 0
local tempTile
function pd.update()
    
    gfx.clear()
    
    crankAngle =  pd.getCrankPosition()
    radAngle = math.rad(crankAngle * -1)
    sin = math.sin(radAngle)
    cos = math.cos(radAngle)
    for i = 1, #tileList do
        --- a bunch of math
        
        tempTile = tiles[tileList[i][1]][tileList[i][2]]
        tempTile.frame = (math.floor((crankAngle + tempTile.rot) / 2) + 1) % 180 + 1
        tempTile.x, tempTile.y = ((tempTile.dx * cos - tempTile.dy * sin) * tilew) + 200, ((tempTile.dy * cos + tempTile.dx * sin) * tileh * ySquish) + 120 - tempTile.h
            
        tempTile.dist = math.floor((tempTile.dy * cos + tempTile.dx * sin) * 10000)
    end

    sortTiles()

    for i = 1, #tileList do
        tempTile = tiles[tileList[i][1]][tileList[i][2]]
        tempTile.img[tempTile.frame]:draw(((tempTile.dx * cos - tempTile.dy * sin) * tilew) + 200, ((tempTile.dy * cos + tempTile.dx * sin) * tileh * ySquish) + 120 - tempTile.h)
    end
    
end