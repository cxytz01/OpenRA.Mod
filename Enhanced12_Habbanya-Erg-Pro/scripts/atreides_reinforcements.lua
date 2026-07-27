-------------------------------
---Fremen Reinforcements-------
-------------------------------

FremenEdgeCache = {}  -- {[locationStr] = {edge = CPos, dest = CPos}}
FremenReinforcementsInProgress = {}  -- re-entrancy guard: {[internalName] = true}

local FremenProbeCheckDelay = 5
local FremenSpawnCloseEnough = 3
local FremenMaxCandidates = 50

local function PalaceKey(palace)
	return palace.Location.X .. "," .. palace.Location.Y
end

-- Collect all edge sand cells, sorted by distance from palace
local function CollectEdgeSandCells(palace)
	local seen = {}
	local candidates = {}
	Map.ClosestMatchingEdgeCell(palace.Location, function(c)
		local t = Map.TerrainType(c)
		if t == 'Sand' or t == 'SpiceSand' or t == 'Dune' then
			local key = c.X .. ',' .. c.Y
			if not seen[key] then
				seen[key] = true
				table.insert(candidates, {X = c.X, Y = c.Y})
			end
		end
		return false
	end)

	local px, py = palace.Location.X, palace.Location.Y
	table.sort(candidates, function(a, b)
		return (a.X - px) * (a.X - px) + (a.Y - py) * (a.Y - py)
		     < (b.X - px) * (b.X - px) + (b.Y - py) * (b.Y - py)
	end)

	-- Truncate to nearest N candidates
	local count = #candidates
	if count > FremenMaxCandidates then
		local truncated = {}
		for i = 1, FremenMaxCandidates do
			truncated[i] = candidates[i]
		end
		return truncated
	end

	return candidates
end

-- Single probe: create hunter-based probe at fromCell, Move to toCell, check IsIdle after delay
local function ProbeReachability(fromCell, toCell, callback)
	local probe = Actor.Create("probe.reachability", true, {
		Owner = PlayerNeutral,
		Location = fromCell
	})
	probe.Move(toCell, FremenSpawnCloseEnough)

	Trigger.AfterDelay(FremenProbeCheckDelay, function()
		if probe.IsDead then
			callback(false)
			return
		end
		local reachable = not probe.IsIdle
		probe.Stop()
		probe.Destroy()
		callback(reachable)
	end)
end

-- Probe candidates sequentially from closest to furthest. Stop at the first reachable one.
local function FindReachableSpawn(destCell, candidates, callback)
	if #candidates == 0 then
		callback(nil)
		return
	end

	local function tryNext(idx)
		if idx > #candidates then
			callback(nil)
			return
		end

		local cell = CPos.New(candidates[idx].X, candidates[idx].Y)
		ProbeReachability(cell, destCell, function(reachable)
			if reachable then
				callback(cell)
			else
				tryNext(idx + 1)
			end
		end)
	end

	tryNext(1)
end

local function FremenDestCell(palace)
	if palace.HasProperty("RallyPoint") then
		local rp = palace.RallyPoint
		if rp ~= nil then return rp end
	end
	return palace.Location
end

local function DoFremenSpawn(player, spawnCell, destCell)
	local function spawnOne(idx)
		Trigger.AfterDelay(idx * 25, function()
			local unit = Actor.Create("fremen", true, {
				Owner = player,
				Location = spawnCell
			})
			unit.Move(destCell, FremenSpawnCloseEnough)
		end)
	end
	for i = 0, 6 do
		spawnOne(i)
	end
	local function spawnSandRider(idx)
		Trigger.AfterDelay(250 + idx * 10, function()
			local unit = Actor.Create("sand_runner", true, {
				Owner = player,
				Location = spawnCell
			})
			unit.Move(destCell, FremenSpawnCloseEnough)
		end)
	end
	for i = 0, 2 do
		spawnSandRider(i)
	end
end

-- Exported to scripts.lua — called when waypoint.atreides_reinf is detected
function SpawnFremenReinforcements(player)
	local name = player.InternalName
	if FremenReinforcementsInProgress[name] then
		return
	end

	local allPalaces = player.GetActorsByType("palace.atreides")
	local alive = {}
	for _, p in ipairs(allPalaces) do
		if not p.IsDead then
			table.insert(alive, p)
		else
			FremenEdgeCache[PalaceKey(p)] = nil
		end
	end
	if #alive == 0 then return end

	local picked = nil
	for _, p in ipairs(alive) do
		if p.IsPrimaryBuilding then
			picked = p
			break
		end
	end
	if picked == nil then
		picked = Utils.Random(alive)
	end
	if picked == nil or picked.IsDead then return end

	FremenReinforcementsInProgress[name] = true

	local pkey = PalaceKey(picked)
	local destCell = FremenDestCell(picked)
	local cached = FremenEdgeCache[pkey]

	if cached ~= nil and (cached.dest.X == destCell.X and cached.dest.Y == destCell.Y) then
		if cached.edge ~= nil then
			DoFremenSpawn(player, cached.edge, cached.actualDest or destCell)
		else
			DoFremenSpawn(player, Map.ClosestEdgeCell(picked.Location), cached.actualDest or picked.Location)
		end
		FremenReinforcementsInProgress[name] = nil
		return
	end

	local candidates = CollectEdgeSandCells(picked)
	FindReachableSpawn(destCell, candidates, function(edgeCell)
		if picked.IsDead or picked.Owner ~= player then
			FremenReinforcementsInProgress[name] = nil
			return
		end

		if edgeCell ~= nil then
			FremenEdgeCache[pkey] = {edge = edgeCell, dest = destCell}
			DoFremenSpawn(player, edgeCell, destCell)
			FremenReinforcementsInProgress[name] = nil
			return
		end

		-- RallyPoint unreachable; retry probe to palace.Location, fallback to closest edge
		if destCell ~= picked.Location then
			local origDest = destCell
			FindReachableSpawn(picked.Location, candidates, function(edgeCell2)
				if picked.IsDead or picked.Owner ~= player then
					FremenReinforcementsInProgress[name] = nil
					return
				end

				if edgeCell2 ~= nil then
					FremenEdgeCache[pkey] = {edge = edgeCell2, dest = origDest, actualDest = picked.Location}
					DoFremenSpawn(player, edgeCell2, picked.Location)
				else
					FremenEdgeCache[pkey] = {dest = origDest}
					DoFremenSpawn(player, Map.ClosestEdgeCell(picked.Location), picked.Location)
				end
				FremenReinforcementsInProgress[name] = nil
			end)
		else
			FremenEdgeCache[pkey] = {dest = destCell}
			DoFremenSpawn(player, Map.ClosestEdgeCell(picked.Location), destCell)
			FremenReinforcementsInProgress[name] = nil
		end
	end)
end
