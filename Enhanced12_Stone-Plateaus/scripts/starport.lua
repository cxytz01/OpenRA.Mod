------------------------------------
--Original D2k Starport behaviour---
------------------------------------

local FrigateDeliveryDelay = DateTime.Seconds(60) -- delivery arrival delay
local FrigateCapacity = 6                         -- max units per frigate shipment
local StarportUnits = {}
local RevokeTokens = {} -- isFull and notEmpty revoke tokens
local DummyActors = {}  -- used for icons overlays

-- NOTE: When adding a new dummy.xxx type to starport.yaml,
-- you MUST add the corresponding entry to StockConfig below.
-- Otherwise HasStock() will always return false and orders will be silently discarded.
local StockConfig = {
	harvester     = {max = 6,  charge = 370},
	trike         = {max = 10, charge = 220},
	raider        = {max = 10, charge = 220},
	quad          = {max = 9,  charge = 225},
	heavy_quad    = {max = 8,  charge = 210},
	dustrider     = {max = 5,  charge = 250},
	combat_tank_a = {max = 8,  charge = 240},
	combat_tank_h = {max = 8,  charge = 240},
	combat_tank_o = {max = 8,  charge = 240},
	siege_tank    = {max = 7,  charge = 270},
	missile_tank  = {max = 7,  charge = 230},
	mcv           = {max = 3,  charge = 500},
	carryall      = {max = 4,  charge = 400},
}

local StockCurrent = {}
local StockTokens = {}
local StockInitialized = {}

local function CleanupStockForPlayer(player)
	local name = player.InternalName
	StockCurrent[name] = nil
	StockTokens[name] = nil
	StockInitialized[name] = nil
end

local function InitStockForPlayer(player)
	local name = player.InternalName
	if StockInitialized[name] then
		return
	end
	StockInitialized[name] = true
	StockCurrent[name] = {}
	StockTokens[name] = {}

	for unitName, cfg in pairs(StockConfig) do
		StockCurrent[name][unitName] = cfg.max
		local function charge()
			if StockCurrent[name] == nil then
				return
			end
			local cur = StockCurrent[name][unitName]
			local max = StockConfig[unitName].max
			if cur < max then
				StockCurrent[name][unitName] = cur + 1
				if cur == 0 and StockTokens[name][unitName] then
					player.RevokeCondition(StockTokens[name][unitName])
					StockTokens[name][unitName] = nil
				end
			end
			Trigger.AfterDelay(DateTime.Seconds(StockConfig[unitName].charge), charge)
		end
		Trigger.AfterDelay(DateTime.Seconds(cfg.charge), charge)
	end
end

local function ConsumeStock(player, unitName)
	local name = player.InternalName
	if not StockCurrent[name] then
		return
	end
	local cur = StockCurrent[name][unitName]
	if cur == nil or cur <= 0 then
		return
	end
	StockCurrent[name][unitName] = cur - 1
	if cur - 1 == 0 then
		local token = player.GrantCondition("stock-depleted-" .. unitName)
		StockTokens[name][unitName] = token
	end
end

local function HasStock(player, unitName)
	local name = player.InternalName
	if not StockCurrent[name] then
		return false
	end
	return (StockCurrent[name][unitName] or 0) > 0
end

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

local function ExperimentalStarport(player, dummy)
	local playerInternalName = player.InternalName

	-- Lazy stock init: if we got here but stock isn't ready, init it now
	if not StockInitialized[playerInternalName] then
		InitStockForPlayer(player)
	end

	if player.HasPrerequisites({"shipment-in-progress"}) then
		dummy.Destroy()
		return
	end

	local unit = dummy.Type
	local unitName = unit:gsub("^dummy%.", "")

	if not HasStock(player, unitName) then
		dummy.Destroy()
		return
	end

	local cartSize = #StarportUnits[playerInternalName]
	if cartSize >= FrigateCapacity then
		dummy.Destroy()
		return
	end

	local typeCount = 1
	for i, existing in ipairs(DummyActors[playerInternalName]) do
		if existing.Type == unit then
			typeCount = typeCount + 1
		end
	end

	ConsumeStock(player, unitName)
	table.insert(StarportUnits[playerInternalName], unitName)
	table.insert(DummyActors[playerInternalName], dummy)
	cartSize = cartSize + 1
	dummy.GrantCondition("order-"..tostring(typeCount))

	if cartSize == 1 then
		local token = player.GrantCondition("frigate-not-empty")
		table.insert(RevokeTokens[playerInternalName], token)
	end
	if cartSize == FrigateCapacity then
		local token = player.GrantCondition("frigate-full")
		table.insert(RevokeTokens[playerInternalName], token)
	end
end

local function SelectStarport(player)
	local alive = {}
	for i, starport in pairs(player.GetActorsByTypes({"starport"})) do
		if not starport.IsDead then
			if starport.IsPrimaryBuilding then
				return starport
			end
			table.insert(alive, starport)
		end
	end
	if #alive > 0 then
		return Utils.Random(alive)
	end
	return nil
end

local function ResetStartport(player)
	local playerInternalName = player.InternalName
	-- Revoke all granted conditions (frigate-not-empty, frigate-full, shipment-in-progress)
	for i, token in ipairs(RevokeTokens[playerInternalName] or {}) do
		player.RevokeCondition(token)
	end
	for i, dummy in pairs(DummyActors[playerInternalName]) do
		--edge case check. when player surrender while delivery is in progress
		if not dummy.IsDead then
			dummy.Destroy()
		end
	end
	DummyActors[playerInternalName] = {}
	RevokeTokens[playerInternalName] = {}
	StarportUnits[playerInternalName] = {}
	local purchaseActors = player.GetActorsByType("purchase.starport")
	for i, p in ipairs(purchaseActors) do
		if not p.IsDead then
			p.Destroy()
		end
	end
end

local function FilterAirUnits(playerInternalName)
	local airUnits = {}
	local groundUnits = {}
	for i, unit in ipairs(StarportUnits[playerInternalName]) do
		if unit == "carryall" then
			table.insert(airUnits, "carryall")
		else
			table.insert(groundUnits, unit)
		end
	end
	return airUnits, groundUnits
end

local function DeliveryNotifications(player)
	Media.PlaySpeechNotification(player, "OrderPlaced")
	local time = 0
	local timeBetweenNotifications = FrigateDeliveryDelay / 5
	time = time + timeBetweenNotifications
	Trigger.AfterDelay(time -15, function()
		Media.PlaySpeechNotification(player, "TMinusFive")
	end)
	time = time + timeBetweenNotifications
	Trigger.AfterDelay(time, function()
		Media.PlaySpeechNotification(player, "TMinusFour")
	end)
	time = time + timeBetweenNotifications
	Trigger.AfterDelay(time, function()
		Media.PlaySpeechNotification(player, "TMinusThree")
	end)
	time = time + timeBetweenNotifications
	Trigger.AfterDelay(time, function()
		Media.PlaySpeechNotification(player, "TMinusTwo")
	end)
	time = time + timeBetweenNotifications
	Trigger.AfterDelay(time, function()
		Media.PlaySpeechNotification(player, "TMinusOne")
	end)
end

local function CHOAMDelivery(player)
	local playerInternalName = player.InternalName
	-- Prevent duplicate Purchase during active shipment
	if player.HasPrerequisites({"shipment-in-progress"}) then
		return
	end
	-- Check for empty cart
	local cart = StarportUnits[playerInternalName]
	if cart == nil or #cart == 0 then
		local purchaseActors = player.GetActorsByType("purchase.starport")
		if purchaseActors[1] ~= nil then
			purchaseActors[1].Destroy()
		end
		return
	end
	local token = player.GrantCondition("shipment-in-progress")
	table.insert(RevokeTokens[playerInternalName], token)
	DeliveryNotifications(player)
	Trigger.AfterDelay(FrigateDeliveryDelay, function ()
		--Media.Debug("starting delivery process")
		local starport = SelectStarport(player)
		if starport == nil then
			--Media.Debug("Error, cant find any starport. Starport reset"..player.Name)
			ResetStartport(player)
			return
		end
		local deliveryTarget = starport
		local rallypoint = GetRallyPoint(starport)
		local path = {Map.ClosestEdgeCell(starport.Location), starport.Location + CVec.New(1,1)}
		local airUnits, groundUnits = FilterAirUnits(playerInternalName)
		-- All carryall orders: no frigate needed
		if #groundUnits == 0 then
			local carryallRefs = Reinforcements.Reinforce(player, airUnits, path)
			-- Reset when all carryalls have arrived (idle) or are destroyed
			local carryallCount = #carryallRefs
			local arrivedCount = 0
			local hasReset = false
			local function tryCarryallReset()
				if hasReset then return end
				hasReset = true
				ResetStartport(player)
			end
			for _, ca in ipairs(carryallRefs) do
				local counted = false
				local function markArrived()
					if counted then return end
					counted = true
					arrivedCount = arrivedCount + 1
					if arrivedCount >= carryallCount then
						tryCarryallReset()
					end
				end
				Trigger.OnIdle(ca, markArrived)
				Trigger.OnRemovedFromWorld(ca, markArrived)
			end
			-- Fallback: reset after frigate-equivalent timeout
			Trigger.AfterDelay(FrigateDeliveryDelay, function()
				tryCarryallReset()
			end)
			return
		end
		--wait for Choam to come
		local units = Reinforcements.ReinforceWithTransport(player, "frigate_choam", groundUnits, path, {path[2], path[1]})
		local frigate = units[1]
		if #airUnits > 0 then
			Trigger.AfterDelay(280, function()
				Reinforcements.Reinforce(player, airUnits, path)
			end)
		end
		-- when killed or deliver finish remove Frigade and reset Starport settings
		Trigger.OnRemovedFromWorld(starport, function()
			--Media.Debug("Starport removed redirecting order "..frigate.Type)
			local starport_new = SelectStarport(player)
			if starport_new == nil then
				if not frigate.IsDead then
					--Media.Debug("no more starports, canceling order"..player.Name)
					frigate.Stop()
					frigate.Move(path[1])
				end
			else
				deliveryTarget = starport_new
				--Media.Debug("Starport removed redirecting order "..frigate.Type)
				if not frigate.IsDead then
					frigate.Stop()
					rallypoint = GetRallyPoint(starport_new)
					frigate.Move(starport_new.Location + CVec.New(1,1))
					frigate.UnloadPassengers()
				else
					--Media.Debug("Cant redirect, frigate is dead"..player.Name)
				end
			end
		end)
		-- when killed or deliver finish. Remove Frigade and reset Starport settings
		Trigger.OnRemovedFromWorld(frigate, function()
			ResetStartport(player)
			if deliveryTarget and not deliveryTarget.IsDead and deliveryTarget.Owner == player then
				Trigger.ClearAll(deliveryTarget)
			end
		end)
		--in case frigate stuck
		Trigger.OnIdle(frigate, function()
			if frigate.HasPassengers then
				frigate.UnloadPassengers()
			end
		end)
		Trigger.OnPassengerExited(frigate,
		function(carry, pass)
			Media.PlaySpeechNotification(carry.Owner, "Reinforce")
			if pass ~= nil then
				Trigger.AfterDelay(1, function()
					if pass.IsDead then return end
					if pass.HasProperty("AttackMove") then
						pass.AttackMove(rallypoint, 1)
					elseif pass.HasProperty("FindResources") then
						pass.Move(rallypoint)
						pass.FindResources()
					elseif pass.HasProperty("Move") then
						pass.Move(rallypoint)
					end
				end)
			end
		end)
	end)
end

local function StarportDispatch(player, produced)
	local actor = produced.Type
	if actor == "purchase.starport" then
		CHOAMDelivery(produced.Owner)
	elseif actor:match("^dummy%.") then
		ExperimentalStarport(produced.Owner, produced)
	end
end

function InitStarport(activePlayers)
	for _, p in ipairs(activePlayers) do
		StarportUnits[p.InternalName] = {}
		RevokeTokens[p.InternalName] = {}
		DummyActors[p.InternalName] = {}

		-- Cleanup stock timers when player is eliminated
		Trigger.OnPlayerLost(p, function() CleanupStockForPlayer(p) end)

		-- Handle map pre-placed starports (won't fire OnAnyProduction)
		local existing = p.GetActorsByType("starport")
		for _, sp in ipairs(existing) do
			if not sp.IsDead then
				InitStockForPlayer(p)
				break
			end
		end
	end

	Trigger.OnAnyProduction(function(producer, produced, productionQueue)
		-- Event-driven stock init: "starport built" and "stock ready" are the same event
		if produced.Type == "starport" then
			InitStockForPlayer(produced.Owner)
		end
		if productionQueue == "Starport" then
			StarportDispatch(producer.Owner, produced)
		end
	end)
end
