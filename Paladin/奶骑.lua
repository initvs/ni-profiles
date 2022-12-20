local functions = ni.utils.require("jmxFunctions")
local function cs(ids)
    local name = GetSpellInfo(ids)
    return {
        id = ids,
        name = name,
        icon = "\124T" .. select(3, GetSpellInfo(ids)) .. ":20:20\124t ",
        iconandname = "\124T" .. select(3, GetSpellInfo(ids)) .. ":20:20\124t |cffFFFFFF" .. name .. "|r"
    }
end

local spells = {
    DivinePlea = cs(54428),
    Consecration = cs(48819),
    HammerOfWrath = cs(48806),
    HandOfSalvation = cs(1038),
    HandOfFreedom = cs(1044),
    HandOfSacrifice = cs(6940),
    HandOfProtection = cs(1022),
    --保护之手
    SealOfRighteousness = cs(21084),
    --自律
    SealOfJustice = cs(20164),
    SealOfLight = cs(20165),
    SealOfWisdom = cs(20166),
    SealOfCorruption = cs(53736),
    GreaterBlessingOfSanctuary = cs(25899),
    BlessingOfSanctuary = cs(20911),
    GreaterBlessingOfKings = cs(25898),
    BlessingOfKings = cs(20217),
    GreaterBlessingOfMight = cs(48934),
    BlessingOfMight = cs(19740),
    GreaterBlessingOfWisdom = cs(48938),
    BlessingOfWisdom = cs(19742),
    DevotionAura = cs(465),
    --虔诚光环
    RetributionAura = cs(54043),
    ConcentrationAura = cs(19746),
    ShadowResistanceAura = cs(48943),
    FrostResistanceAura = cs(48945),
    FireResistanceAura = cs(48947),
    CrusaderAura = cs(32223),
    HolyLight = cs(635),
    --圣光术
    BeaconOfLight = cs(53563),
    FlashOfLight = cs(48785),
    HolyShock = cs(48825),
    InfusionOfLight = cs(54149),
    Purify = cs(1152), --纯净术 疾病 毒
    Cleanse = cs(4987),
    DivineIllumination = cs(31842), --神启
    AvengingWrath = cs(31884),
    LayOnHands = cs(633),
    --圣疗术
    SacredShield = cs(53601)
}

local isEnabled = {
    [spells.HolyLight.name] = true,
    [spells.FlashOfLight.name] = true,
    [spells.HolyShock.name] = true,
    [spells.Cleanse.name] = true,
    [spells.DivineIllumination.name] = true,
    [spells.AvengingWrath.name] = true,
    [spells.LayOnHands.name] = true,
    [spells.HandOfProtection.name] = true,
    [spells.DivinePlea.name] = true,
    [spells.InfusionOfLight.name] = true,
    ["Debug"] = false,
    ["logs"] = true
}

local getValueToCast = {
    [spells.HolyLight.name] = 75,
    [spells.FlashOfLight.name] = 80,
    [spells.HolyShock.name] = 90,
    [spells.DivineIllumination.name] = 50,
    [spells.AvengingWrath.name] = 50,
    [spells.LayOnHands.name] = 20,
    [spells.HandOfProtection.name] = 20,
    [spells.DivinePlea.name] = 50,
    [spells.InfusionOfLight.name] = 85
}
local inputs = {}

local menus = {
    [spells.BeaconOfLight.name] = "main_tank",
    [spells.SacredShield.name] = "main_tank",
    ["Seal"] = spells.SealOfCorruption,
    ["Blessing"] = spells.GreaterBlessingOfSanctuary,
    ["Aura"] = spells.DevotionAura
}

local function GUICallback(key, item_type, value)
    if item_type == "enabled" then
        isEnabled[key] = value
    elseif item_type == "value" then
        getValueToCast[key] = value
    elseif item_type == "input" then
        inputs[key] = value
    elseif item_type == "menu" then
        menus[key] = value
    end
end

local items = {
    settingsfile = "jmxHolyPaladin.xml",
    callback = GUICallback,
    {
        type = "title",
        text = "奶骑 |c000080ffjmx"
    },
    {
        type = "separator"
    },
    {
        type = "title",
        text = "|cffFFFF00主要设置"
    },
    {
        type = "separator"
    },
    {
        type = "dropdown",
        menu = {
            {
                selected = (menus["Seal"] == spells.SealOfCorruption),
                value = spells.SealOfCorruption,
                text = spells.SealOfCorruption.iconandname
            },
            {
                selected = (menus["Seal"] == spells.SealOfLight),
                value = spells.SealOfLight,
                text = spells.SealOfLight.iconandname
            },
            {
                selected = (menus["Seal"] == spells.SealOfRighteousness),
                value = spells.SealOfRighteousness,
                text = spells.SealOfRighteousness.iconandname
            },
            {
                selected = (menus["Seal"] == spells.SealOfWisdom),
                value = spells.SealOfWisdom,
                text = spells.SealOfWisdom.iconandname
            },
            {
                selected = (menus["Seal"] == spells.SealOfJustice),
                value = spells.SealOfJustice,
                text = spells.SealOfJustice.iconandname
            }
        },
        key = "Seal"
    },
    {
        type = "dropdown",
        menu = {
            {
                selected = (menus["Blessing"] == spells.GreaterBlessingOfSanctuary),
                value = spells.GreaterBlessingOfSanctuary,
                text = spells.GreaterBlessingOfSanctuary.iconandname
            },
            {
                selected = (menus["Blessing"] == spells.GreaterBlessingOfKings),
                value = spells.GreaterBlessingOfKings,
                text = spells.GreaterBlessingOfKings.iconandname
            },
            {
                selected = (menus["Blessing"] == spells.GreaterBlessingOfMight),
                value = spells.GreaterBlessingOfMight,
                text = spells.GreaterBlessingOfMight.iconandname
            },
            {
                selected = (menus["Blessing"] == spells.GreaterBlessingOfWisdom),
                value = spells.GreaterBlessingOfWisdom,
                text = spells.GreaterBlessingOfWisdom.iconandname
            },
            {
                selected = (menus["Blessing"] == spells.BlessingOfSanctuary),
                value = spells.BlessingOfSanctuary,
                text = spells.BlessingOfSanctuary.iconandname
            },
            {
                selected = (menus["Blessing"] == spells.BlessingOfKings),
                value = spells.BlessingOfKings,
                text = spells.BlessingOfKings.iconandname
            },
            {
                selected = (menus["Blessing"] == spells.BlessingOfMight),
                value = spells.BlessingOfMight,
                text = spells.BlessingOfMight.iconandname
            },
            {
                selected = (menus["Blessing"] == spells.BlessingOfWisdom),
                value = spells.BlessingOfWisdom,
                text = spells.BlessingOfWisdom.iconandname
            }
        },
        key = "Blessing"
    },
    {
        type = "dropdown",
        menu = {
            {
                selected = (menus["Aura"] == spells.DevotionAura),
                value = spells.DevotionAura,
                text = spells.DevotionAura.iconandname
            },
            {
                selected = (menus["Aura"] == spells.RetributionAura),
                value = spells.RetributionAura,
                text = spells.RetributionAura.iconandname
            },
            {
                selected = (menus["Aura"] == spells.ConcentrationAura),
                value = spells.ConcentrationAura,
                text = spells.ConcentrationAura.iconandname
            },
            {
                selected = (menus["Aura"] == spells.ShadowResistanceAura),
                value = spells.ShadowResistanceAura,
                text = spells.ShadowResistanceAura.iconandname
            },
            {
                selected = (menus["Aura"] == spells.FrostResistanceAura),
                value = spells.FrostResistanceAura,
                text = spells.FrostResistanceAura.iconandname
            },
            {
                selected = (menus["Aura"] == spells.FireResistanceAura),
                value = spells.FireResistanceAura,
                text = spells.FireResistanceAura.iconandname
            },
            {
                selected = (menus["Aura"] == spells.CrusaderAura),
                value = spells.CrusaderAura,
                text = spells.CrusaderAura.iconandname
            }
        },
        key = "Aura"
    },
    {
        type = "separator"
    },
    {type = "title", text = "|cffff00ff圣光道标"},
    {
        type = "dropdown",
        menu = {
            {
                selected = (menus[spells.BeaconOfLight.name] == "main_tank"),
                value = "main_tank",
                text = "主坦"
            },
            {
                selected = (menus[spells.BeaconOfLight.name] == "off_tank"),
                value = "off_tank",
                text = "副坦"
            },
            {
                selected = (menus[spells.BeaconOfLight.name] == "focus"),
                value = "focus",
                text = "焦点"
            },
            {
                selected = (menus[spells.BeaconOfLight.name] == "player"),
                value = "player",
                text = "自己"
            }
        },
        key = spells.BeaconOfLight.name
    },
    {
        type = "separator"
    },
    {type = "title", text = "|cffff00ff圣洁护盾"},
    {
        type = "dropdown",
        menu = {
            {
                selected = (menus[spells.SacredShield.name] == "main_tank"),
                value = "main_tank",
                text = "主坦"
            },
            {
                selected = (menus[spells.SacredShield.name] == "off_tank"),
                value = "off_tank",
                text = "副坦"
            },
            {
                selected = (menus[spells.SacredShield.name] == "focus"),
                value = "focus",
                text = "焦点"
            },
            {
                selected = (menus[spells.SacredShield.name] == "player"),
                value = "player",
                text = "自己"
            }
        },
        key = spells.SacredShield.name
    },
    {
        type = "separator"
    },
    {
        type = "entry",
        text = "打开调试 Debug",
        tooltip = "这将会在聊天框显示很多脚本运行中的各种情形 (只有你自己看到).",
        enabled = isEnabled["Debug"],
        key = "Debug"
    },
    {
        type = "entry",
        text = "打开喊话 /s",
        tooltip = "重要技能通过喊话通知.",
        enabled = isEnabled["logs"],
        key = "logs"
    },
    {
        type = "separator"
    },
    {
        type = "page",
        number = 1,
        text = "|cff00C957循环设置"
    },
    {
        type = "separator"
    },
    {
        type = "entry",
        text = spells.FlashOfLight.iconandname,
        tooltip = "当数值小于或等于设定的 HP %.",
        enabled = isEnabled[spells.FlashOfLight.name],
        value = getValueToCast[spells.FlashOfLight.name],
        width = 50,
        key = spells.FlashOfLight.name
    },
    {
        type = "entry",
        text = spells.HolyShock.iconandname,
        tooltip = "当数值小于或等于设定的 HP %.",
        enabled = isEnabled[spells.HolyShock.name],
        value = getValueToCast[spells.HolyShock.name],
        width = 50,
        key = spells.HolyShock.name
    },
    {
        type = "entry",
        text = spells.AvengingWrath.iconandname,
        tooltip = "当你的小组所有成员的平均 HP 数值 \n小于或等于设定的 HP %.",
        enabled = isEnabled[spells.AvengingWrath.name],
        value = getValueToCast[spells.AvengingWrath.name],
        width = 50,
        key = spells.AvengingWrath.name
    },
    {
        type = "entry",
        text = spells.LayOnHands.iconandname,
        tooltip = "当数值小于或等于设定的 HP %.",
        enabled = isEnabled[spells.LayOnHands.name],
        value = getValueToCast[spells.LayOnHands.name],
        width = 50,
        key = spells.LayOnHands.name
    },
    {
        type = "entry",
        text = spells.HandOfProtection.iconandname,
        tooltip = "保护之手（非坦）",
        enabled = isEnabled[spells.HandOfProtection.name],
        value = getValueToCast[spells.HandOfProtection.name],
        width = 50,
        key = spells.HandOfProtection.name
    },
    {
        type = "entry",
        text = spells.Cleanse.iconandname,
        enabled = isEnabled[spells.Cleanse.name],
        key = spells.Cleanse.name
    },
    {
        type = "page",
        number = 2,
        text = "|cff00C957天赋设置"
    },
    {
        type = "separator"
    },
    {
        type = "entry",
        text = spells.DivinePlea.iconandname,
        tooltip = "当法力值小于或等于设定的 MP %.",
        enabled = isEnabled[spells.DivinePlea.name],
        value = getValueToCast[spells.DivinePlea.name],
        width = 50,
        key = spells.DivinePlea.name
    },
    {
        type = "entry",
        text = spells.InfusionOfLight.iconandname,
        tooltip = "当数值小于或等于设定的 HP %.",
        enabled = isEnabled[spells.InfusionOfLight.name],
        value = getValueToCast[spells.InfusionOfLight.name],
        width = 50,
        key = spells.InfusionOfLight.name
    },
    {
        type = "entry",
        text = spells.HolyLight.iconandname,
        tooltip = "当数值小于或等于设定的 HP %.",
        enabled = isEnabled[spells.HolyLight.name],
        value = getValueToCast[spells.HolyLight.name],
        width = 50,
        key = spells.HolyLight.name
    },
    {
        type = "entry",
        text = spells.DivineIllumination.iconandname,
        tooltip = "当你的小组所有成员的平均 HP 数值 \n小于或等于设定的 HP %.",
        enabled = isEnabled[spells.DivineIllumination.name],
        value = getValueToCast[spells.DivineIllumination.name],
        width = 50,
        key = spells.DivineIllumination.name
    }
}

local function GetSetting(name)
    for k, v in ipairs(items) do
        if v.type == "entry" and v.key ~= nil and v.key == name then
            return v.value, v.enabled
        end
        if v.type == "dropdown" and v.key ~= nil and v.key == name then
            for k2, v2 in pairs(v.menu) do
                if v2.selected then
                    return v2.value
                end
            end
        end
        if v.type == "input" and v.key ~= nil and v.key == name then
            return v.value
        end
    end
end

local function OnLoad()
    ni.combatlog.registerhandler("jmxHolyPaladin", CombatEventCatcher)
    ni.GUI.AddFrame("jmxHolyPaladin", items)
end
local function OnUnload()
    ni.combatlog.unregisterhandler("jmxHolyPaladin")
    ni.GUI.DestroyFrame("jmxHolyPaladin")
end

-- Functions for this rotation only
local function getTheSavior()
    local members =
        functions.filter(
        functions.members.inrange("player", 40),
        function(member)
            if not ni.unit.buff(member.unit, spells.BeaconOfLight.id, "player") then
                return true
            end
        end
    )
    return members[1]
end

local queue = {
    "test",
    "StopRotation",
    "Seal",
    "Aura",
    "Blessing",
    "Lay On Hands",
    "Hand Of Protection",
    "Divine Illumination",
    "Avenging Wrath",
    "Beacon Of Light",
    "Infusion Of Light",
    "Holy Light",
    "Holy Shock",
    "Cleanse",
    "Flash Of Light",
    "Judgement",
    "Divine Plea",
    "Sacred Shield"
}

local abilities = {
    ["test"] = function()
        if ni.vars.units.mainTankEnabled then
            local mainTank = ni.vars.units.mainTank
            print(mainTank)
        end
    end,
    -----------------------------------
    ["StopRotation"] = function()
        if functions.StopNi() then
            return true
        end
        ni.vars.debug = select(2, GetSetting("Debug"))
    end,
    -----------------------------------
    ["Seal"] = function()
        local selectedSeal = menus["Seal"]

        if ni.spell.available(selectedSeal.id) and not ni.player.buff(selectedSeal.id) then
            ni.spell.cast(selectedSeal.name)
            return true
        end
    end,
    -----------------------------------
    ["Aura"] = function()
        local selectedAura = menus["Aura"]

        if ni.spell.available(selectedAura.name) and not ni.player.buff(selectedAura.name) then
            ni.spell.cast(selectedAura.name)
            return true
        end
    end,
    -----------------------------------
    ["Blessing"] = function()
        local selectedBlessing = menus["Blessing"]

        if
            ni.spell.available(selectedBlessing.id) and not ni.player.buff(selectedBlessing.id) and
                IsUsableSpell(selectedBlessing.name)
         then
            ni.spell.cast(selectedBlessing.name, "player")
            return true
        end
    end,
    -----------------------------------
    ["Beacon Of Light"] = function()
        local mainTank, offTank = ni.tanks()
        local selection = {
            ["main_tank"] = mainTank,
            ["off_tank"] = offTank,
            ["focus"] = "focus",
            ["player"] = "player"
        }
        local target = selection[menus[spells.BeaconOfLight.name]]
        if
            ni.spell.available(spells.BeaconOfLight.id) and ni.unit.exists(target) and
                ni.spell.valid(target, spells.BeaconOfLight.id, false, true, true) and
                UnitLevel(target) >= 29 and
                ni.vars.combat.started and
                not ni.unit.buff(target, spells.BeaconOfLight.id, "player")
         then
            return ni.spell.cast(spells.BeaconOfLight.name, target)
        end
    end,
    -----------------------------------
    ["Divine Illumination"] = function()
        if
            UnitAffectingCombat("player") and ni.members.average() <= getValueToCast[spells.DivineIllumination.name] and
                ni.spell.available(spells.DivineIllumination.name)
         then
            ni.spell.cast(spells.DivineIllumination.name)
        end
    end,
    -----------------------------------
    ["Lay On Hands"] = function()
        local membersBelow = functions.members.inrangebelow("player", 40, getValueToCast[spells.LayOnHands.name])
        if ni.spell.available(spells.LayOnHands.name) and #membersBelow >= 1 and UnitAffectingCombat("player") then
            ni.spell.cast(spells.LayOnHands.name, membersBelow[1].unit)
            if isEnabled["logs"] then
                ni.player.runtext("/s " .. GetSpellLink(spells.LayOnHands.id) .. "on @" .. ni.members[i].name)
            end
            return true
        end
    end,
    -----------------------------------
    ["Avenging Wrath"] = function()
        if
            UnitAffectingCombat("player") and ni.members.average() <= getValueToCast[spells.AvengingWrath.name] and
                ni.spell.available(spells.AvengingWrath.id)
         then
            ni.spell.cast(spells.AvengingWrath.name)
        end
    end,
    -----------------------------------
    ["Sacred Shield"] = function()
        local mainTank, offTank = ni.tanks()
        local selection = {
            ["main_tank"] = mainTank,
            ["off_tank"] = offTank,
            ["focus"] = "focus",
            ["player"] = "player"
        }
        local target = selection[menus[spells.SacredShield.name]]

        if
            ni.spell.available(spells.SacredShield.id) and ni.unit.exists(target) and
                ni.spell.valid(target, spells.SacredShield.id, false, true, true) and
                UnitLevel(target) >= 29 and
                ni.vars.combat.started and
                not ni.unit.buff(target, spells.SacredShield.id, "EXACT")
         then
            return ni.spell.cast(spells.SacredShield.name, target)
        end
    end,
    -----------------------------------
    ["Divine Plea"] = function()
        if
            isEnabled[spells.DivinePlea.name] and ni.player.power() <= getValueToCast[spells.DivinePlea.name] and
                not ni.player.buff(spells.DivinePlea.id) and
                ni.spell.available(spells.DivinePlea.id) and
                ni.vars.combat.started
         then
            return ni.spell.cast(spells.DivinePlea.id)
        end
    end,
    -----------------------------------
    ["Holy Light"] = function()
        if isEnabled[spells.HolyLight.name] then
            local castSpell = function(target)
                if
                    UnitExists(target) and ni.spell.available(spells.HolyLight.name) and not ni.unit.ismoving("player") and
                        not ni.unit.buff(target, spells.BeaconOfLight.name, "player") and
                        ni.spell.valid(target, spells.HolyLight.name, false, true, true)
                 then
                    return ni.spell.delaycast(spells.HolyLight.name, target, 2.5)
                end
            end

            local membersBelow = functions.members.inrangebelow("player", 40, getValueToCast[spells.HolyLight.name])

            if #membersBelow == 1 and ni.unit.buff(membersBelow[1].unit, spells.BeaconOfLight.name, "player") then
                local theSavior = getTheSavior()
                return castSpell(theSavior.unit)
            end

            for _, member in ipairs(membersBelow) do
                castSpell(member.unit)
            end
        end
    end,
    ["Hand Of Protection"] = function()
        if isEnabled["HandOfProtection"] and UnitAffectingCombat("player") then
            for i = 1, #ni.members do
                if
                    ni.members[i].hp < getValueToCast["HandOfProtection"] and not ni.members[i].istank and
                        not ni.unit.debuff(ni.members[i].unit, 25771) and
                        ni.spell.available(spells.HandOfProtection.id) and
                        ni.spell.valid(ni.members[i].unit, spells.HandOfProtection.id, false, true, true)
                 then
                    ni.spell.cast(spells.HandOfProtection.name, ni.members[i].unit)
                    if isEnabled["logs"] then
                        ni.player.runtext(
                            "/s " .. GetSpellLink(spells.HandOfProtection.id) .. "on @" .. ni.members[i].name
                        )
                    end
                    return true
                end
            end
        end
    end,
    -----------------------------------
    ["Holy Shock"] = function()
        if isEnabled[spells.HolyShock.name] then
            local castSpell = function(target)
                if
                    UnitExists(target) and ni.spell.available(spells.HolyShock.id) and
                        not ni.unit.buff(target, spells.BeaconOfLight.id, "player") and
                        ni.spell.valid(target, spells.HolyShock.id, false, true, true)
                 then
                    return ni.spell.cast(spells.HolyShock.name, target)
                end
            end

            local membersBelow = functions.members.inrangebelow("player", 40, getValueToCast[spells.HolyShock.name])

            if #membersBelow == 1 and ni.unit.buff(membersBelow[1].unit, spells.BeaconOfLight.id, "player") then
                local theSavior = getTheSavior()
                return castSpell(theSavior.unit)
            end

            for _, member in ipairs(membersBelow) do
                castSpell(member.unit)
            end
        end
    end,
    -----------------------------------
    ["Flash Of Light"] = function()
        if isEnabled[spells.FlashOfLight.name] then
            local castSpell = function(target)
                if
                    UnitExists(target) and ni.spell.available(spells.FlashOfLight.id) and not ni.unit.ismoving("player") and
                        not ni.unit.buff(target, spells.BeaconOfLight.id, "player") and
                        ni.spell.valid(target, spells.FlashOfLight.name, false, true, true)
                 then
                    return ni.spell.delaycast(spells.FlashOfLight.name, target, 2)
                end
            end

            local membersBelow = functions.members.inrangebelow("player", 40, getValueToCast[spells.HolyShock.name])

            if #membersBelow == 1 and ni.unit.buff(membersBelow[1].unit, spells.BeaconOfLight.id, "player") then
                local theSavior = getTheSavior()
                return castSpell(theSavior.unit)
            end

            for _, member in ipairs(membersBelow) do
                castSpell(member.unit)
            end
        end
    end,
    -----------------------------------
    ["Infusion Of Light"] = function()
        if isEnabled[spells.InfusionOfLight.name] then
            local castSpell = function(target)
                if
                    UnitExists(target) and ni.player.buff(spells.InfusionOfLight.name) and
                        ni.spell.available(spells.FlashOfLight.name) and
                        not ni.unit.buff(target, spells.BeaconOfLight.name, "player")
                 then
                    return ni.spell.cast(spells.FlashOfLight.name, target)
                end
            end

            local membersBelow = functions.members.inrangebelow("player", 40, getValueToCast[spells.HolyShock.name])

            if #membersBelow == 1 and ni.unit.buff(membersBelow[1].unit, spells.BeaconOfLight.id, "player") then
                local theSavior = getTheSavior()
                return castSpell(theSavior.unit)
            end

            for _, member in ipairs(membersBelow) do
                castSpell(member.unit)
            end
        end
    end,
    -----------------------------------
    ["Judgement"] = function()
        if functions.ValidUsable(20271, "target") and functions.FacingLosCast(GetSpellInfo(20271), "target") then
            return true
        end
    end,
    -----------------------------------
    ["Cleanse"] = function()
        if isEnabled[spells.Cleanse.name] then
            for _, member in ipairs(ni.members) do
                if
                    IsSpellKnown(spells.Cleanse.id) and member.dispel and ni.spell.available(spells.Cleanse.id) and
                        ni.spell.valid(member.unit, spells.Cleanse.id, false, false, true) and
                        functions.LosCast(spells.Cleanse.name, member.unit) and
                        not functions.doNotDissipateIt(member.unit)
                 then
                    ni.spell.cast(spells.Cleanse.name, member.unit)
                    return true
                elseif not IsSpellKnown(spells.Cleanse.id) and not ni.spell.gcd() then
                    local i = 1
                    local debuff, _, _, count, bufftype, duration = UnitDebuff(member.unit, i)
                    while debuff do
                        if
                            ((bufftype == "Disease") or (bufftype == "Poison")) and
                                not functions.doNotDissipateIt(member.unit) and
                                ni.spell.valid(member.unit, 1152, false, false, true)
                         then
                            ni.spell.cast(1152, member.unit)
                            return true
                        end
                        i = i + 1
                        debuff, _, _, count, bufftype, duration = UnitDebuff(member.unit, i)
                    end
                end
            end
        end
    end
}
ni.bootstrap.profile("奶骑", queue, abilities, OnLoad, OnUnload)
