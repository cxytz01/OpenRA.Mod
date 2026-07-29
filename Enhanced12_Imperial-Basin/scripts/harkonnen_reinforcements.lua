---------------------------------------
---Sardaukar Reinforcements------------
---------------------------------------

SardaukarReinforcements = {}
SardaukarInterval = 2313
SardaukarUnits = {"bombardment_tank", "sardaukar", "sardaukar.level1", "sardaukar.level2", "sardaukar.level3"}

local function SpawnSardaukarReinforcements(player)
	local allPalaces = player.GetActorsByType("palace.corrino")
	local alive = {}
	for _, p in ipairs(allPalaces) do
		if not p.IsDead then
			table.insert(alive, p)
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

	Media.PlaySpeechNotification(player, "Reinforce")
	for i, unitType in ipairs(SardaukarUnits) do
		Trigger.AfterDelay(i - 1, function()
			picked.Produce(unitType, nil, "Sardaukar")
		end)
	end
end

local function StartSardaukarReinforcements(player)
	local internalName = player.InternalName
	if SardaukarReinforcements[internalName] then
		return
	end
	SardaukarReinforcements[internalName] = true
	SpawnSardaukarReinforcements(player)

	local function loop()
		if SardaukarReinforcements[internalName] == nil then return end
		local palaces = player.GetActorsByType("palace.corrino")
		for _, p in ipairs(palaces) do
			if not p.IsDead then
				SpawnSardaukarReinforcements(player)
				Trigger.AfterDelay(SardaukarInterval, loop)
				return
			end
		end
		SardaukarReinforcements[internalName] = nil
	end
	Trigger.AfterDelay(SardaukarInterval, loop)
end

-- Called from Tick() in scripts.lua
DetectSardaukarReinforcements = function(activePlayers)
	for _, p in ipairs(activePlayers) do
		if SardaukarReinforcements[p.InternalName] == nil then
			local palaces = p.GetActorsByType("palace.corrino")
			for _, palace in ipairs(palaces) do
				if not palace.IsDead then
					StartSardaukarReinforcements(p)
					break
				end
			end
		end
	end
end
