-- DrSpeedy#1852
-- https://github.com/DrSpeedy/speedys-pad-handler

require 'lib/natives-1627063482'
require 'lib/Speedy/Keys'
require 'lib/Speedy/pad_handler'

local bSuperJumpEnabled = false
local bSeqTestEnabled = false

-- Tap X on controller twice to superjump
local function DoSuperJump(toggle)
    bSuperJumpEnabled = toggle
    util.create_tick_handler(function()
        local player = PLAYER.PLAYER_PED_ID()
        local jumping = PED.IS_PED_JUMPING(player)
        local velocity = ENTITY.GET_ENTITY_VELOCITY(player)
        local direction = ENTITY.GET_ENTITY_FORWARD_VECTOR(player)

        if(CheckInput('[T2]X') or CheckInput('[T2]VK(32)')) then -- VK32 is Space
            ENTITY.SET_ENTITY_VELOCITY(player, velocity.x+(direction.x*1.1), velocity.y+(direction.y*1.1), 20)
        end
        return bSuperJumpEnabled
    end)
end

-- Speed/util
function TeleportPed(ped, coords, rotation, with_vehicle)
	local keep_velocity = true
	local entity = 0
	local speed = 0
	local vel = v3.new()

	if (with_vehicle and PED.IS_PED_IN_ANY_VEHICLE(ped, true)) then
		entity = PED.GET_VEHICLE_PED_IS_IN(ped, false)
	end

	if (not ENTITY.IS_ENTITY_A_VEHICLE(entity)) then
		entity = ped
	end

	if (keep_velocity) then
		if (ENTITY.IS_ENTITY_A_VEHICLE(entity)) then
			speed = ENTITY.GET_ENTITY_SPEED(entity)
		else
			vel = ENTITY.GET_ENTITY_VELOCITY(entity)
		end
	end

	ENTITY.SET_ENTITY_COORDS(entity, coords.x, coords.y, coords.z)
	if (rotation ~= nil) then
		ENTITY.SET_ENTITY_ROTATION(entity, rotation.x, rotation.y, rotation.z, 0, true)
	end

	if (keep_velocity) then
		if (ENTITY.IS_ENTITY_A_VEHICLE(entity)) then
			VEHICLE.SET_VEHICLE_FORWARD_SPEED(entity, speed)
		else
			local boost = ENTITY.GET_ENTITY_FORWARD_VECTOR(entity)
			boost:mul(10)
			ENTITY.SET_ENTITY_VELOCITY(entity, vel.x + boost.x, vel.y + boost.y, vel.z + boost.z)
		end
	end
end

local function DoSeqTest(toggle)
    bSeqTestEnabled = toggle
    util.create_tick_handler(function()
        if (CheckInput('[F]SEQ(LB,RB,X,A)')) then
            TeleportPed(players.user_ped(), v3.new(499.44351196289,5594.240234375,795.54022216797), v3.new(0.0,-0.0,145.05352783203), true)
        end
        return bSeqTestEnabled
    end)
end

local function Init()
    StartPadHandler()
    menu.toggle(menu.my_root(), 'Super Jump Example', {}, '', function(toggle) DoSuperJump(toggle) end)
    menu.toggle(menu.my_root(), 'SEQ Example', {}, 'Press LB + RB + X + A to teleport to Chilliad', function(toggle) DoSeqTest(toggle) end)
end

Init()

while true do
    util.yield()
end