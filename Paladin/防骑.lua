local queue = {
	"Crusader Aura",
	"Pause",
	"UseHpPotions",
	"HandofSalvation",
	"HammerofJustice",
	"HandofSacrifice",
	"LayonHands",
	"HandofProtection",
	"Seal",
	"DevotionAura",
	"Fury",
	 --正义之怒
	"DivineProtection",
	 --圣佑术
	"agro",
	 --拉仇恨
	"SacredShield",
	"Holy Sheild",
	 --神圣之盾
	"DivinePlea",
	 --神圣恳求
	"Cleanse",
	 --清洁
	"Hammer of the Righteous",
	"Shield of the Righteous",
	"Hammer of Wrath",
	"Avengers Shield",
	"Crusader Strike",
	"ShieldoftheRighteous",
	"Judgement",
	"Consecration",
	"Holy Wrath",
	"AvengingWrath"
}
local enables = {
	["HolyWrath"] = false,
	["DivinePlea"] = true,
	["HolyShield"] = true,
	["Cleanse"] = true,
	["GuardianofAncientKings"] = true,
	["ArdentDefender"] = true,
	["DivineProtection"] = true,
	["HammerofJustice"] = true,
	["LayonHands"] = true,
	["HandofProtection"] = true,
	["UseHpPotions"] = true,
	["HandofSacrifice"] = true,
	["agro"] = true,
	["HandofSalvation"] = true,
	["Consecration"] = true,
	["logs"] = true
}
local values = {
	["HolyWrath"] = 4,
	["DivinePlea"] = 60,
	["HolyShield"] = 80,
	["DivineProtection"] = 75,
	["GuardianofAncientKings"] = 50,
	["ArdentDefender"] = 25,
	["HammerofJustice"] = 60,
	["LayonHands"] = 20,
	["HandofProtection"] = 20,
	["UseHpPotions"] = 50,
	["HandofSacrifice"] = 60,
	["HandofSalvation"] = 50,
	["Consecration"] = 2
}
local inputs = {}
local fushi, mingling, zhengyi, zhihui, guangming =
	"|cffFFFF33腐蚀圣印",
	"|cffBF211E命令圣印",
	"|cff24E0FB正义圣印",
	"|cff7189ff智慧圣印",
	"|cffE6FDFF光明圣印"
local guangmingshenpan, zhihuishenpan = "|cffFFFF33光明审判", "|cff24E0FB智慧审判"

local menus = {
	["Seal"] = 1,
	["Judgements"] = 1
}
local function GUICallback(key, item_type, value)
	if item_type == "enabled" then
		enables[key] = value
	elseif item_type == "value" then
		values[key] = value
	elseif item_type == "input" then
		inputs[key] = value
	elseif item_type == "menu" then
		menus[key] = value
	end
end

local items = {
	settingsfile = "prot_cata.xml",
	callback = GUICallback,
	{type = "title", text = "防骑"},
	{type = "separator"},
	{type = "title", text = "选    项"},
	{
		type = "dropdown",
		menu = {
			{
				selected = (menus["Seal"] == 1),
				value = 1,
				text = fushi
			},
			{
				selected = (menus["Seal"] == 2),
				value = 2,
				text = guangming
			},
			{
				selected = (menus["Seal"] == 3),
				value = 3,
				text = mingling
			},
			{
				selected = (menus["Seal"] == 4),
				value = 4,
				text = zhengyi
			}
		},
		key = "Seal"
	},
	{
		type = "dropdown",
		menu = {
			{
				selected = (menus["Judgements"] == 1),
				value = 1,
				text = guangmingshenpan
			},
			{
				selected = (menus["Judgements"] == 2),
				value = 2,
				text = zhihuishenpan
			}
		},
		key = "Judgements"
	},
	{type = "separator"},
	{
		type = "entry",
		text = "仇恨拉怪",
		tooltip = "清算，正义防御拉怪",
		enabled = enables["agro"],
		key = "agro"
	},
	{
		type = "entry",
		text = "\124T" .. GetItemIcon(33447) .. ":26:26\124t " .. "|cffff2020生命药水",
		tooltip = "当HP小于或等于设置的数值百分比时\n|cffff2020需要注意的是|cfff6cc00:生命药水 和 魔法药水是共同CD,看你如何选择了.",
		enabled = true,
		value = 50,
		width = 50,
		key = "UseHpPotions"
	},
	{
		type = "entry",
		text = "神圣恳求",
		tooltip = "神圣恳求",
		enabled = enables["DivinePlea"],
		value = values["DivinePlea"],
		width = 50,
		key = "DivinePlea"
	},
	{
		type = "entry",
		text = "拯救之手",
		tooltip = "拯救之手",
		enabled = enables["HandofSalvation"],
		value = values["HandofSalvation"],
		width = 50,
		key = "HandofSalvation"
	},
	{
		type = "entry",
		text = "圣佑术",
		tooltip = "圣佑术",
		enabled = enables["DivineProtection"],
		value = values["DivineProtection"],
		width = 50,
		key = "DivineProtection"
	},
	{
		type = "entry",
		text = "牺牲之手",
		tooltip = "牺牲之手",
		enabled = enables["HandofSacrifice"],
		value = values["HandofSacrifice"],
		width = 50,
		key = "HandofSacrifice"
	},
	{
		type = "entry",
		text = "圣疗术",
		tooltip = "圣疗术",
		enabled = enables["LayonHands"],
		value = values["LayonHands"],
		width = 50,
		key = "LayonHands"
	},
	{
		type = "entry",
		text = "保护之手",
		tooltip = "保护之手（焦点）",
		enabled = enables["HandofProtection"],
		value = values["HandofProtection"],
		width = 50,
		key = "HandofProtection"
	},
	{
		type = "entry",
		text = "神圣之盾",
		tooltip = "神圣之盾",
		enabled = enables["HolyShield"],
		value = values["HolyShield"],
		width = 50,
		key = "HolyShield"
	},
	{
		type = "entry",
		text = "制裁之锤",
		tooltip = "打断周围的目标施法",
		enabled = enables["HammerofJustice"],
		value = values["HammerofJustice"],
		width = 50,
		key = "HammerofJustice"
	},
	{
		type = "entry",
		text = "奉献",
		enabled = enables["Consecration"],
		value = values["Consecration"],
		width = 50,
		key = "Consecration"
	},
	{
		type = "entry",
		text = "神圣愤怒",
		tooltip = "神圣愤怒",
		enabled = enables["HolyWrath"],
		value = values["HolyWrath"],
		width = 50,
		key = "HolyWrath"
	},
	{
		type = "entry",
		text = "清洁术",
		tooltip = "驱散自己",
		enabled = enables["Cleanse"],
		key = "Cleanse"
	},
	{
		type = "entry",
		text = "喊话",
		enabled = enables["logs"],
		key = "logs"
	}
	--[[ 	
	{ type = "title", text = "Defensive CD's" },
	{
		type = "entry",
		text = "Ardent Defender",
		tooltip = "The players health pct before using Ardent Defender",
		enabled = enables["ArdentDefender"],
		value = values["ArdentDefender"],
		key = "ArdentDefender"
	},

	{
		type = "entry",
		text = "Guardian of Ancient Kings",
		tooltip = "The players health pct before using Guardian of Ancient Kings",
		enabled = enables["GuardianofAncientKings"],
		value = values["GuardianofAncientKings"],
		key = "GuardianofAncientKings"
	},
	
	{type = "separator" },

	{ type = "separator" },
 ]]
}
local incombat = false
local function CombatEventCatcher(event, ...)
	if event == "PLAYER_REGEN_DISABLED" then
		incombat = true
	elseif event == "PLAYER_REGEN_ENABLED" then
		incombat = false
	end
end
local function OnLoad()
	ni.combatlog.registerhandler("Prot-Cata", CombatEventCatcher)
	ni.GUI.AddFrame("Prot-Cata", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("Prot-Cata")
	ni.GUI.DestroyFrame("Prot-Cata")
end

local spells = {
	--General
	AutoAttack = {id = 6603, name = GetSpellInfo(6603)},
	EveryManforHimself = {id = 59752, name = GetSpellInfo(59752)},
	--Holy
	Cleanse = {id = 4987, name = GetSpellInfo(4987)},
	ConcentrationAura = {id = 19746, name = GetSpellInfo(19746)},
	Consecration = {id = 26573, name = GetSpellInfo(26573)},
	DivineLight = {id = 82326, name = GetSpellInfo(82326)},
	DivinePlea = {id = 54428, name = GetSpellInfo(54428)},
	Exorcism = {id = 879, name = GetSpellInfo(879)},
	FlashofLight = {id = 19750, name = GetSpellInfo(19750)},
	HolyLight = {id = 635, name = GetSpellInfo(635)},
	HolyRadiance = {id = 82327, name = GetSpellInfo(82327)},
	HolyWrath = {id = 2812, name = GetSpellInfo(2812)},
	LayonHands = {id = 633, name = GetSpellInfo(633)},
	Redemption = {id = 7328, name = GetSpellInfo(7328)},
	SealofInsight = {id = 20165, name = GetSpellInfo(20165)},
	 --光明圣印
	SealofWisdom = {id = 20166, name = GetSpellInfo(20166)},
	 --智慧圣印
	TurnEvil = {id = 10326, name = GetSpellInfo(10326)},
	--Protection
	ArdentDefender = {id = 31850, name = GetSpellInfo(31850)},
	AvengersShield = {id = 31935, name = GetSpellInfo(31935)},
	 --复仇者之盾
	BlessingofKings = {id = 20217, name = GetSpellInfo(20217)},
	DevotionAura = {id = 48942, name = GetSpellInfo(48942)},
	 --虔诚光环
	DivineGuardian = {id = 70940, name = GetSpellInfo(70940)},
	DivineProtection = {id = 498, name = GetSpellInfo(498)},
	DivineShield = {id = 642, name = GetSpellInfo(642)},
	GuardianofAncientKings = {id = 86150, name = GetSpellInfo(86150)},
	HammerofJustice = {id = 853, name = GetSpellInfo(853)},
	 --制裁之锤
	HammeroftheRighteous = {id = 53595, name = GetSpellInfo(53595)},
	HandofFreedom = {id = 1044, name = GetSpellInfo(1044)},
	HandofProtection = {id = 1022, name = GetSpellInfo(1022)},
	HandofReckoning = {id = 62124, name = GetSpellInfo(62124)},
	HandofSacrifice = {id = 6940, name = GetSpellInfo(6940)},
	HandofSalvation = {id = 1038, name = GetSpellInfo(1038)},
	HolyShield = {id = 20925, name = GetSpellInfo(20925)},
	ResistanceAura = {id = 19891, name = GetSpellInfo(19891)},
	RighteousDefense = {id = 31789, name = GetSpellInfo(31789)},
	RighteousFury = {id = 25780, name = GetSpellInfo(25780)},
	SealofJustice = {id = 20164, name = GetSpellInfo(20164)},
	SealofRighteousness = {id = 21084, name = GetSpellInfo(21084)},
	 --正义圣印
	SealofCommand = {id = 20375, name = GetSpellInfo(20375)},
	 --命令圣印
	ShieldoftheRighteous = {id = 53600, name = GetSpellInfo(53600)},
	SacredShield = {id = 53601, name = GetSpellInfo(53601)},
	--Retribution
	AvengingWrath = {id = 31884, name = GetSpellInfo(31884)},
	BlessingofMight = {id = 19740, name = GetSpellInfo(19740)},
	CrusaderAura = {id = 32223, name = GetSpellInfo(32223)},
	CrusaderStrike = {id = 35395, name = GetSpellInfo(35395)},
	HammerofWrath = {id = 24275, name = GetSpellInfo(24275)},
	Judgement = {id = 20271, name = GetSpellInfo(20271)},
	wisdomJudgement = {id = 53408, name = GetSpellInfo(53408)},
	RetributionAura = {id = 7294, name = GetSpellInfo(7294)},
	SealofTruth = {id = 31801, name = GetSpellInfo(31801)},
	HolyVengeance = {id = 31803, name = GetSpellInfo(31803)}
}

local item = {
	food = GetSpellInfo(433),
	drink = {a = GetSpellInfo(27089), b = GetSpellInfo(43183)},
	runicmanapotion = GetItemInfo(33448),
	hppotions = {36894, 36892, 33447, 40087, 39671, 22829, 13446, 9421, 3928, 1710}
}

local enemies = {}

local function ActiveEnemies()
	table.wipe(enemies)
	enemies = ni.player.enemiesinrange(10)
	for k, v in ipairs(enemies) do
		if ni.player.threat(v.guid) == -1 then
			table.remove(enemies, k)
		end
	end
	return #enemies
end

local function FacingLosCast(spell, tar)
	if ni.player.isfacing(tar, 145) and ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
		ni.spell.cast(spell, tar)
		return true
	end
	return false
end

local function ValidUsable(id, tar)
	if ni.spell.available(id) and ni.spell.valid(tar, id, true, true) then
		return true
	end
	return false
end
--25771 自律 LayonHands
local abilities = {
	["Pause"] = function()
		if
			IsMounted() or UnitIsDeadOrGhost("player") or not UnitExists("target") or UnitIsDeadOrGhost("target") or
				ni.unit.buff("player", item.food) or
				ni.unit.buff("player", item.drink.a) or
				ni.unit.buff("player", item.drink.b) or
				ni.unit.isstunned("player") or
				ni.unit.issilenced("player") or
				(UnitExists("target") and not UnitCanAttack("player", "target"))
		 then
			return true
		end
	end,
	["UseHpPotions"] = function()
		if enables["UseHpPotions"] then
			for v, i in ipairs(item.hppotions) do
				if
					(i ~= 0 and i ~= nil) and ni.player.hasitem(i) and ni.player.itemcd(i) == 0 and
						ni.player.hp() < values["UseHpPotions"]
				 then
					ni.player.useitem(i)
					return true
				end
			end
		end
	end,
	["agro"] = function()
		if
			ni.unit.exists("target") and incombat and ni.spell.cd(spells.RighteousDefense.id) and
				not UnitIsUnit("targettarget", "player") and
				ni.spell.available(spells.HandofReckoning.id) and
				ni.spell.valid("target", spells.HandofReckoning.id, true, true)
		 then
			ni.spell.cast(spells.HandofReckoning.id, "target")
			lastTime = GetTime()
			return true
		end
		if
			ni.unit.exists("target") and incombat and GetTime() - lastTime > 0.5 and not UnitIsUnit("targettarget", "player") and
				not ni.spell.available(spells.HandofReckoning.id) and
				ni.spell.cd(spells.HandofReckoning.id) and
				ni.spell.available(spells.RighteousDefense.id) and
				ni.spell.valid("target", spells.RighteousDefense.id, true, true)
		 then
			ni.spell.cast(spells.RighteousDefense.name, "target")
		end
	end,
	--拯救之手
	["HandofSalvation"] = function()
		if enables["HandofSalvation"] and incombat then
			if ni.player.hp() < values["HandofSalvation"] and ni.spell.available(spells.HandofSalvation.id) then
				ni.spell.cast(spells.HandofSalvation.name)
				return true
			end
		end
	end,
	--复仇之怒
	["AvengingWrath"] = function()
		if
			incombat and ni.unit.isboss("target") and ni.spell.available(spells.HolyVengeance.id) and
				ni.unit.debuffstacks("target", spells.HolyVengeance.name, "player") >= 4
		 then
			ni.spell.cast(spells.AvengingWrath.name)
			return true
		end
	end,
	["HandofSacrifice"] = function()
		if enables["HandofSacrifice"] and incombat then
			for i = 1, #ni.members do
				if
					not ni.members[i].istank and ni.player.hp() > 60 and ni.members[i].hp < values["HandofSacrifice"] and
						ni.spell.available(spells.HandofSacrifice.id) and
						ni.spell.valid(ni.members[i].unit, spells.HandofSacrifice.id, false, true, true)
				 then
					ni.spell.cast(spells.HandofSacrifice.id, ni.members[i].unit)
					if enables["logs"] then
						ni.player.runtext("/s " .. GetSpellLink(spells.HandofSacrifice.id) .. "on @" .. ni.members[i].name)
					end
					return true
				end
			end
		end
	end,
	["LayonHands"] = function()
		if enables["LayonHands"] and incombat then
			for i = 1, #ni.members do
				if
					ni.members[i].hp < values["LayonHands"] and not ni.unit.debuff(ni.members[i].unit, 25771) and
						ni.spell.available(spells.LayonHands.id) and
						ni.spell.valid(ni.members[i].unit, spells.LayonHands.id, false, true, true)
				 then
					ni.spell.cast(spells.LayonHands.name, ni.members[i].unit)
					if enables["logs"] then
						ni.player.runtext("/s " .. GetSpellLink(spells.LayonHands.id) .. "on @" .. ni.members[i].name)
					end
					return true
				end
			end
		end
	end,
	["HandofProtection"] = function()
		if enables["HandofProtection"] and incombat then
			for i = 1, #ni.members do
				if
					ni.members[i].hp < values["HandofProtection"] and not ni.members[i].istank and
						not ni.unit.debuff(ni.members[i].unit, 25771) and
						ni.spell.available(spells.HandofProtection.id) and
						ni.spell.valid(ni.members[i].unit, spells.HandofProtection.id, false, true, true)
				 then
					ni.spell.cast(spells.HandofProtection.name, ni.members[i].unit)
					if enables["logs"] then
						ni.player.runtext("/s " .. GetSpellLink(spells.HandofProtection.id) .. "on @" .. ni.members[i].name)
					end
					return true
				end
			end
		end
	end,
	["Seal"] = function()
		local s = menus["Seal"]
		if
			ni.player.power("mana") < 20 and ni.spell.available(spells.SealofWisdom.id) and
				not ni.player.buff(spells.SealofWisdom.id)
		 then
			ni.spell.cast(spells.SealofWisdom.name)
			return true
		end
		--腐蚀
		if
			s == 1 and ni.player.power("mana") > 90 and ni.spell.available(spells.SealofTruth.id) and
				not ni.player.buff(spells.SealofTruth.id)
		 then
			ni.spell.cast(spells.SealofTruth.name)
			return true
		end
		--光明
		if
			s == 2 and ni.player.power("mana") > 90 and ni.spell.available(spells.SealofInsight.id) and
				not ni.player.buff(spells.SealofInsight.id)
		 then
			ni.spell.cast(spells.SealofInsight.name)
			return true
		end
		--命令
		if
			s == 3 and ni.player.power("mana") > 80 and ni.spell.available(spells.SealofCommand.id) and
				not ni.player.buff(spells.SealofCommand.id)
		 then
			ni.spell.cast(spells.SealofCommand.name)
			return true
		end
		--正义
		if
			s == 4 and ni.player.power("mana") > 90 and ni.spell.available(spells.SealofRighteousness.id) and
				not ni.player.buff(spells.SealofRighteousness.id)
		 then
			ni.spell.cast(spells.SealofRighteousness.name)
			return true
		end
	end,
	--圣洁护盾
	["SacredShield"] = function()
		if
			incombat and ni.unit.buffremaining("player", spells.SacredShield.id) < 2 and
				ni.spell.available(spells.SacredShield.id)
		 then
			ni.spell.cast(spells.SacredShield.name)
			return true
		end
	end,
	["DivinePlea"] = function()
		if
			enables["DivinePlea"] and ni.spell.available(spells.DivinePlea.id) and
				ni.player.power("mana") <= values["DivinePlea"]
		 then
			ni.spell.cast(spells.DivinePlea.name)
			return true
		end
	end,
	["DevotionAura"] = function()
		if not ni.player.buff(spells.DevotionAura.id) and ni.spell.available(spells.DevotionAura.id) then
			ni.spell.cast(spells.DevotionAura.name)
			return true
		end
	end,
	["Crusader Aura"] = function()
		if IsMounted() and not ni.player.buff(spells.CrusaderAura.id) then
			ni.spell.cast(spells.CrusaderAura.name)
			return true
		end
	end,
	["Fury"] = function()
		if not ni.player.buff(spells.RighteousFury.id) and ni.spell.available(spells.RighteousFury.id) then
			ni.spell.cast(spells.RighteousFury.name)
			return true
		end
	end,
	["Auto Attack"] = function()
		if not IsCurrentSpell(6603) then
			ni.spell.cast(6603)
		end
	end,
	["Holy Sheild"] = function()
		if
			enables["HolyShield"] and ni.spell.available(spells.HolyShield.id) and incombat and
				ni.player.hp() <= values["HolyShield"] and
				ActiveEnemies() >= 1
		 then
			ni.spell.cast(spells.HolyShield.name)
			return true
		end
	end,
	--圣佑术
	["DivineProtection"] = function()
		if
			enables["DivineProtection"] and incombat and ni.spell.available(spells.DivineProtection.id) and
				ni.player.hp() <= values["DivineProtection"] and
				ActiveEnemies() >= 1
		 then
			ni.spell.cast(spells.DivineProtection.name)
			return true
		end
	end,
	["Hammer of the Righteous"] = function()
		if
			ValidUsable(spells.HammeroftheRighteous.id, "target") and ActiveEnemies() >= 2 and
				FacingLosCast(spells.HammeroftheRighteous.name, "target")
		 then
			return true
		end
	end,
	["Avengers Shield"] = function()
		if
			ni.player.power("mana") > 40 and ValidUsable(spells.AvengersShield.id, "target") and
				FacingLosCast(spells.AvengersShield.name, "target")
		 then
			return true
		end
	end,
	["ShieldoftheRighteous"] = function()
		if ValidUsable(spells.ShieldoftheRighteous.id, "target") and FacingLosCast(spells.ShieldoftheRighteous.name, "target") then
			return true
		end
	end,
	["Hammer of Wrath"] = function()
		if
			ValidUsable(spells.HammerofWrath.id, "target") and IsUsableSpell(spells.HammerofWrath.name) and
				ni.unit.hp("target") < 20 and
				ni.player.power("mana") > 20 and
				FacingLosCast(spells.HammerofWrath.name, "target")
		 then
			return true
		end
	end,
	["Crusader Strike"] = function()
		if ValidUsable(spells.CrusaderStrike.id, "target") and FacingLosCast(spells.CrusaderStrike.name, "target") then
			return true
		end
	end,
	["Judgement"] = function()
		local s = menus["Judgements"]
		if s == 1 and ValidUsable(spells.Judgement.id, "target") and FacingLosCast(spells.Judgement.name, "target") then
			return true
		end
		if
			s == 2 and ValidUsable(spells.wisdomJudgement.id, "target") and FacingLosCast(spells.wisdomJudgement.name, "target")
		 then
			return true
		end
	end,
	["Consecration"] = function()
		if
			enables["Consecration"] and incombat and ni.player.power("mana") > 30 and ni.spell.available(spells.Consecration.id) and
				ActiveEnemies() >= values["Consecration"]
		 then
			ni.spell.cast(spells.Consecration.name)
			return true
		end
	end,
	["Holy Wrath"] = function()
		local cd = ni.spell.cd(spells.HolyWrath.id)
		if
			enables["HolyWrath"] and cd == 0 and incombat and ni.spell.available(spells.HolyWrath.id) and
				ActiveEnemies() >= values["HolyWrath"]
		 then
			ni.spell.cast(spells.HolyWrath.name)
			return true
		end
	end,
	["Cleanse"] = function()
		if enables["Cleanse"] and ni.spell.available(spells.Cleanse.id) and ni.healing.candispel("player") then
			ni.spell.cast(spells.Cleanse.name)
			return true
		end
	end,
	["HammerofJustice"] = function()
		if enables["HammerofJustice"] and ni.spell.available(spells.HammerofJustice.id) then
			local enemies = ni.player.enemiesinrange(10)
			for i = 1, #enemies do
				local InterruptTargets = enemies[i].guid
				if
					ni.spell.shouldinterrupt(InterruptTargets, values["HammerofJustice"]) and not ni.unit.isboss(InterruptTargets) and
						ni.spell.valid(InterruptTargets, spells.HammerofJustice.id, true, true)
				 then
					ni.spell.cast(spells.HammerofJustice.name, InterruptTargets)
					return true
				end
			end
		end
	end
}
ni.bootstrap.profile("防骑", queue, abilities, OnLoad, OnUnload)
