local functions = ni.utils.require("jmxFunctions")
local spells = ni.utils.require("jmxHunterSpells")
local queue = {
	"FeedPet",
	"Pause",
	"autotarget",
	"Cache",
	"wudao", --误导
	"Deterrence", --威慑
	"FeignDeath", --假死
	"AspectoftheHawk", --雄鹰守护, 包含龙鹰守护
	"AspectoftheViper", --蝰蛇 守护
	"PetControl",
	"Intimidation", --宠物胁迫
	"KillShot", --杀戮射击
	"ChimeraShot", --奇美拉射击
	"ArcaneShot", --奥术射击
	"MultiShot", --多重射击
	"Volley", --乱射
	"HuntersMark", --猎人印记
	"BestialWrath", --
	"SerpentSting", --毒蛇钉刺
	"ConcussiveShot", --震荡射击(逃跑)
	--	"FreezingArrow", --冰冻之箭(生存)
	"SteadyShot", --稳固射击
	--	"BlackArrow", --黑箭(生存)
	"TranquilizingShot", --宁神射击
	"RaptorStrike", --近战 猛禽一击
	"MongooseBite", --猫鼬撕咬
	"shuaiban", --摔绊
	"Disengage", --逃脱
	"SnakeTrap", -- 毒蛇陷阱
	"ExplosiveTrap", --献祭爆炸陷阱
	"FreezingTrap", --冰冻冰霜陷阱
	"AutoAttack", --自动攻击
	"Berserking", --种族狂暴
	"RapidFire", --急速射击
	"KillCommand" --杀戮命令(宠物)
}

local enables = {
	["AspectoftheHawk"] = true,
	["AspectoftheViper"] = true,
	["ConcussiveShot"] = true,
	["MultiShot"] = true,
	["Volley"] = true,
	["Intimidation"] = true,
	["Petatt"] = true,
	["FeignDeath"] = true,
	["TranquilizingShot"] = true,
	["Deterrence"] = true,
	["Disengage"] = true,
	["RaptorStrike"] = true,
	["ExplosiveTrap"] = true,
	["SnakeTrap"] = true,
	["FreezingTrap"] = true,
	["wudao"] = true,
	["MongooseBite"] = true,
	["shuaiban"] = true,
	["autotarget"] = true,
	["KillShot"] = true
}
local values = {
	["PetFood"] = 0,
	["Volley"] = 4,
	["MultiShot"] = 2,
	["AspectoftheHawk"] = 85,
	["AspectoftheViper"] = 15,
	["FeignDeath"] = 20,
	["Deterrence"] = 40,
	["ExplosiveTrap"] = 2,
	["FreezingTrap"] = 4
}

local inputs = {}
local menus = {}
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
	settingsfile = "MySurviveHunter.xml",
	callback = GUICallback,
	{type = "title", text = "|cff00ccff生存猎人"},
	{type = "separator"},
	{type = "page", number = 1, text = "|cffFFFF00主要设置|r"},
	{type = "separator"},
	--{ type = "title", text = "|cff00ccff主要配置" },
	{
		--设置 守护--
		type = "entry",
		text = spells.AspectoftheHawk.iconandname,
		tooltip = "切换 龙鹰守护 或 雄鹰守护\n(MP大于设置数值的百分比)",
		enabled = enables["AspectoftheHawk"],
		value = values["AspectoftheHawk"],
		width = 50,
		key = spells.AspectoftheHawk.name
	},
	{
		--设置 守护--
		type = "entry",
		text = spells.AspectoftheViper.iconandname,
		tooltip = "切换 蝰蛇守护\n(MP小于设置的数值百分比)",
		enabled = enables["AspectoftheViper"],
		value = values["AspectoftheViper"],
		width = 50,
		key = spells.AspectoftheViper.name
	},
	{
		--设置 多重射击--
		type = "entry",
		text = "\124T" .. select(3, GetSpellInfo(2643)) .. ":26:26\124t 多重瞄准",
		tooltip = "目标10码周围内多于几只怪物时\n使用 多重射击\n(默认多于2,即:3只)",
		value = values["MultiShot"],
		width = 50,
		enabled = enables["MultiShot"],
		key = "MultiShot"
	},
	{
		--设置 乱射--
		type = "entry",
		text = "\124T" .. select(3, GetSpellInfo(1510)) .. ":26:26\124t AOE乱射",
		tooltip = "目标8码范围内多于几只怪时\n在目标位置释放 乱射",
		enabled = enables["Volley"],
		value = values["Volley"],
		width = 50,
		key = "Volley"
	},
	{
		--设置 杀戮射击--
		type = "entry",
		text = "\124T" .. select(3, GetSpellInfo(61006)) .. ":26:26\124t 杀戮射击",
		tooltip = "目标低于20%血量时\n释放 杀戮射击",
		enabled = enables["KillShot"],
		key = "KillShot"
	},
	{
		--设置 震荡射击--
		type = "entry",
		text = "\124T" .. select(3, GetSpellInfo(5116)) .. ":27:27\124t 震荡射击",
		tooltip = "目标逃离状态 使用震荡射击",
		enabled = enables["ConcussiveShot"],
		key = "ConcussiveShot"
	},
	{
		type = "entry",
		text = "\124T" .. select(3, GetSpellInfo(19801)) .. ":26:26\124t 宁神射击",
		tooltip = "打消目标的增益魔法或激怒",
		enabled = enables["TranquilizingShot"],
		key = "TranquilizingShot"
	},
	{
		--误导
		type = "entry",
		text = "\124T" .. select(3, GetSpellInfo(34477)) .. ":26:26\124t 误  导",
		tooltip = "误导仇恨值给其它目标",
		enabled = enables["wudao"],
		key = "wudao"
	},
	{
		-- 辅助切换目标
		type = "entry",
		text = spells.autotarget.icon .. "切换目标",
		tooltip = "战斗中智能辅助切换目标\n如果有焦点,切换下一个目标为焦点的目标",
		enabled = enables["autotarget"],
		key = "autotarget"
	},
	{type = "page", number = 2, text = "|cffFFFF00近战设置|r"},
	{type = "separator"},
	--{ type = "title", text = "|cff00ccff近   战" },
	{
		--猛禽一击
		type = "entry",
		text = "\124T" .. select(3, GetSpellInfo(14260)) .. ":26:26\124t 猛禽一击 ",
		tooltip = "当目标处于近战范围 释放猛禽一击",
		enabled = enables["RaptorStrike"],
		key = "RaptorStrike"
	},
	{
		--猫鼬撕咬 14270
		type = "entry",
		text = "\124T" .. select(3, GetSpellInfo(14270)) .. ":26:26\124t 猫鼬撕咬 ",
		tooltip = "当目标处于近战范围 释放猫鼬撕咬",
		enabled = enables["MongooseBite"],
		key = "MongooseBite"
	},
	{
		--摔绊
		type = "entry",
		text = "\124T" .. select(3, GetSpellInfo(2974)) .. ":26:26\124t 摔  绊 ",
		tooltip = "当目标处于近战范围 释放 摔  绊",
		enabled = enables["shuaiban"],
		key = "shuaiban"
	},
	{
		--献祭陷阱~爆炸陷阱
		type = "entry",
		text = "\124T" ..
			select(3, GetSpellInfo(14317)) .. ":26:26\124t 献祭爆炸 " .. "\124T" .. select(3, GetSpellInfo(14302)) .. ":26:26\124t",
		tooltip = "献祭陷阱 爆炸陷阱 共同CD \n单:献祭 \nAOE:爆炸(检测到3个目标至少)",
		enabled = enables["ExplosiveTrap"],
		value = values["ExplosiveTrap"],
		width = 50,
		key = "ExplosiveTrap"
	},
	{
		--冰冻陷阱 冰霜陷阱
		type = "entry",
		text = "\124T" ..
			select(3, GetSpellInfo(14310)) .. ":26:26\124t 冰冻冰霜 " .. "\124T" .. select(3, GetSpellInfo(13809)) .. ":26:26\124t",
		tooltip = "冰冻 冰霜陷阱 共同CD \n单:冰冻(100%触发荷枪实弹) \nAOE:冰霜(检测到至少5个目标)",
		enabled = enables["FreezingTrap"],
		value = values["FreezingTrap"],
		width = 50,
		key = "FreezingTrap"
	},
	{
		--毒蛇陷阱 SnakeTrap 34600
		type = "entry",
		text = "\124T" .. select(3, GetSpellInfo(34600)) .. ":26:26\124t 毒蛇陷阱 ",
		tooltip = "毒蛇陷阱 跑到目标身边吧 自动",
		enabled = enables["SnakeTrap"],
		key = "SnakeTrap"
	},
	{
		--逃脱781
		type = "entry",
		text = "\124T" .. select(3, GetSpellInfo(781)) .. ":26:26\124t 逃  脱 ",
		tooltip = "当目标处于近战范围\n并且目标的目标是玩家时 释放逃脱",
		enabled = enables["Disengage"],
		key = "Disengage"
	},
	{type = "page", number = 3, text = "|cffFFFF00保护设置|r"},
	{type = "separator"},
	--{ type = "title", text = "|cff00ccff保护设置" },
	{
		--设置 假死--
		type = "entry",
		text = "\124T" .. select(3, GetSpellInfo(5384)) .. ":26:26\124t 假  死 ",
		tooltip = "设置多少血量自动假死",
		enabled = enables["FeignDeath"],
		value = values["FeignDeath"],
		width = 50,
		key = "FeignDeath"
	},
	{
		--设置 威慑--
		type = "entry",
		text = "\124T" .. select(3, GetSpellInfo(19263)) .. ":26:26\124t 威  慑",
		tooltip = "设置多少血量自动开威慑\n5秒免疫一切 但是你也不能攻击",
		enabled = enables["Deterrence"],
		value = values["Deterrence"],
		width = 50,
		key = "Deterrence"
	},
	{type = "page", number = 4, text = "|cffFFFF00宠物控制|r"},
	{type = "separator"},
	--{ type = "title", text = "|cff00ccff宠物配置" },

	{
		--设置 宠物控制--
		type = "entry",
		text = "\124T" .. select(3, GetSpellInfo(883)) .. ":26:26\124t 宠物进攻",
		tooltip = "设置宠物 攻击或待命\n主动攻击主人的目标 \n跟随在身边",
		enabled = enables["Petatt"],
		key = "Petatt"
	},
	{
		--设置 胁迫(命令宠物胁迫并击晕目标)--
		type = "entry",
		text = "\124T" .. select(3, GetSpellInfo(19577)) .. ":26:26\124t 宠物胁迫",
		tooltip = "胁迫(命令宠物胁迫并击晕目标)",
		enabled = enables["Intimidation"],
		key = "Intimidation"
	},
	{},
	{
		--设置 宠物食物 物品ID--
		type = "entry",
		text = "\124T" .. select(3, GetSpellInfo(6991)) .. ":26:26\124t 宠物食物ID",
		tooltip = "给宠物吃的食物ID",
		value = values["PetFood"],
		width = 50,
		key = "PetFood"
	}
}

local inc = false

local function OnLoad()
	ni.combatlog.registerhandler("生存猎人", CombatEventCatcher)
	ni.GUI.AddFrame("生存猎人", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("生存猎人")
	ni.GUI.DestroyFrame("生存猎人")
end

local lastSpell, lastGuid, lastTime = "", "", 0
local function FacingLosCast(spell, tar)
	--("fuc facingloscast")
	if ni.player.isfacing(tar, 145) and ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
		ni.spell.cast(spell, tar)
		ni.debug.log(string.format("Casting %s on %s", spell, tar))
		lastSpell = spell
		lastGuid = UnitGUID(tar)
		lastTime = GetTime()
		return true
	end
	return false
end
local function DoubleCast(spell, tar)
	--print("2cast")
	if (lastSpell == spell) then
		if lastGuid == UnitGUID(tar) then
			if GetTime() - lastTime < 2 then
				return true
			end
		end
	end
	return false
end

local function ValidUsable(id, tar)
	--("fuc ValidUsable")
	if ni.spell.available(id) and ni.spell.valid(tar, id, true, true) then
		return true
	end
	return false
end

local function InRange(tar)
	--print("fuc inrange")
	local melee = IsSpellInRange(spells.MongooseBite.name, tar) == 1
	local ranged = IsSpellInRange(spells.ArcaneShot.name, tar) == 1
	if not melee and ranged then
		return true
	end
	return false
end

local function PetInRange(tar)
	--print("func petinrange")
	if UnitExists("pet") then
		if IsSpellInRange(spells.PetGrowl.name, "pettarget") then
			return true
		end
	end
	return false
end

local _petInRange = false
local _playerInRange = false

local abilities = {
	["Pause"] = function()
		--print("Pause")
		--print(#ni.members)
		if UnitChannelInfo("player") == spells.Volley.name then
			return true
		end

		if
			IsMounted() or ni.unit.aura("player", 431) or --喝水
				ni.unit.aura("player", 5384) or --假死
				ni.unit.aura("player", 19263) or --威慑
				ni.unit.aura("player", 45548) or --进食
				ni.unit.aura("player", 1127) or --进食
				UnitIsDeadOrGhost("player") or
				not UnitExists("target") or
				UnitIsDeadOrGhost("target") or
				(UnitExists("target") and not UnitCanAttack("player", "target"))
		 then
			if IsPetAttackActive() or not enables["Petatt"] then
				ni.player.runtext("/petfollow")
			end
			return true
		end
	end,
	["autotarget"] = function()
		if enables["autotarget"] then
			if not ni.unit.exists("target") or UnitIsDeadOrGhost("target") or not UnitCanAttack("player", "target") then
				if ni.members > 1 then
					for _, member in ipairs(ni.members) do
						if member.istank and UnitAffectingCombat(member.unit) then
							ni.player.runtext("/assist " .. member.unit)
							return true
						end
					end
				elseif ni.unit.exists("focus") and UnitAffectingCombat("focus") and UnitExists("focustarget") then
					ni.player.runtext("/target focustarget")
					return true
				elseif UnitAffectingCombat() then
					ni.player.runtext("/targetenemy")
					return true
				end
			end
		end
	end,
	["Cache"] = function()
		_petInRange = PetInRange("target")
		_playerInRange = InRange("target")
	end,
	["AutoAttack"] = function()
		if not IsCurrentSpell(6603) and not IsCurrentSpell(75) then
			ni.spell.cast(75)
		end
	end,
	--种族 狂暴
	["Berserking"] = function()
		if
			ni.unit.power("player") >= 75 and
				(ni.player.buff(spells.AspectoftheHawk.name) or ni.player.buff(spells.AspectoftheDragonhawk.name))
		 then
			if ni.spell.available(26297) then
				ni.spell.cast(26297)
				return true
			end
		end
	end,
	--急速射击
	["RapidFire"] = function()
		if
			IsSpellKnown(3045) and ni.unit.power("player") >= 75 and
				(ni.player.buff(spells.AspectoftheHawk.name) or ni.player.buff(spells.AspectoftheDragonhawk.name))
		 then
			if ni.spell.available(3045) then
				ni.spell.cast(3045, "player")
				return true
			end
		end
	end,
	["TrueshotAura"] = function()
	end,
	["RaptorStrike"] = function()
		--print("猛禽")
		if
			enables["RaptorStrike"] and ValidUsable(spells.RaptorStrike.id, "target") and ni.unit.inmelee("player", "target") and
				not DoubleCast(spells.RaptorStrike.name, "target") and
				FacingLosCast(spells.RaptorStrike.name, "target")
		 then
			return false
		end
	end,
	["MongooseBite"] = function()
		--print("猫鼬")
		if
			enables["MongooseBite"] and ValidUsable(spells.MongooseBite.id, "target") and ni.unit.inmelee("player", "target") and
				FacingLosCast(spells.MongooseBite.name, "target")
		 then
			return true
		end
	end,
	--摔绊
	["shuaiban"] = function()
		if
			ni.spell.available(spells.shuaiban.id) and UnitIsUnit("player", "targettarget") and
				not ni.unit.debuff("target", spells.shuaiban.name) and
				ni.unit.inmelee("player", "target")
		 then
			ni.spell.cast(spells.shuaiban.name, "target")
			return true
		end
	end,
	--逃脱
	["Disengage"] = function()
		local rapcd = ni.spell.cd(spells.RaptorStrike.id)
		local moncd = ni.spell.cd(spells.MongooseBite.id)
		local desb = ni.unit.debuff("target", spells.shuaiban.name)
		local expcd = ni.spell.cd(spells.ExplosiveTrap.id)
		local freezcd = ni.spell.cd(spells.FreezingTrap.id)
		local snakcd = ni.spell.cd(spells.SnakeTrap.id)
		if enables["Disengage"] and ni.unit.inmelee("player", "target") and UnitIsUnit("player", "targettarget") then
			if enables["RaptorStrike"] and enables["MongooseBite"] then
				if rapcd ~= 0 and moncd ~= 0 then
					ni.spell.cast(spells.Disengage.name)
					return true
				end
			elseif enables["shuaiban"] and desb then
				ni.spell.cast(spells.Disengage.name)
				return true
			elseif enables["ExplosiveTrap"] and enables["FreezingTrap"] then
				if expcd ~= 0 and freezcd ~= 0 then
					ni.spell.cast(spells.Disengage.name)
					return true
				end
			elseif enables["SnakeTrap"] and snakcd ~= 0 then
				ni.spell.cast(spells.Disengage.name)
				return true
			elseif enables["MongooseBite"] and moncd ~= 0 then
				ni.spell.cast(spells.Disengage.name)
				return true
			elseif enables["RaptorStrike"] and rapcd ~= 0 then
				ni.spell.cast(spells.Disengage.name)
				return true
			elseif enables["ExplosiveTrap"] and expcd ~= 0 then
				ni.spell.cast(spells.Disengage.name)
				return true
			elseif enables["FreezingTrap"] and freezcd ~= 0 then
				ni.spell.cast(spells.Disengage.name)
				return true
			else
				ni.spell.cast(spells.Disengage.name)
				return true
			end
		end
	end,
	--误导
	["wudao"] = function()
		if enables["wudao"] then
			if #ni.members > 1 and UnitExists("focus") and not UnitIsDeadOrGhost("focus") then
				if ni.spell.available(spells.wudao.id) then
					ni.spell.cast(spells.wudao.name, "focus")
					return true
				end
			elseif #ni.members == 1 and UnitExists("pet") and not UnitIsDeadOrGhost("pet") then
				if ni.spell.available(spells.wudao.id) then
					ni.spell.cast(spells.wudao.name, "pet")
					return true
				end
			end
		end
	end,
	--献祭&爆炸陷阱
	["ExplosiveTrap"] = function()
		local enear = #ni.unit.enemiesinrange("target", 10)
		if enables["ExplosiveTrap"] then
			if
				enear >= values["ExplosiveTrap"] and ni.unit.inmelee("player", "target") and
					ni.spell.available(spells.ExplosiveTrap.id)
			 then
				ni.spell.cast(spells.ExplosiveTrap.name)
				return true
			end
			if
				enear < values["ExplosiveTrap"] and ni.unit.inmelee("player", "target") and
					ni.spell.available(spells.ImmolationTrap.id)
			 then
				ni.spell.cast(spells.ImmolationTrap.name)
				return true
			end
		end
	end,
	["FreezingTrap"] = function()
		local enear = #ni.unit.enemiesinrange("target", 10)
		if enables["FreezingTrap"] then
			if enear >= values["FreezingTrap"] and ni.unit.inmelee("player", "target") and ni.spell.available(spells.bsxj.id) then
				ni.spell.cast(spells.bsxj.name)
				return true
			end
			if
				enear < values["FreezingTrap"] and ni.unit.inmelee("player", "target") and
					ni.spell.available(spells.FreezingTrap.id)
			 then
				ni.spell.cast(spells.FreezingTrap.name)
				return true
			end
		end
	end,
	---毒蛇陷阱
	["SnakeTrap"] = function()
		if enables["SnakeTrap"] and ni.unit.inmelee("player", "target") and ni.spell.available(spells.SnakeTrap.id) then
			ni.spell.cast(spells.SnakeTrap.name)
			return true
		end
	end,
	["HuntersMark"] = function()
		--print("印记")
		if
			ValidUsable(spells.HuntersMark.id, "target") and not ni.unit.inmelee("player", "target") and
				ni.unit.debuffremaining("target", spells.HuntersMark.id) <= 2 and
				not DoubleCast(spells.HuntersMark.name, "target") and
				FacingLosCast(spells.HuntersMark.name, "target")
		 then
			return true
		end
	end,
	["SerpentSting"] = function()
		--print("毒蛇钉刺")
		if
			ValidUsable(spells.SerpentSting.id, "target") and _playerInRange and
				ni.unit.debuffremaining("target", spells.SerpentSting.id, "player") <= 1.5 and
				not DoubleCast(spells.SerpentSting.name, "target") and
				FacingLosCast(spells.SerpentSting.name, "target")
		 then
			return true
		end
	end,
	--黑箭
	["BlackArrow"] = function()
		if
			ValidUsable(spells.BlackArrow.id, "target") and _playerInRange and
				ni.unit.debuffremaining("target", spells.BlackArrow.id, "player") <= 1 and
				not DoubleCast(spells.BlackArrow.name, "target") and
				FacingLosCast(spells.BlackArrow.name, "target")
		 then
			return true
		end
	end,
	["FreezingArrow"] = function()
		if _playerInRange and ni.spell.available(spells.FreezingArrow.name) and not ni.player.buff(spells.heqiangshidan.name) then
			ni.spell.cast(spells.FreezingArrow.name, "target")
			if SpellIsTargeting() then
				ni.player.clickat("target")
			end
			return true
		end
	end,
	["ArcaneShot"] = function()
		--print("奥术射击+爆炸射击")
		local time = ni.unit.debuffremaining("target", spells.ExplosiveShot.name, "player")
		if
			ValidUsable(spells.ExplosiveShot.name, "target") and _playerInRange and time <= 0 and
				FacingLosCast(spells.ExplosiveShot.name, "target")
		 then
			return true
		elseif
			not ValidUsable(spells.ExplosiveShot.name, "target") and ValidUsable(spells.ArcaneShot.name, "target") and
				_playerInRange and
				FacingLosCast(spells.ArcaneShot.name, "target")
		 then
			return true
		end
	end,
	["MultiShot"] = function()
		--print("多重+瞄准=共同CD")
		local enear = #ni.unit.enemiesinrange("target", 10)
		if
			enables["MultiShot"] and UnitChannelInfo("player") == nil and ValidUsable(spells.MultiShot.id, "target") and
				enear >= values["MultiShot"] and
				_playerInRange and
				FacingLosCast(spells.MultiShot.name, "target")
		 then
			return true
		end
		if
			enables["MultiShot"] and UnitChannelInfo("player") == nil and ValidUsable(spells.AimedShot.id, "target") and
				enear < values["MultiShot"] and
				_playerInRange
		 then
			ni.spell.cast(spells.AimedShot.name, "target")
			return true
		end
	end,
	["ChimeraShot"] = function()
		local enear = #ni.unit.enemiesinrange("target", 10)
		if
			UnitChannelInfo("player") == nil and ValidUsable(spells.ChimeraShot.id, "target") and enear < values["MultiShot"] and
				_playerInRange and
				ni.unit.debuffremaining("target", spells.SerpentSting.id) > 0 and
				FacingLosCast(spells.ChimeraShot.name, "target")
		 then
			return true
		end
	end,
	["ConcussiveShot"] = function()
		--print("震荡")
		if
			enables["ConcussiveShot"] and ValidUsable(spells.ConcussiveShot.id, "target") and _playerInRange and
				ni.unit.isfleeing("target") and
				FacingLosCast(spells.ConcussiveShot.name, "target")
		 then
			return true
		end
	end,
	["Intimidation"] = function()
		--print("宠物胁迫")
		if
			enables["Intimidation"] and ni.spell.available(spells.Intimidation.id) and _petInRange and
				(UnitGUID("player") == UnitGUID("playertargettarget"))
		 then
			ni.spell.cast(spells.Intimidation.name)
			return true
		end
	end,
	--雄鹰守护 龙鹰守护 (未学习龙鹰使用雄鹰)
	["AspectoftheHawk"] = function()
		--print("守护")
		if
			ni.player.power("mana") > values["AspectoftheHawk"] and not ni.player.buff(spells.AspectoftheHawk.name) and
				not ni.player.buff(spells.AspectoftheDragonhawk.name)
		 then
			if ni.spell.available(spells.AspectoftheDragonhawk.id) then
				ni.spell.cast(spells.AspectoftheDragonhawk.name)
				return true
			elseif ni.spell.available(spells.AspectoftheHawk.id) then
				ni.spell.cast(spells.AspectoftheHawk.name)
				return true
			end
		end
	end,
	--乱射 8 码
	--[[ 	["Volley"] = function()
		--print("乱射")
		if enables["Volley"] then
			local rectimed = 0
			local enear = #ni.unit.enemiesinrange("target", 8)
			local n = UnitChannelInfo("player")
				if n ~= nil and n == spells.Volley.name
				and enear >= values["Volley"] then
					return true
					end
				if ni.spell.available(spells.Volley.id)
				and _playerInRange
				and not ni.player.ismoving()
				and enear >= values["Volley"] then
					ni.spell.castat(spells.Volley.name, "target")
					return true
			end
		end
	end, ]]
	["Volley"] = function()
		--print("乱射")
		if enables["Volley"] then
			if UnitChannelInfo("player") == spells.Volley.name then
				return true
			end
			local enear = #ni.unit.enemiesinrange("target", 8)
			local n = UnitChannelInfo("player")
			if n ~= nil and n == spells.Volley.name and enear >= values["Volley"] then
				return true
			end
			if ni.spell.available(spells.Volley.id) and _playerInRange and not ni.player.ismoving() and enear >= values["Volley"] then
				if delaytime == nil then
					delaytime = 0
				end
				ni.spell.cast(spells.Volley.name)
				if SpellIsTargeting() and GetTime() - delaytime > 0.25 then
					ni.player.clickat("target")
					return true
				end
				delaytime = GetTime()
			end
		end
	end,
	["BestialWrath"] = function()
		--print("狂野怒火")
		if
			_petInRange and ni.spell.available(spells.BestialWrath.id) and
				(ni.unit.aura("player", spells.AspectoftheHawk.name) or ni.unit.aura("player", spells.AspectoftheDragonhawk.name))
		 then
			ni.spell.cast(spells.BestialWrath.id)
			return true
		end
	end,
	--杀戮命令
	["KillCommand"] = function()
		--print("杀戮命令")
		local kccd = ni.spell.cd(spells.KillCommand.id)
		if kccd <= 0 then
			if
				_petInRange and ni.unit.aura("player", spells.AspectoftheDragonhawk.name) or
					ni.unit.aura("player", spells.AspectoftheHawk.name)
			 then
				ni.spell.cast(spells.KillCommand.name)
				return true
			end
		else
			return true
		end
	end,
	["KillShot"] = function()
		if
			enables["KillShot"] and ni.unit.hp("target") < 20 and _playerInRange and ValidUsable(spells.KillShot.name, "target")
		 then
			ni.spell.cast(spells.KillShot.name, "target")
			return true
		end
	end,
	["SteadyShot"] = function()
		--print("稳固")
		if ValidUsable(spells.SteadyShot.id, "target") and _playerInRange and not ni.player.ismoving() then
			if
				ni.spell.cd(spells.ChimeraShot.id) > 1 and ni.spell.cd(spells.ArcaneShot.id) > 0 and
					ni.spell.cd(spells.AimedShot.id) > 1.8 and
					FacingLosCast(spells.SteadyShot.name, "target")
			 then
				return true
			end
		end
	end,
	["TranquilizingShot"] = function()
		--print(宁神射击)
		if enables["TranquilizingShot"] then
			for x = 1, 40 do
				local a, _, _, _, b = UnitBuff("target", x)
				while a do
					if b == "Magic" or b == "Enrage" then
						if ni.spell.available(spells.TranquilizingShot.id, "target") and _playerInRange and ni.unit.power("Player") > 12 then
							ni.spell.cast(spells.TranquilizingShot.id, "target")
						end
					end
					x = x + 1
					a, _, _, _, b = UnitBuff("target", x)
				end
			end
		end
	end,
	--蝰蛇守护
	["AspectoftheViper"] = function()
		--print("蝰蛇")
		if
			ni.player.power("mana") < values["AspectoftheViper"] and ni.spell.available(spells.AspectoftheViper.id) and
				not ni.player.buff(spells.AspectoftheViper.id)
		 then
			ni.spell.cast(spells.AspectoftheViper.name)
			return true
		end
	end,
	["FeignDeath"] = function()
		--print("假死123")
		if ni.unit.hp("player") <= values["FeignDeath"] and ni.spell.available(spells.FeignDeath.id) then
			SpellStopCasting()
			StopAttack()
			ClearTarget()
			ni.spell.cast(spells.FeignDeath.id)
			return true
		end
	end,
	["Deterrence"] = function()
		--print("威慑")
		if ni.unit.hp("player") <= values["Deterrence"] and ni.spell.available(spells.Deterrence.id) then
			SpellStopCasting()
			StopAttack()
			ClearTarget()
			ni.spell.cast(spells.Deterrence.id)
			return true
		end
	end,
	--宠物控制
	["PetControl"] = function()
		--print("宠物控制")
		if UnitExists("pet") and not UnitIsDeadOrGhost("pet") then
			local petTarget = UnitGUID("pettarget")
			local playerTarget = UnitGUID("target")
			if enables["Petatt"] and petTarget ~= playerTarget and playerTarget ~= nil then
				ni.player.runtext("/petattack")
				return true
			end
			-- 治疗宠物
			if
				ni.unit.hp("pet") < 70 and not ni.unit.buff("pet", spells.MendPet.id) and IsSpellInRange(spells.MendPet.name, "pet") and
					ni.spell.available(spells.MendPet.id)
			 then
				ni.spell.cast(spells.MendPet.name)
				return true
			end
		end
	end,
	["FeedPet"] = function()
		--print("喂养宠物")
		if delayusetime == nil then
			delayusetime = 0
		end
		if not incombat and UnitExists("pet") and not UnitIsDeadOrGhost("pet") and IsSpellInRange(spells.FeedPet.name, "pet") then
			local happiness = GetPetHappiness()
			local foodId = values["PetFood"]
			local petlvl = UnitLevel("pet")
			if happiness ~= 3 and foodId ~= 0 and ni.player.hasitem(foodId) and not ni.unit.buff("pet", 1539) then
				local name = GetItemInfo(foodId)
				local itemlvl = select(4, GetItemInfo(foodId))
				if (name ~= nil) and GetTime() - delayusetime > 1.5 then
					if itemlvl > petlvl - 14 then
						ni.spell.cast(spells.FeedPet.name)
						ni.player.runtext(string.format("/use %s", name))
					else
						print("|cffff0000 注意:|cffffffff 给宠物吃的食物等级不符 \n  </>15级的食物!")
					end
					delayusetime = GetTime()
				end
			end
		end
	end
}
ni.bootstrap.profile("君莫笑 PvE 射击猎人", queue, abilities, OnLoad, OnUnload)
