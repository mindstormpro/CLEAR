import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import("blendate")
local tiles = import("tiles")
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




local tileMetadata = Blendate("tiles/TileMetadata.json")



----------------TILES-----------------------

tiles:initTileSystem(tileMetadata, 10, 10, 5, 5)
tiles:addTile("tiles/Corner1", 5, 5, 0)
tiles:addTile("tiles/Wall1", 5, 6, 1)
tiles:addTile("tiles/Wall1", 6, 5, 0)
tiles:addTile("tiles/Floor1", 6, 6, 0)
tiles:addTile("tiles/DeadEnd1", 4, 6, 0)
tiles:addTile("tiles/Floor1", 3, 6, 0)
tiles:addTile("tiles/Floor1", 3, 5, 0)
tiles:addTile("tiles/Wall1", 4, 5, 0)
tiles:addTile("tiles/Floor1", 3, 4, 0)
tiles:addTile("tiles/Floor1", 4, 4, 0)
tiles:addTile("tiles/Floor1", 5, 4, 0)
tiles:addTile("tiles/Floor1", 6, 4, 0)


function pd.update()
    gfx.clear()
    tiles:computeTiles()
    tiles:drawTiles()
end