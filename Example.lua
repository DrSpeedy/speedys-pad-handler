-- DrSpeedy#1852
-- https://github.com/DrSpeedy/speedys-pad-handler

keys = {}
keys['X'] = 193
keys['LB'] = 185
keys['RB'] = 183
keys['LT'] = 207
keys['RT'] = 208
keys['R3'] = 184
keys['L3'] = 28
keys['LEFT_AN_DOWN'] = 196
keys['LEFT_AN_UP'] = 32

require 'lib/natives-1627063482'
require 'lib/Speedy/pad_handler.lua'

local bSuperJumpEnabled = false

-- Tap X on controller twice to superjump
local function DoSuperJump(toggle)
    bSuperJumpEnabled = toggle
    util.create_tick_handler(function()
        local player = PLAYER.PLAYER_PED_ID()
        local jumping = PED.IS_PED_JUMPING(player)
        local velocity = ENTITY.GET_ENTITY_VELOCITY(player)
        local direction = ENTITY.GET_ENTITY_FORWARD_VECTOR(player)

        if(jumping and PadMultiTap('X', 1)) then
            ENTITY.SET_ENTITY_VELOCITY(player, velocity.x+(direction.x*1.1), velocity.y+(direction.y*1.1), 20)
        end
        return bSuperJumpEnabled
    end)
end

local function Init()
    StartPadHandler()
    menu.toggle(menu.my_root, 'Super Jump Example', {}, '', function(toggle) DoSuperJump(toggle) end)
end

Init()

while true do
    util.yield()
end