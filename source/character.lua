import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

------------- TODOS ----------------
---Figure out config

local pd = playdate
local gfx = playdate.graphics

local char = {}
char.chars = {}

function char.new(self, name, config) -- config is an array that holds anims, abilities, and other stuff that will be loaded dynamically
    if char.chars[name] ~= nil then
        return nil
    end
    char.chars[name] = config
    table.insert(char.charList, name)
end