local immovableBuffIds = {58984, 32612, 11392, 433, 430, 48400, 58823, 52696, 55041, 51240}
local invulnerableBuffIds = {69051, 59301, 45438, 40733, 33786, 30940, 21892, 19263, 1022}
local invulnerableDebuffIds = {33786, 18647, 10955}
local stunDebuffIds = {70157, 52509, 51750, 35856, 33173, 19134, 66547, 53365, 59365, 52524, 69645, 56935, 60236}
local transformableBuffIds = {52509, 12826, 13323, 58537}
local cantAttackDebuffs = {69172}
local doNotDissipateItIds = {70336,15530,56775,56837,12737,38384,15244,30633,47698,57050,15063,61462,57825,61461,59251,59258,59253}

local membersInRange = {}
local membersBelow = {}
local activeEnemies = {}

local functions = {
	members = {}
}


function functions.CombatEventCatcher(event, ...)
	if event == "PLAYER_REGEN_DISABLED" then
		inc = true;
	elseif event == "PLAYER_REGEN_ENABLED" then
		inc = false;
	end
end

function functions.members.inrange(unit, distance)
	table.wipe(membersInRange)
	for _, member in ipairs(ni.members) do
		local unitDistance = ni.unit.distance(member.unit, unit)
		if unitDistance ~= nil and unitDistance <= distance then
			tinsert(membersInRange, member)
		end
	end

	table.sort(
		membersInRange,
		function(x, y)
			return x.hp < y.hp
		end
	)

	return membersInRange
end

function functions.members.inrangebelow(unit, distance, hp)
	table.wipe(membersBelow)
	for _, v in ipairs(functions.members.inrange(unit, distance)) do
		if v.hp < hp then
			tinsert(membersBelow, v)
		end
	end
	return membersBelow
end

function functions.filter(incommingTable, callback)
	local out = {}

	for k, v in pairs(incommingTable) do
		if callback(v, k, incommingTable) then
			table.insert(out, v)
		end
	end

	return out
end

function functions.LosCast(spellName, target)
	if ni.player.los(target) and IsSpellInRange(spellName, target) == 1 then
		ni.spell.cast(spellName, target)
		ni.debug.log(string.format("释放 %s 给 %s", spellName, target))
		return true
	end
	return false
end

function functions.FacingLosCast(spellName, target)
	if ni.player.isfacing(target, true) and functions.LosCast(spellName, target) then
		return true
	end
	return false
end

function functions.ValidUsable(id, tar)
	if ni.spell.available(id) and ni.spell.valid(tar, id, true, true) then
		return true
	end
	return false
end

function functions.ActiveEnemies()
	table.wipe(activeEnemies)
	activeEnemies = ni.player.enemiesinrange(7)

	for k, v in ipairs(activeEnemies) do
		if ni.player.threat(v.guid) == -1 then
			table.remove(activeEnemies, k)
		end
	end

	return #activeEnemies
end

function functions.ImmovableBuffActive(target)
	return ni.unit.buffs(target, table.concat(immovableBuffIds, "||"), "EXACT")
end

function functions.unitIsTransformed(target)
	return ni.unit.buffs(target, table.concat(transformableBuffIds, "||"), "EXACT")
end

function functions.InvulnerableDebuffActive(target)
	return ni.unit.debuffs(target, table.concat(invulnerableDebuffIds, "||"), "EXACT")
end

function functions.InvulnerableBuffActive(target)
	return ni.unit.buffs(target, table.concat(invulnerableBuffIds, "||"), "EXACT") or
		functions.InvulnerableDebuffActive("target")
end

function functions.StunDebuffActive(target)
	return ni.unit.debuffs(target, table.concat(stunDebuffIds, "||"), "EXACT")
end

function functions.cantAttackDebuffActive(target)
	return ni.unit.debuffs(target, table.concat(cantAttackDebuffs, "||"), "EXACT")
end

function functions.doNotDissipateIt(target)
	return ni.unit.debuffs(target, table.concat(doNotDissipateItIds, "||"), "EXACT")
end

function functions.StopNi()
	return UnitIsDeadOrGhost("target") or UnitIsDeadOrGhost("player") or UnitChannelInfo("player") ~= nil or IsMounted() or
		UnitCastingInfo("player") ~= nil or
		ni.vars.combat.casting == true or
		UnitInVehicle("player") or
		functions.ImmovableBuffActive("player") or
		functions.unitIsTransformed("player") or
		functions.InvulnerableBuffActive("target") or
		functions.StunDebuffActive("player") or
		functions.cantAttackDebuffActive("player") or
		ni.unit.issilenced("player")
end

function functions.youInInstance(type)
	return IsInInstance() and select(2, GetInstanceInfo()) == type
end

function functions.TotemTimeRemaining(slot, name)
	if not HasTotem(slot, name) then
		return 0
	end
	local _, _, startTime, duration = GetTotemInfo(slot)
	return startTime + duration - GetTime()
end


function functions.FacingLosCast(spell, tar)
	if ni.player.isfacing(tar, 145) and ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
		ni.spell.cast(spell, tar)
		ni.debug.log(spell)
		return true
	end
	return false
end

local enemies = {}
local function ActiveEnemies(range)
	table.wipe(enemies)
	enemies = ni.player.enemiesinrange(range)
	for k, v in ipairs(enemies) do
		if ni.player.threat(v.guid) == -1 then
			table.remove(enemies, k)
		end
	end
	return #enemies
end

return functions
