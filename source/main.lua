import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import("blendate")

local pd = playdate
local gfx = playdate.graphics

local clear = import("clear")  
clear.tiles = import("tiles")
clear.char = import("character")
--- TODOs:
--- make tiles... well... tileable DONE
--- add dynamic loading                      TODO, URGENT
--- make a bunch of tiles                    IN PROGRESS
--- stress test blendate and maybe rewrite the library to ditch the animation objects and just store the imagetable, x, y, and R values (and maybe z?) DONE
--- scale models down (by 2?)                DONE
--- rewrite the framework                    DONE
--- figure out the tile offsets              URGENT - DONE BUT MIGHT NEED TWEAKS    I have to make the tiles draw from the bottom-left corner because different tiles have different heights
--- make modding framework                   TODO, URGENT       I need to do this soon since if I do it later it will be hard to implement around everything else (use the loadPDZ function)
--- time to do a whole frigin rewrite        DONE!!! FINALLY
--- Rewrite the blendate.lua script          TODO, KINDA URGENT
--- Separate this game into multiple files   DONE FOR NOW, URGENT 
--- Make characters in Blender               TODO, URGENT



local tileMetadata = Blendate("tiles/TileMetadata.json")



----------------TILES-----------------------

clear.tiles:initTileSystem(tileMetadata, 10, 10, 5, 5)
clear.tiles:addTile("tiles/Corner1", 5, 5, 0)
clear.tiles:addTile("tiles/Wall1", 5, 6, 1)
clear.tiles:addTile("tiles/Wall1", 6, 5, 0)
clear.tiles:addTile("tiles/Floor1", 6, 6, 0)
clear.tiles:addTile("tiles/DeadEnd1", 4, 6, 0)
clear.tiles:addTile("tiles/Floor1", 3, 6, 0)
clear.tiles:addTile("tiles/Floor1", 3, 5, 0)
clear.tiles:addTile("tiles/Wall1", 4, 5, 0)
clear.tiles:addTile("tiles/Floor1", 3, 4, 0)
clear.tiles:addTile("tiles/Floor1", 4, 4, 0)
clear.tiles:addTile("tiles/Floor1", 5, 4, 0)
clear.tiles:addTile("tiles/Floor1", 6, 4, 0)

clear.char.new(import("char/template"))
function pd.update()
    gfx.clear()
    clear.tiles:computeTiles()
    clear.tiles:drawTiles()
end