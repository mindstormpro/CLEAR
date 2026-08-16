import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"


local pd = playdate
local gfx = playdate.graphics

local tiles = {}


tiles.tilew, tiles.tileh, tiles.ySquish = 43, 43, 0.7
local centerX, centerY = 5, 5



function tiles.initTileSystem(self, metadata, w, h, cx, cy)  -- this basically just       (half finished thought that I'm to lazy to remove)
    if metadata == nil then
        if self.metadata == nil then
            print("no metadata!")
        end
    else
        self.metadata = metadata
    end
    self.tilesArr, self.tileList = {}, {}
    self.centerX, self.centerY = cx, cy
    for i = 1, w do
        self.tilesArr[i] = {}
        for x = 1, h do
            self.tilesArr[i][x] = {}
        end
    end
end

function tiles.sortTiles(self)
    table.sort(self.tileList, function (tile1, tile2)
        
        if tile1[3] < tile2[3] then 
            return true 
        else 
            return false 
        end
    end)
end

function tiles.addTile(self, path, tx, ty, rot)
    if not (self.tilesArr[tx][ty].img == nil) then
        print("A tile already exists at " .. tx .. ", " .. ty .. "!")
        return
    end
    local tempTile = {
        img = self.metadata:loadRotation(path),
        tx = tx,
        x, ------ for the temp calculations each frame
        y, ------ ^^^
        frame, -- ^^^
        dist,
        ty = ty,
        rot = rot * 90,
        dx = tx - self.centerX,
        dy = ty - self.centerY
    }
    tempTile.w, tempTile.h = tempTile.img[1]:getSize()
    print(tempTile.w / 2)
    table.insert(self.tileList, {tx, ty, 0})
    self.tilesArr[tx][ty] = tempTile
end

function tiles.computeTiles(self)
    local crankAngle =  pd.getCrankPosition()
    local radAngle = math.rad(crankAngle * -1)
    local sin = math.sin(radAngle)
    local cos = math.cos(radAngle)
    local tempTile
    for i = 1, #self.tileList do
        --- a bunch of math
        tempTile = self.tilesArr[self.tileList[i][1]][self.tileList[i][2]]
        tempTile.frame = (math.floor((crankAngle + tempTile.rot) / 2) + 1) % 180 + 1
        tempTile.x, tempTile.y = ((tempTile.dx * cos - tempTile.dy * sin) * self.tilew) + 200 - 32, ((tempTile.dy * cos + tempTile.dx * sin) * self.tileh * self.ySquish) + 120 - tempTile.h + 32
        tempTile.dist = math.floor((tempTile.dy * cos + tempTile.dx * sin) * 10000)
        tiles.tileList[i][3] = tempTile.dist
    end
    self:sortTiles()
end

function tiles.drawTiles(self)
    local tempTile
    for i = 1, #self.tileList do
        --- a bunch of drawing :3
        tempTile = self.tilesArr[self.tileList[i][1]][self.tileList[i][2]]
        tempTile.img[tempTile.frame]:draw(tempTile.x, tempTile.y)
    end
end

return tiles