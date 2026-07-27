-- thumper_mission.lua
-- Bot AI control for thumper and worm_rider units:
-- move toward an enemy, stop mid-way at a random point, then deploy
-- if the current cell and its 2-cell-radius neighbours are all desert.

local DesertTerrainTypes = {Sand = true, Spice = true, Dune = true, SpiceSand = true}

local function isDesertCell(cell)
	local ok, terrainType = pcall(function() return Map.TerrainType(cell) end)
	if not ok then
		return false
	end
	return DesertTerrainTypes[terrainType] == true
end

local function isAllDesertRadius(centerCell, radius)
	for dx = -radius, radius do
		for dy = -radius, radius do
			local cell = CPos.New(centerCell.X + dx, centerCell.Y + dy)
			if not isDesertCell(cell) then
				return false
			end
		end
	end
	return true
end

thumperMission = function(unit)
	if unit.IsDead then return end

	if not unit.HasTag(BusyTag) then
		local targets = findEnemyTargets(unit.CenterPosition, unit.Owner, 40, "Health", true)

		if next(targets) ~= nil then
			local token = markBusy(unit)
			unit.Move(Utils.Random(targets).Location)

			Trigger.AfterDelay(Utils.RandomInteger(500, 800), function()
				if unit.IsDead then return end
				unit.Stop()

				if isAllDesertRadius(unit.Location, 2) then
					unit.GrantCondition("deployed")
				end

				Trigger.AfterDelay(370, function()
					clearBusy(unit, token, BusyTag)
				end)
			end)
		end
	end

	Trigger.AfterDelay(500, function()
		thumperMission(unit)
	end)
end
