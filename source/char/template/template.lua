import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local pd = playdate
local gfx = playdate.graphics

local name = "template"

local character = {}

character.blendData = Blendate("char/" .. name .. "/metadata.json")
character.anims = {}
character.anims.idle = character.metadata:loadRotation("char/" .. name .. "/player") --put the path to the idle 1-frame  NOTE I need to rename this to Idle

character.currAnim = "idle"

