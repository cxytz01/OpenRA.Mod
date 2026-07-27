InfantryTypes = {light_inf=true, trooper=true, engineer=true, grenadier=true, fremen=true, ["fremen.spawn"]=true, sardaukar=true, mpsardaukar=true, ["sardaukar.level1"]=true, ["sardaukar.level2"]=true, ["sardaukar.level3"]=true, thumper=true, saboteur=true, worm_rider=true}
MicroUnitTypes = {trike=true, raider=true, stealth_raider=true, sand_runner=true, quad=true, heavy_quad=true, dustrider=true}
TankTypes = {dustrider=true, combat_tank_a=true, combat_tank_h=true, combat_tank_o=true, bison_tank=true}

RepairPads = {} -- {[internalName] = {pad1, pad2, ...}}
CurrentConyards = {}

ActorSnapshoot={}

BusyTag = "busy"

WorldLoaded = function()
	local players = {}
	local activePlayers = {}
	for i = 0, 27 do
		local p = Player.GetPlayer("Multi" .. i)
		if p ~= nil then
			table.insert(players, p)
		end
	end
	PlayerNeutral = Player.GetPlayer("Neutral")
	PlayerCreep = Player.GetPlayer("Creeps")

	for i, player in pairs(players) do
		-- deploy MCV for bots
		if player.IsBot then
			local mcvs = player.GetActorsByType("mcv")
			for _, mcv in pairs(mcvs) do
				if not mcv.IsDead then
					mcv.Deploy()
				end
			end

			botEarlyRush(player)
		end
		if not player.IsNonCombatant then
			table.insert(activePlayers, player)
		end
	end

	-- worm delay
	local wormDelay = tonumber(Map.LobbyOption("WormsSpawnDelay"))
	if wormDelay > 0 then
		Trigger.AfterDelay(DateTime.Minutes(wormDelay), function()
			--in teory any player can own wormspawner actor
			wormSpawnFunction(PlayerNeutral)
			wormSpawnFunction(PlayerCreep)
			for _, player in ipairs(players) do
				wormSpawnFunction(player)
			end
		end)
	end

	-- Store activePlayers for Tick access
	ActivePlayers = activePlayers

	InitStarport(activePlayers)
	InitOrdosReinforcements(activePlayers)
	-- sandstorm disabled

	-- NOTE: Trigger.OnAnyProduction is intentionally registered by multiple systems
	-- (scripts.lua, starport.lua, ordos_reinforcements.lua). Each listener handles a
	-- distinct concern and they coexist safely. Do NOT deduplicate or merge them.
	Trigger.OnAnyProduction( function(producer, produced, productionQueue)
		local actor = produced.Type
		if not produced.Owner.IsBot then return end

		if actor == "engineer" then
			enginnerMission(produced)
		end

		if actor == "saboteur" then
			saboteurMission(produced)
		end

		if actor == "thumper" or actor == "worm_rider" then
			thumperMission(produced)
		end
	end)

	Trigger.AfterDelay(DateTime.Minutes(7), botEconomyStrategy)
	Trigger.AfterDelay(DateTime.Minutes(15), botLateGameStrategy)
end

Tick = function()
	--everything execute's one's per 2 second, because preformance :( - will case lags
	if DateTime.GameTime % DateTime.Seconds(2) == 0 then
		local nba = NewBornActors(Map.ActorsInWorld, ActorSnapshoot)
		for _, a in pairs(nba) do
			local at = a.Type
			-- Air support powers
			if at == "waypoint.ordos_airstrike" then
				CallOrdosAirstrike(a)
			end
			if at == "waypoint.atreides_airstrike" then
				CallAtreidesAirstrike(a)
			end
			if at == "waypoint.atreides_reinf" then
				SpawnFremenReinforcements(a.Owner)
				a.Destroy()
			end
			if at == "repair_pad" then
				local name = a.Owner.InternalName
				if RepairPads[name] == nil then
					RepairPads[name] = {}
				end
				table.insert(RepairPads[name], a)
			end
			if at == "construction_yard" and a.Owner.IsBot then
				CurrentConyards[tostring(a)] = a
			end
			if at == "fremen_sietch" then
				RegisterSietchDamageHandler(a)
			end
			-- Bot unit behaviors: covers all creation paths (production, reinforcements, starport)
			if a.Owner.IsBot then
				if MicroUnitTypes[at] then
					trikeMicro(a)
				end
				if TankTypes[at] then
					autoCrush(a, a.Owner)
				end
				local ok, accepts = pcall(function() return a.AcceptsCondition("start-repair") end)
				if ok and accepts and at ~= "mcv" and at ~= "harvester" then
					vehicleRepair(a, a.Owner.InternalName)
				end
			end
		end
		DetectSardaukarReinforcements(ActivePlayers)
		DetectOrdosReinforcements(ActivePlayers)
	end

	-- Bot engineer protection scripts: executed ones per 2 sec.
	if DateTime.GameTime % DateTime.Seconds(2) == 0 then
		engineerProtection()
	end
end

function engineerProtection()
	for k, conyard in pairs(CurrentConyards) do
		if conyard.IsDead then
			CurrentConyards[k] = nil
		else
			local actorsInRadius = Map.ActorsInCircle(conyard.CenterPosition, WDist.New(3036))
			local owner = conyard.Owner
			for _, actor in pairs(actorsInRadius) do
				if actor.Type == "engineer" and not owner.IsAlliedWith(actor.Owner) then
					--Media.DisplayMessage(actor.Type)
					conyard.Sell()
					CurrentConyards[k] = nil
					break
				end
			end
		end
	end
end

-- Grants "reject-orders" condition and adds BusyTag to mark an actor as busy.
-- Returns the condition token for later use with clearBusy.
-- Optional duration: 0 (default) = permanent, >0 = auto-expire after N ticks.
function markBusy(actor, duration)
	local token = actor.GrantCondition("reject-orders", duration or 0)
	actor.AddTag(BusyTag)
	return token
end

-- Revokes a condition and removes a tag from an actor, if it is still alive.
-- Safe no-op when the actor was consumed (e.g. engineer captures successfully).
function clearBusy(actor, token, tag)
	if not actor.IsDead then
		actor.RevokeCondition(token)
		actor.RemoveTag(tag)
	end
end

function NewBornActors(worldactor, snapshoot)
    local added = {}
    local nextReg = {}
    for _, act in ipairs(worldactor) do
        local k = tostring(act)
        nextReg[k] = true
        if not snapshoot[k] then
            table.insert(added, act)
        end
    end

    for k in pairs(snapshoot) do
        snapshoot[k] = nil
    end
    for k, v in pairs(nextReg) do
        snapshoot[k] = v
    end
    return added
end

InfantryBuild = {"light_inf","light_inf","light_inf","light_inf","light_inf",
"light_inf","light_inf","light_inf","light_inf","light_inf",
"light_inf","light_inf","light_inf","light_inf","light_inf",
"light_inf","light_inf","light_inf","light_inf","light_inf",
"light_inf","light_inf","light_inf","light_inf","light_inf",
"light_inf","light_inf","light_inf","light_inf","light_inf"}

TrikeBuild = {}
TrikeBuild["trike"] = {"trike","trike","trike","trike","trike","trike"}
TrikeBuild["raider"] = {"raider","raider","raider","raider","raider"}

VehicleBuild = {}
VehicleBuild["harkonnen"] = {"combat_tank_h","combat_tank_h","combat_tank_h"}
VehicleBuild["ordos"] = {"combat_tank_o","combat_tank_o","combat_tank_o"}
VehicleBuild["atreides"] = {"combat_tank_a","combat_tank_a","combat_tank_a"}

LateGameBuild = {}
LateGameBuild["atreides"] = {"ornithopter.sound","ornithopter.sound","ornithopter.sound","ornithopter.sound","ornithopter.sound","ornithopter.sound","ornithopter.sound","ornithopter.sound","ornithopter.sound","ornithopter.sound"}
LateGameBuild["ordos"] = {"ornithopter.laser","ornithopter.laser","ornithopter.laser","ornithopter.laser","ornithopter.laser","ornithopter.laser","ornithopter.laser","ornithopter.laser","ornithopter.laser","ornithopter.laser"}
LateGameBuild["harkonnen"] = {"devastator","devastator","devastator","missile_tank","devastator","devastator","devastator","missile_tank","siege_tank"}

function buildTurretsOnPowerSurplus(player)
	local surplus = player.PowerProvided - player.PowerDrained
	if surplus < 50 then return end
	local count = 1
	if surplus >= 100 then
		count = 2
	end
	local turrets = {}
	for i = 1, count do
		table.insert(turrets, "medium_gun_turret")
	end
	player.Build(turrets)
end

function botEarlyRush(botPlayer)
	if string.find(botPlayer.Name, "Gladius") then
		earlyRushInfantry(botPlayer)
	end
	if string.find(botPlayer.Name, "Omnius") then
		earlyRushTrike(botPlayer)
	end
	if string.find(botPlayer.Name, "Vidious") then
		earlyRushTanks(botPlayer)
	end

end

function earlyRushInfantry(botPlayer)
	local barracks = botPlayer.GetActorsByType("barracks")
	if next(barracks) == nil then
		Trigger.AfterDelay(100, function()
			earlyRushInfantry(botPlayer)
		end)
		return
	end

	if not botPlayer.IsProducing("light_inf") then
		local ok = botPlayer.Build(InfantryBuild, function(actors)
			buildTurretsOnPowerSurplus(botPlayer)
		end)
		if ok then return end
	end
	Trigger.AfterDelay(100, function()
		earlyRushInfantry(botPlayer)
	end)
end

function earlyRushTrike(botPlayer)
	local light_factory = botPlayer.GetActorsByType("light_factory")
	if next(light_factory) == nil then
		Trigger.AfterDelay(100, function()
			earlyRushTrike(botPlayer)
		end)
		return
	end

	local refinery = botPlayer.GetActorsByTypes({"refinery", "refinery_inverted"})
	if #refinery >= 2 and not refinery[1].IsDead then
		refinery[1].Sell()
	end

	if not botPlayer.IsProducing("trike") then
		local buildTable
		if botPlayer.HasPrerequisites({"light.raider"}) then
			buildTable = TrikeBuild["raider"]
		else
			buildTable = TrikeBuild["trike"]
		end
		local ok = botPlayer.Build(buildTable, function(actors)
			buildTurretsOnPowerSurplus(botPlayer)
		end)
		if ok then return end
	end
	Trigger.AfterDelay(100, function()
		earlyRushTrike(botPlayer)
	end)
end

function earlyRushTanks(botPlayer)
	local heavy_factory = botPlayer.GetActorsByTypes({"heavy_factory"})
	if next(heavy_factory) == nil then
		Trigger.AfterDelay(100, function()
			earlyRushTanks(botPlayer)
		end)
		return
	end

	local refinery = botPlayer.GetActorsByTypes({"refinery", "refinery_inverted"})
	if #refinery >= 3 then
		if not refinery[1].IsDead then refinery[1].Sell() end
		if not refinery[2].IsDead then refinery[2].Sell() end
	end

	--Media.Debug("early tanks for:"..botPlayer.Name)
	if not botPlayer.IsProducing("combat_tank_a") then
		local built = false
		if botPlayer.HasPrerequisites({"heavy.harkonnen_combat"}) then
			built = botPlayer.Build(VehicleBuild["harkonnen"], function(actors)
				buildTurretsOnPowerSurplus(botPlayer)
			end)
		end
		if not built and botPlayer.HasPrerequisites({"heavy.ordos_combat"}) then
			built = botPlayer.Build(VehicleBuild["ordos"], function(actors)
				buildTurretsOnPowerSurplus(botPlayer)
			end)
		end
		if not built and botPlayer.HasPrerequisites({"heavy.atreides_combat"}) then
			built = botPlayer.Build(VehicleBuild["atreides"], function(actors)
				buildTurretsOnPowerSurplus(botPlayer)
			end)
		end
		if built then return end
	end
	Trigger.AfterDelay(100, function()
		earlyRushTanks(botPlayer)
	end)
end

enginnerMission = function(enginner)
	if enginner.IsDead then return end

	if not enginner.HasTag(BusyTag) then
		local targets = findEnemyTargets(enginner.CenterPosition, enginner.Owner, 40, "Capture", false)

		if next(targets) ~= nil then
			local token = markBusy(enginner)
			enginner.Capture(Utils.Random(targets))
			--Media.Debug("redirection to close target"..tostring(enginner))

			enginner.CallFunc(function()
				clearBusy(enginner, token, BusyTag)
			end)
		end
	end

	Trigger.AfterDelay(500, function()
		enginnerMission(enginner)
	end)
end

saboteurMission = function(saboteur)
	if saboteur.IsDead then return end

	if not saboteur.HasTag(BusyTag) then
		local targets = findEnemyTargets(saboteur.CenterPosition, saboteur.Owner, 40, "Sell", true)

		if next(targets) ~= nil then
			local token = markBusy(saboteur)
			saboteur.Demolish(Utils.Random(targets))

			saboteur.CallFunc(function()
				clearBusy(saboteur, token, BusyTag)
			end)
		end
	end

	Trigger.AfterDelay(500, function ()
		saboteurMission(saboteur)
	end)
end

function findEnemyTargets(pos, selfPlayer, distance, property, excludeNonCombatant)
    local actors = Map.ActorsInCircle(pos, WDist.FromCells(distance))
    return Utils.Where(actors, function(a)
        if not a.HasProperty(property) then return false end
        if a.Type == "wall" or
		   a.Type == "silo" or
           a.Type == "medium_gun_turret" or
		   a.Type == "large_gun_turret" then
            return false
        end
        if selfPlayer.IsAlliedWith(a.Owner) then return false end
        if excludeNonCombatant and a.Owner.IsNonCombatant then return false end
        return true
    end)
end

function trikeMicro(trike)
	if trike.IsDead or trike.HasTag(BusyTag) then return end

	Trigger.OnDamaged(trike, function(actor, attacker, damage)
		if actor.IsDead or
	       attacker.IsDead or
		   actor.Health > actor.MaxHealth * 0.6 or
		   not attacker.HasProperty("Location")
		then
			return
		end

		Trigger.ClearAll(actor)
		local retreatPos = CPos.New(actor.Location.X * 2 - attacker.Location.X, actor.Location.Y * 2 - attacker.Location.Y)

		--Media.Debug("retreating to"..tostring(retreatPos))
		actor.GrantCondition("reject-orders", 75)
		actor.Move(retreatPos)
		actor.AttackMove(attacker.Location)

		Trigger.AfterDelay(100, function()
			trikeMicro(trike)
		end)
	end)
end

function autoCrush(unit, bot)
	if unit.IsDead then
		return
	end

	if unit.HasTag(BusyTag) then
		Trigger.AfterDelay(750, function ()
			autoCrush(unit, bot)
		end)
		return
	end

	local actors = Map.ActorsInCircle(unit.CenterPosition, WDist.FromCells(4), function (a)
		return
		not a.IsDead and
		a.IsInWorld and
		not a.Owner.IsAlliedWith(bot)
	end)
	local targets = Utils.Where(actors, function(a)
		return InfantryTypes[a.Type]
	end)
	if next(targets) ~= nil then
		unit.GrantCondition("reject-orders", 50)
		unit.Move(Utils.Random(targets).Location)
		Trigger.AfterDelay(25, function ()
			autoCrush(unit, bot)
		end)
		return
	end

	Trigger.AfterDelay(100, function ()
		autoCrush(unit, bot)
	end)
end

function vehicleRepair(actor, internalName)
	if actor.IsDead or actor.HasTag(BusyTag) then return end

	if actor.Health < actor.MaxHealth * 0.4 then
		local pad = findNearestRepairPad(actor, internalName)
		if pad ~= nil then
			local token = markBusy(actor)
			--Media.Debug("send to repair_pad "..tostring(actor))
			actor.Move(pad.Location + CVec.New(1,1), 2)

			actor.CallFunc(function ()
				clearBusy(actor, token, BusyTag)
			end)
		end
	end

	Trigger.AfterDelay(500, function()
		vehicleRepair(actor, internalName)
	end)
end

function findNearestRepairPad(actor, internalName)
	local pads = RepairPads[internalName]
	if pads == nil then
		return nil
	end

	local loc = actor.Location
	local best, bestDist = nil, math.huge
	local alive = {}

	for _, pad in ipairs(pads) do
		if not pad.IsDead then
			table.insert(alive, pad)
			local ploc = pad.Location
			local dx = math.abs(loc.X - ploc.X)
			local dy = math.abs(loc.Y - ploc.Y)
			local d = math.max(dx, dy)
			if d < bestDist then
				best, bestDist = pad, d
			end
		end
	end

	RepairPads[internalName] = alive

	return best
end

function wormSpawnFunction(owner)
	for _, spawner in ipairs(owner.GetActorsByType("wormspawner")) do
		if spawner.AcceptsCondition("worm-spam-delayed") then
			spawner.GrantCondition("worm-spam-delayed")
		end
	end
end

function botEconomyStrategy()
	botHarvesterCheck()
	botCarryallCheck()
	botRefineryCheck()
	botRefinerySellCheck()
end

function botHarvesterCheck()
	for _, player in ipairs(ActivePlayers) do
		if player.IsBot then
			local harvesters = player.GetActorsByType("harvester")
			if #harvesters <= 40 then
				player.Build({"harvester", "harvester"})
			end
		end
	end
	Trigger.AfterDelay(DateTime.Seconds(60), botHarvesterCheck)
end

function botCarryallCheck()
	for _, player in ipairs(ActivePlayers) do
		if player.IsBot then
			local harvesters = player.GetActorsByType("harvester")
			local carryalls = player.GetActorsByType("carryall")
			if #carryalls <= #harvesters * 2 / 3 then
				player.Build({"carryall", "carryall"})
			end
		end
	end
	Trigger.AfterDelay(DateTime.Seconds(60), botCarryallCheck)
end

function botRefineryCheck()
	for _, player in ipairs(ActivePlayers) do
		if player.IsBot then
			if player.PowerProvided - player.PowerDrained >= 100 then
				local harvesters = player.GetActorsByType("harvester")
				if #harvesters <= 70 then
					local refType = Utils.Random({"refinery", "refinery_inverted"})
					player.Build({refType})
				end
			end
		end
	end
	Trigger.AfterDelay(DateTime.Seconds(30), botRefineryCheck)
end

function botRefinerySellCheck()
	for _, player in ipairs(ActivePlayers) do
		if player.IsBot then
			local ratio = player.Resources / player.ResourceCapacity
			if ratio < 0.2 then
				local refs = player.GetActorsByTypes({"refinery", "refinery_inverted"})
				for i = 10, #refs do
					local victim = Utils.Random(refs)
					victim.Sell()
					for j, r in ipairs(refs) do
						if r == victim then
							table.remove(refs, j)
							break
						end
					end
				end
			end
		end
	end
	Trigger.AfterDelay(DateTime.Seconds(60), botRefinerySellCheck)
end

function botLateGameStrategy()
	for _, player in ipairs(ActivePlayers) do
		tryLateGameBuild(player)
	end
	Trigger.AfterDelay(6000, botLateGameStrategy)
end

function tryLateGameBuild(player)
	if not player.IsBot then return end
	if player.Resources < 10000 then return end
	if not player.HasPrerequisites({"research_centre"}) then return end

	local buildTable = LateGameBuild[player.Faction]
	if buildTable == nil then return end

	if not player.IsProducing(buildTable[1]) then
		local ok = player.Build(buildTable)
		if not ok then
			Trigger.AfterDelay(100, function()
				tryLateGameBuild(player)
			end)
		end
	end
end
