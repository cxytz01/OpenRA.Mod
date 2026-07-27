-------------------------------
---Airstrike Support Powers----
-------------------------------

local function CalculateBestAngle(position)
	if position.X <= 2 then
		return Angle.East
	elseif position.Y <= 2 then
		return Angle.South
	elseif position.X < position.Y then
		return Angle.North
	else
		return Angle.West
	end
end

local function CheckEngage(unit, targetWPos)
	if unit.IsDead then return end
	if unit.Stance == "HoldFire" then
		local up = unit.CenterPosition
		local dx = up.X - targetWPos.X
		local dy = up.Y - targetWPos.Y
		if dx * dx + dy * dy <= 943718400 then  -- (30 * 1024)^2
			unit.Stance = "Defend"
			unit.GrantCondition("engage-timer")
			return
		end
	end
	Trigger.AfterDelay(20, function() CheckEngage(unit, targetWPos) end)
end

local function LeaveOnEmpty(unit)
	if not unit.IsDead then
		if unit.AmmoCount("primary") < 1 then
			unit.Stop()
			local position = Map.ClosestEdgeCell(unit.Location)
			unit.Move(position)
			unit.Destroy()
		else
			Trigger.AfterDelay(30, function()
				LeaveOnEmpty(unit)
			end)
		end
	end
end

CallOrdosAirstrike = function(dummy)
	local targetWPos = Map.CenterOfCell(dummy.Location)
	Beacon.New(dummy.Owner, targetWPos, 350)
	local baseCell = Map.ClosestEdgeCell(dummy.Location)
	local baseWPos = Map.CenterOfCell(baseCell)
	local facing = CalculateBestAngle(baseCell)
	local alt = Actor.CruiseAltitude("ornithopter.deviator")
	local squadRefs = {}

	for i = 1, 6 do
		local delay = i * 18 + Utils.RandomInteger(0, 8)
		local ox = Utils.RandomInteger(-1536, 1537)
		local oy = Utils.RandomInteger(-1536, 1537)

		Trigger.AfterDelay(delay, function()
			local wpos = baseWPos + WVec.New(ox, oy, alt)
			local airUnit = Actor.Create("ornithopter.deviator", true, {
				Owner = dummy.Owner,
				Facing = facing,
				CenterPosition = wpos
			})
			if not airUnit.IsDead then
				airUnit.Stance = "HoldFire"
				airUnit.Move(dummy.Location)
				table.insert(squadRefs, airUnit)
				CheckEngage(airUnit, targetWPos)
			end
		end)
	end

	Trigger.AfterDelay(150, function()
		local alive = {}
		for _, u in pairs(squadRefs) do
			if not u.IsDead then table.insert(alive, u) end
		end
		if #alive > 0 then
			Trigger.OnAllRemovedFromWorld(alive, function()
				if not dummy.IsDead then dummy.Destroy() end
			end)
		else
			if not dummy.IsDead then dummy.Destroy() end
		end
	end)
end

CallAtreidesAirstrike = function(dummy)
	local targetWPos = Map.CenterOfCell(dummy.Location)
	Beacon.New(dummy.Owner, targetWPos, 300)
	local baseCell = Map.ClosestEdgeCell(dummy.Location)
	local baseWPos = Map.CenterOfCell(baseCell)
	local facing = CalculateBestAngle(baseCell)
	local alt = Actor.CruiseAltitude("ornithopter.bomber")

	local dummyTarget = Actor.Create("dummy.generic", true, {
		Owner = dummy.Owner,
		CenterPosition = targetWPos
	})

	local perpX, perpY
	if facing == Angle.East or facing == Angle.West then
		perpX, perpY = 0, 1
	else
		perpX, perpY = 1, 0
	end

	local planes = {}

	for i = 1, 3 do
		local sx = perpX * (i - 2) * 2
		local sy = perpY * (i - 2) * 2
		local spawnCell = baseCell + CVec.New(sx, sy)
		local spawnWPos = Map.CenterOfCell(spawnCell) + WVec.New(0, 0, alt)
		Trigger.AfterDelay((i - 1) * 35, function()
			local plane = Actor.Create("ornithopter.bomber", true, {
				Owner = dummy.Owner,
				Facing = facing,
				Location = spawnCell,
				CenterPosition = spawnWPos
			})
			if not plane.IsDead then
				plane.Attack(dummyTarget, true, true)
				table.insert(planes, plane)
				LeaveOnEmpty(plane)
			end
		end)
	end

	Trigger.AfterDelay(100, function()
		local alive = {}
		for _, p in pairs(planes) do
			if not p.IsDead then table.insert(alive, p) end
		end
		if #alive > 0 then
			Trigger.OnAllRemovedFromWorld(alive, function()
				if not dummy.IsDead then dummy.Destroy() end
				if not dummyTarget.IsDead then dummyTarget.Kill() end
			end)
		else
			if not dummy.IsDead then dummy.Destroy() end
			if not dummyTarget.IsDead then dummyTarget.Kill() end
		end
	end)
end
