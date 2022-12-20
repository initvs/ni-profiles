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
     --神圣恳求
    Consecration = cs(26573),
     --奉献
    HammerOfWrath = cs(24275),
     --愤怒之锤
    HandOfSalvation = cs(1038),
     --拯救之手
    HandOfFreedom = cs(1044),
     --自由之手
    HandofSacrifice = cs(6940),
     --牺牲之手
    HandOfProtection = cs(1022),
     --保护之手
    SealOfRighteousness = cs(21084),
     --自律
    SealOfJustice = cs(20164),
     --公正圣印
    SealOfLight = cs(20165),
     --光明圣印
    SealOfWisdom = cs(20166),
     --智慧圣印
    SealOfCorruption = cs(31801),
     --复仇圣印
    SealofCommand = cs(20375),
     --命令圣印
    GreaterBlessingOfSanctuary = cs(25899),
     --强效庇护祝福
    BlessingOfSanctuary = cs(20911),
     --庇护祝福
    GreaterBlessingOfKings = cs(25898),
     --强效王者祝福
    BlessingOfKings = cs(20217),
     --王者祝福
    GreaterBlessingOfMight = cs(48934),
     --强效力量祝福
    BlessingOfMight = cs(19740),
     --力量祝福
    GreaterBlessingOfWisdom = cs(48938),
     --强效智慧祝福
    BlessingOfWisdom = cs(19742),
     --智慧祝福
    DevotionAura = cs(465),
     --虔诚光环
    RetributionAura = cs(54043),
     --惩戒光环
    ConcentrationAura = cs(19746),
     --专注光环
    ShadowResistanceAura = cs(48943),
     --暗影抗性光环
    FrostResistanceAura = cs(48945),
     --冰霜抗性光环
    FireResistanceAura = cs(48947),
     --火焰抗性光环
    CrusaderAura = cs(32223),
     --十字军光环
    HolyLight = cs(635),
     --圣光术
    BeaconOfLight = cs(53563),
     --圣光道标
    FlashOfLight = cs(48785),
     --圣光闪现
    HolyShock = cs(48825),
     --神圣震击
    InfusionOfLight = cs(54149),
     --圣光灌注
    Purify = cs(1152), --纯净术 疾病 毒
    Cleanse = cs(4987),
     --清洁术
    DivineIllumination = cs(31842), --神启
    AvengingWrath = cs(31884),
     --复仇之怒
    LayOnHands = cs(633),
     --圣疗术
    SacredShield = cs(53601),
     --圣洁护盾
    HammerofJustice = cs(853),
     --制裁之锤
    JudgementofLight = cs(20271),
     --圣光审判
    JudgementofWisdom = cs(53408),
     --智慧审判
    JudgementofJustice = cs(53407),
     --公正审判
    HolyVengeance = cs(31803),
     --神圣复仇debuff
    CrusaderStrike = cs(35395),
     --十字军打击
    DivineStorm = cs(53385),
     --神圣风暴
    TheArtofWar = cs(59578),
     --战争的艺术pro
    HolyWrath = cs(2812),
     --神圣愤怒
    Exorcism = cs(879)
 --驱邪术
}

local item = {
    food = GetSpellInfo(433),
    drink = {a = GetSpellInfo(27089), b = GetSpellInfo(43183)},
    runicmanapotion = GetItemInfo(33448),
    hppotions = {36894, 36892, 33447, 40087, 39671, 22829, 13446, 9421, 3928, 1710}
}

local isEnabled = {
    [spells.HammerofJustice.name] = true,
     --制裁之锤
    [spells.FlashOfLight.name] = true,
     --圣光闪现
    [spells.Cleanse.name] = true,
     --清洁术
    [spells.AvengingWrath.name] = true,
     --复仇之怒
    [spells.HandofSacrifice.name] = true,
     --牺牲之手
    [spells.LayOnHands.name] = true,
     --圣疗术
    [spells.DivinePlea.name] = true,
     --神圣恳求
    [spells.HandOfProtection.name] = true,
    ["autoseal"] = true,
    ["autoblessing"] = true,
    ["autoaura"] = true,
    ["useJudgement"] = true,
    ["Debug"] = false,
    ["logs"] = true
}

local getValueToCast = {
    [spells.HammerofJustice.name] = 10,
     --制裁之锤
    [spells.FlashOfLight.name] = 50,
     --圣光闪现
    [spells.HandofSacrifice.name] = 40,
    [spells.LayOnHands.name] = 20,
     --圣疗术
    [spells.DivinePlea.name] = 50,
     --神圣恳求
    [spells.Consecration.name] = 2,
    [spells.HandOfProtection.name] = 20,
    [spells.HolyWrath.name] = 3
}

local inputs = {}

local menus = {
    ["Seal"] = spells.SealOfCorruption,
    ["Blessing"] = spells.GreaterBlessingOfSanctuary,
    ["Aura"] = spells.DevotionAura,
    ["useJudgement"] = spells.JudgementofLight
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
    settingsfile = "jmx Retribution Paladin.xml",
    callback = GUICallback,
    {
        type = "title",
        text = "惩戒骑士 |c000080ffjmx"
    },
    {
        type = "separator"
    },
    {
        type = "entry",
        text = "|cff6600cc自动圣印",
        enabled = isEnabled["autoseal"],
        key = "autoseal"
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
            --[[        {
                selected = (menus["Seal"] == spells.SealOfWisdom),
                value = spells.SealOfWisdom,
                text = spells.SealOfWisdom.iconandname
            }, 
]]
            {
                selected = (menus["Seal"] == spells.SealofCommand),
                value = spells.SealofCommand,
                text = spells.SealofCommand.iconandname
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
        type = "separator"
    },
    {
        type = "entry",
        text = "|cff6600cc自动祝福",
        enabled = isEnabled["autoblessing"],
        key = "autoblessing"
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
        type = "separator"
    },
    {
        type = "entry",
        text = "|cff6600cc自动光环",
        enabled = isEnabled["autoaura"],
        key = "autoaura"
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
    {
        type = "entry",
        text = "打开调试 Debug",
        tooltip = "这将会在聊天框显示很多脚本运行中的各种情形 (只有你自己看到).",
        enabled = isEnabled["Debug"],
        key = "Debug"
    },
    {
        type = "separator"
    },
    {
        type = "page",
        number = 1,
        text = "|cff00C957输出循环"
    },
    {
        type = "separator"
    },
    {
        type = "entry",
        text = "|cff6600cc自动审判",
        enabled = isEnabled["useJudgement"],
        key = "useJudgement"
    },
    {
        type = "dropdown",
        menu = {
            {
                selected = (menus["Judgement"] == spells.JudgementofLight),
                value = spells.JudgementofLight,
                text = spells.JudgementofLight.iconandname
            },
            {
                selected = (menus["Judgement"] == spells.JudgementofWisdom),
                value = spells.JudgementofWisdom,
                text = spells.JudgementofWisdom.iconandname
            },
            {
                selected = (menus["Judgement"] == spells.JudgementofJustice),
                value = spells.JudgementofJustice,
                text = spells.JudgementofJustice.iconandname
            }
        },
        key = "Judgement"
    },
    {
        --奉献
        type = "entry",
        text = spells.Consecration.iconandname,
        tooltip = "自身周围怪物数",
        value = getValueToCast[spells.Consecration.name],
        width = 50,
        key = spells.Consecration.name
    },
    {
        --愤怒之锤
        type = "entry",
        text = spells.HammerOfWrath.iconandname
    },
    {
        --神圣风暴
        type = "entry",
        text = spells.DivineStorm.iconandname
    },
    {
        --十字军打击
        type = "entry",
        text = spells.CrusaderStrike.iconandname
    },
    {
        --神圣愤怒
        type = "entry",
        text = spells.HolyWrath.iconandname,
        value = getValueToCast[spells.HolyWrath.name],
        width = 50,
        key = spells.HolyWrath.name
    },
    {
        --驱邪术
        type = "entry",
        text = spells.Exorcism.iconandname
    },
    {
        type = "entry",
        text = spells.AvengingWrath.iconandname,
        tooltip = "BOSS 神圣复仇 4层",
        enabled = isEnabled[spells.AvengingWrath.name],
        key = spells.AvengingWrath.name
    },
    --[[     
    {
        type = "entry",
        text = spells.AvengingWrath.iconandname,
        tooltip = "当你的小组所有成员的平均 HP 数值 \n小于或等于设定的 HP %.",
        enabled = isEnabled[spells.AvengingWrath.name],
        value = getValueToCast[spells.AvengingWrath.name],
        key = spells.AvengingWrath.name
    },
     ]]
    {
        type = "page",
        number = 2,
        text = "|cff00C957辅助"
    },
    {
        type = "separator"
    },
    {
        type = "entry",
        text = spells.FlashOfLight.iconandname,
        tooltip = "战争的艺术触发 圣光闪现治疗低血量队友",
        enabled = isEnabled[spells.FlashOfLight.name],
        value = getValueToCast[spells.FlashOfLight.name],
        key = spells.FlashOfLight.name
    },
    {
        --制裁之锤
        type = "entry",
        text = spells.HammerofJustice.iconandname,
        tooltip = "百分比打断施法.",
        enabled = isEnabled[spells.HammerofJustice.name],
        value = getValueToCast[spells.HammerofJustice.name],
        key = spells.HammerofJustice.name
    },
    {
        --牺牲之手
        type = "entry",
        text = spells.HandofSacrifice.iconandname,
        tooltip = "当数值小于或等于设定的 HP %.",
        enabled = isEnabled[spells.HandofSacrifice.name],
        value = getValueToCast[spells.HandofSacrifice.name],
        key = spells.HandofSacrifice.name
    },
    {
        --圣疗术
        type = "entry",
        text = spells.LayOnHands.iconandname,
        tooltip = "当数值小于或等于设定的 HP %.",
        enabled = isEnabled[spells.LayOnHands.name],
        value = getValueToCast[spells.LayOnHands.name],
        key = spells.LayOnHands.name
    },
    {
        type = "entry",
        text = spells.HandOfProtection.iconandname,
        tooltip = "保护之手(非坦)",
        enabled = isEnabled[spells.HandOfProtection.name],
        value = getValueToCast[spells.HandOfProtection.name],
        width = 50,
        key = spells.HandOfProtection.name
    },
    {
        --神圣恳求
        type = "entry",
        text = spells.DivinePlea.iconandname,
        tooltip = "当法力值小于或等于设定的 MP %.",
        enabled = isEnabled[spells.DivinePlea.name],
        value = getValueToCast[spells.DivinePlea.name],
        key = spells.DivinePlea.name
    },
    {
        --清洁术
        type = "entry",
        text = spells.Cleanse.iconandname,
        enabled = isEnabled[spells.Cleanse.name],
        key = spells.Cleanse.name
    },
    {
        type = "entry",
        text = "喊话",
        enabled = isEnabled["logs"],
        key = "logs"
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
    ni.combatlog.registerhandler("jmxRetPaladin", CombatEventCatcher)
    ni.GUI.AddFrame("jmxRetPaladin", items)
end
local function OnUnload()
    ni.combatlog.unregisterhandler("jmxRetPaladin")
    ni.GUI.DestroyFrame("jmxRetPaladin")
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
    "StopRotation",
    "圣印",
    "光环",
    "祝福",
    "神圣恳求",
    "牺牲之手",
    "圣疗术",
    "保护之手",
    "清洁术",
    "制裁之锤",
    "复仇之怒",
    "愤怒之锤",
    "神圣愤怒",
    "驱邪术",
    "奉献",
    "审判",
    "神圣风暴",
    "十字军打击",
    "圣光闪现"
}

local abilities = {
    ["StopRotation"] = function()
        if functions.StopNi() then
            if IsMounted() and not ni.player.buff(spells.CrusaderAura.id) then
                ni.spell.cast(spells.CrusaderAura.id)
            end
            return true
        end
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
        ni.vars.debug = select(2, GetSetting("Debug"))
    end,
    -----------------------------------
    ["圣印"] = function()
        if isEnabled["autoseal"] then
            local selectedSeal = menus["Seal"]
            if
                ni.player.power("mana") <= 15 and ni.spell.available(spells.SealOfWisdom.id) and
                    not ni.player.buff(spells.SealOfWisdom.id)
             then
                ni.spell.cast(spells.SealOfWisdom.name)
                return true
            end
            if
                ni.player.power("mana") >= 88 and ni.spell.available(selectedSeal.id) and
                    not ni.player.buff(selectedSeal.id)
             then
                ni.spell.cast(selectedSeal.name)
                return true
            end
        end
    end,
    -----------------------------------
    ["光环"] = function()
        if isEnabled["autoaura"] then
            local selectedAura = menus["Aura"]
            if ni.spell.available(selectedAura.name) and not ni.player.buff(selectedAura.name) then
                ni.spell.cast(selectedAura.name)
                return true
            end
        end
    end,
    -----------------------------------
    ["祝福"] = function()
        if isEnabled["autoblessing"] then
            local selectedBlessing = menus["Blessing"]
            if
                ni.spell.available(selectedBlessing.id) and not ni.player.buff(selectedBlessing.id) and
                    IsUsableSpell(selectedBlessing.name)
             then
                ni.spell.cast(selectedBlessing.name, "player")
                return true
            end
        end
    end,
    -----------------------------------
    ["制裁之锤"] = function()
        if isEnabled[spells.HammerofJustice.name] then
            local enemies = ni.player.enemiesinrange(10)
            for i = 1, #enemies do
                local tar = enemies[i].guid
                if
                    ni.unit.iscasting(tar) and
                        ni.unit.castingpercent(tar) >= getValueToCast[spells.HammerofJustice.name] and
                        not ni.unit.isboss(tar) and
                        ni.spell.available(spells.HammerofJustice.id)
                 then
                    ni.spell.cast(spells.HammerofJustice.name, tar)
                    return true
                end
            end
        end
    end,
    -----------------------------------
    ["奉献"] = function()
        local enemies = ni.player.enemiesinrange(10)
        if
            ni.unit.exists("target") and ni.player.power("mana") >= 25 and ni.unit.inmelee("player", "target") and
                ni.spell.available(spells.Consecration.id) and
                #enemies >= getValueToCast[spells.Consecration.name]
         then
            ni.spell.cast(spells.Consecration.name)
            return true
        end
    end,
    -----------------------------------
    ["愤怒之锤"] = function()
        if
            functions.ValidUsable(spells.HammerOfWrath.id, "target") and IsUsableSpell(spells.HammerOfWrath.name) and
                ni.unit.hp("target") < 20 and
                ni.player.power("mana") > 18 and
                functions.FacingLosCast(spells.HammerOfWrath.name, "target")
         then
            return true
        end
    end,
    ["审判"] = function()
        if isEnabled["useJudgement"] then
            local selectedJudgement = menus["Judgement"]
            if
                ni.spell.available(selectedJudgement.id) and
                    ni.unit.debuffremaining("target", selectedJudgement.name, "player") < 2 and
                    functions.ValidUsable(selectedJudgement.id, "target") and
                    functions.FacingLosCast(selectedJudgement.name, "target")
             then
                return true
            end
        end
    end,
    ["神圣风暴"] = function()
        local enemies = ni.player.enemiesinrange(8)
        if
            #enemies >= 1 and UnitAffectingCombat("player") and ni.spell.available(spells.DivineStorm.id) and
                ni.unit.exists("target") and
                ni.unit.inmelee("player", "target")
         then
            ni.spell.cast(spells.DivineStorm.name)
            return true
        end
    end,
    ["十字军打击"] = function()
        if
            ni.spell.available(spells.CrusaderStrike.id) and functions.ValidUsable(spells.CrusaderStrike.id, "target") and
                functions.FacingLosCast(spells.CrusaderStrike.name, "target")
         then
            return true
        end
    end,
    ["神圣愤怒"] = function()
        local enemies = ni.player.enemiesinrange(10)
        local tar = 0
        for i = 1, #enemies do
            local type = ni.unit.creaturetype(enemies[i].guid)
            if type == 3 or type == 6 then
                tar = tar + 1
            end
        end
        if tar >= getValueToCast[spells.HolyWrath.name] and ni.spell.available(spells.HolyWrath.id) then
            ni.spell.cast(spells.HolyWrath.name)
            return true
        end
    end,
    ["驱邪术"] = function()
        if
            ni.player.buff(spells.TheArtofWar.id) and ni.spell.available(spells.Exorcism.id) and
                ni.spell.cd(spells.DivineStorm.id) > 1
         then
            ni.spell.cast(spells.Exorcism.name, "target")
            return true
        end
    end,
    -----------------------------------
    ["清洁术"] = function()
        if isEnabled[spells.Cleanse.name] and ni.player.power("mana") >= 15 then
            for _, member in ipairs(ni.members) do
                if
                    IsSpellKnown(spells.Cleanse.id) and member.dispel and ni.spell.available(spells.Cleanse.id) and
                        ni.spell.valid(member.unit, spells.Cleanse.id, false, false, true) and
                        functions.LosCast(spells.Cleanse.name, member.unit) and
                        not functions.doNotDissipateIt(member.unit)
                 then
                    return true
                elseif not IsSpellKnown(spells.Cleanse.id) then
                    local i = 1
                    local debuff, _, _, count, bufftype, duration = UnitDebuff(member.unit, i)
                    while debuff do
                        if
                            ((bufftype == "Disease") or (bufftype == "Poison")) and duration > 3 and
                                not functions.doNotDissipateIt(member.unit)
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
    end,
    -----------------------------------
    ["牺牲之手"] = function()
        if isEnabled["HandofSacrifice"] and UnitAffectingCombat("player") then
            for i = 1, #ni.members do
                if
                    not ni.members[i].istank and ni.player.hp() > 75 and
                        ni.members[i].hp < getValueToCast["HandofSacrifice"] and
                        ni.spell.available(spells.HandofSacrifice.id) and
                        ni.spell.valid(ni.members[i].unit, spells.HandofSacrifice.id, false, true, true)
                 then
                    ni.spell.cast(spells.HandofSacrifice.id, ni.members[i].unit)
                    if isEnabled["logs"] then
                        ni.player.runtext(
                            "/s " .. GetSpellLink(spells.HandofSacrifice.id) .. " on @" .. ni.members[i].name
                        )
                    end
                    return true
                end
            end
        end
    end,
    ["圣疗术"] = function()
        local membersBelow = functions.members.inrangebelow("player", 40, getValueToCast[spells.LayOnHands.name])
        if ni.spell.available(spells.LayOnHands.name) and #membersBelow >= 1 and ni.vars.combat.started then
            ni.spell.cast(spells.LayOnHands.name, membersBelow[1].unit)
            if isEnabled["logs"] then
                ni.player.runtext("/y " .. GetSpellLink(spells.LayOnHands.id) .. " on @" .. ni.members[i].name)
            end
            return true
        end
    end,
    ["保护之手"] = function()
        if isEnabled[spells.HandOfProtection.name] and ni.vars.combat.started then
            for i = 1, #ni.members do
                if
                    ni.members[i].hp < getValueToCast[spells.HandOfProtection.name] and not ni.members[i].istank and
                        not ni.unit.debuff(ni.members[i].unit, 25771) and
                        ni.spell.available(spells.HandOfProtection.id) and
                        ni.spell.valid(ni.members[i].unit, spells.HandOfProtection.id, false, true, true) and
                        not ni.spell.cd(spells.LayOnHands.id)
                 then
                    ni.spell.cast(spells.HandOfProtection.name, ni.members[i].unit)
                    if isEnabled["logs"] then
                        ni.player.runtext(
                            "/y " .. GetSpellLink(spells.HandOfProtection.id) .. " on @" .. ni.members[i].name
                        )
                    end
                    return true
                end
            end
        end
    end,
    -----------------------------------
    ["复仇之怒"] = function()
        if
            isEnabled[spells.AvengingWrath.name] and ni.player.buff(spells.SealOfCorruption.name) and
                ni.unit.isboss("target") and
                ni.spell.available(spells.AvengingWrath.id) and
                ni.unit.debuffstacks("target", spells.HolyVengeance.name, "player") >= 4
         then
            ni.spell.cast(spells.AvengingWrath.name)
            return true
        end
    end,
    --[[ 奶骑
    ["复仇之怒"] = function()
        if
            ni.members.average() <= getValueToCast[spells.AvengingWrath.name] and
                ni.spell.available(spells.AvengingWrath.id)
            then
            ni.spell.cast(spells.AvengingWrath.name)
        end
    end,
 ]]
    -----------------------------------
    ["神圣恳求"] = function()
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
    ["圣光闪现"] = function()
        if isEnabled[spells.FlashOfLight.name] and UnitAffectingCombat("player") then
            local membersBelow = functions.members.inrangebelow("player", 40, getValueToCast[spells.FlashOfLight.name])

            if #membersBelow > 1 and ni.player.buff(spells.TheArtofWar.id) then
                ni.spell.cast(spells.FlashOfLight.name, membersBelow[1].unit)
                return true
            end
        end
    end
}
ni.bootstrap.profile("惩戒骑", queue, abilities, OnLoad, OnUnload)
