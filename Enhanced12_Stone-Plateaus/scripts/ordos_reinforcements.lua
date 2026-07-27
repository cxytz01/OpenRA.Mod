---------------------------------------
---Ordos Reinforcements----------------
---------------------------------------

OrdosReinforcements = {}     -- {[internalName] = true}
OrdosOriginStarports = {}    -- {[key] = true}  bloodline marker, key = "X,Y"

local OrdosInterval = 1876
local OrdosGroups = {
	{ "light_inf", "light_inf", "light_inf", "light_inf", "light_inf", "light_inf", "light_inf", "light_inf", "light_inf", "light_inf", "scorch_tank" },
	{ "trooper",  "trooper",  "trooper",  "trooper",  "trooper",  "bison_tank" },
}

-- ============ Bloodline & Qualification ============

local function starportKey(sp)
	return sp.Location.X .. "," .. sp.Location.Y
end

local function PlayerHasOrdosOriginStarport(player)
	for _, sp in ipairs(player.GetActorsByType("starport")) do
		if not sp.IsDead and OrdosOriginStarports[starportKey(sp)] then
			return true
		end
	end
	return false
end

local function PlayerHasAnyStarport(player)
	for _, sp in ipairs(player.GetActorsByType("starport")) do
		if not sp.IsDead then
			return true
		end
	end
	return false
end

local function PlayerQualifies(player)
	if player.Faction == "ordos" and player.HasPrerequisites({"upgrade.starport"}) then
		if PlayerHasAnyStarport(player) then
			return true
		end
	end
	return PlayerHasOrdosOriginStarport(player)
end

-- ============ Delivery ============

local function GetRallyPoint(starport)
	local rp = starport.RallyPoint
	local sloc = starport.Location
	if rp == nil then
		return sloc + CVec.New(1, 3)
	end
	if rp.X >= sloc.X and rp.X <= sloc.X + 2 and
	   rp.Y >= sloc.Y and rp.Y <= sloc.Y + 2 then
		return sloc + CVec.New(1, 3)
	end
	return rp
end

local function SelectDeliveryTarget(player)
	local starports = player.GetActorsByType("starport")
	local alive = {}
	for _, sp in ipairs(starports) do
		if not sp.IsDead then
			if sp.IsPrimaryBuilding then
				return sp
			end
			table.insert(alive, sp)
		end
	end
	if #alive > 0 then
		return Utils.Random(alive)
	end
	return nil
end

local function SpawnOrdosReinforcements(player)
	local target = SelectDeliveryTarget(player)
	if target == nil then return end

	local group = Utils.Random(OrdosGroups)
	local rallypoint = GetRallyPoint(target)
	local entryCell = Map.ClosestEdgeCell(target.Location)
	local path = { entryCell, rallypoint }

	Media.PlaySpeechNotification(player, "Reinforce")
	local result = Reinforcements.ReinforceWithTransport(player, "carryall.transport", group, path, { rallypoint, entryCell })

	if result ~= nil then
		local transport = result[1]
		Trigger.OnPassengerExited(transport, function(carry, pass)
			if pass ~= nil and not pass.IsDead then
				Trigger.AfterDelay(1, function()
					if pass.IsDead then return end
					if pass.HasProperty("AttackMove") then
						pass.AttackMove(rallypoint, 1)
					elseif pass.HasProperty("Move") then
						pass.Move(rallypoint)
					end
				end)
			end
		end)
	end
end

-- ============ Loop ============

local function StartOrdosReinforcements(player)
	local name = player.InternalName
	if OrdosReinforcements[name] then return end

	OrdosReinforcements[name] = true
	SpawnOrdosReinforcements(player)

	local function loop()
		if OrdosReinforcements[name] == nil then return end
		if PlayerQualifies(player) then
			SpawnOrdosReinforcements(player)
			Trigger.AfterDelay(OrdosInterval, loop)
		else
			OrdosReinforcements[name] = nil
		end
	end
	Trigger.AfterDelay(OrdosInterval, loop)
end

-- ============ Capture ============

local function BindStarportHooks(starport)
	local key = starportKey(starport)

	Trigger.OnCapture(starport, function(self, captor, oldOwner, newOwner)
		if oldOwner.HasPrerequisites({"upgrade.starport"}) then
			OrdosOriginStarports[key] = true
			StartOrdosReinforcements(newOwner)
		end
	end)

	Trigger.OnRemovedFromWorld(starport, function()
		if starport.IsDead then
			OrdosOriginStarports[key] = nil
		end
	end)
end

-- ============ Init ============

function InitOrdosReinforcements(activePlayers)
	for _, p in ipairs(activePlayers) do
		local existing = p.GetActorsByType("starport")
		for _, sp in ipairs(existing) do
			if not sp.IsDead then
				BindStarportHooks(sp)
			end
		end
	end

	Trigger.OnAnyProduction(function(producer, produced, productionQueue)
		if produced.Type == "starport" then
			BindStarportHooks(produced)
		end
	end)
end

-- This polling is the ONLY detection path for an Ordos player completing upgrade.starport
-- on their own starport. Unlike capture (which fires OnCapture), a self-upgrade has no
-- event hook — the only way to notice the completed upgrade is HasPrerequisites on tick.
-- Do NOT remove this polling without replacing it with an equivalent event-driven trigger.
function DetectOrdosReinforcements(activePlayers)
	for _, p in ipairs(activePlayers) do
		if OrdosReinforcements[p.InternalName] == nil then
			if PlayerQualifies(p) then
				StartOrdosReinforcements(p)
			end
		end
	end
end
