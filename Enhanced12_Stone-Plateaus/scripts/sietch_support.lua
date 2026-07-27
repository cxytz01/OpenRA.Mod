-- When a fremen_sietch reaches Heavy damage (HP <= 50%), automatically produces 17 fremen
-- from the sietch's exits. Each sietch triggers only once per game.

SietchEmergencyTriggered = {}

function StartSietchEmergencyProduction(sietch)
	for i = 1, 17 do
		Trigger.AfterDelay(i - 1, function()
			if not sietch.IsDead then
				sietch.Produce("fremen")
			end
		end)
	end
end

function RegisterSietchDamageHandler(sietch)
	local key = tostring(sietch)
	Trigger.OnDamaged(sietch, function(actor, attacker, damage)
		if SietchEmergencyTriggered[key] then return end
		if actor.IsDead then return end
		if actor.Health > actor.MaxHealth * 0.5 then return end
		SietchEmergencyTriggered[key] = true
		Trigger.ClearAll(actor)
		StartSietchEmergencyProduction(actor)
	end)
end
