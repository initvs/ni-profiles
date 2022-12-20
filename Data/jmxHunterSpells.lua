local function cs(ids)
    return {
        id = ids,
        name = GetSpellInfo(ids),
        icon = "\124T" .. select(3, GetSpellInfo(ids)) .. ":24:24\124t ",
        iconandname = "\124T" .. select(3, GetSpellInfo(ids)) .. ":24:24\124t |cffFFFFFF" .. GetSpellInfo(ids) .. "|r"
    }
end
local spells = {
    -->>通用<<
    --自动攻击--
    AutoAttack = cs(6603),
    autotarget = cs(75),
    --投掷--
    Throw = cs(2764),
    --种族狂暴--
    Berserking = cs(26297),
    -->>野兽天赋<<
    --治疗宠物
    MendPet = cs(136),
    --灵猴守护
    AspectoftheMonkey = cs(13163),
    --召唤宠物
    CallPet = cs(883),
    --解散宠物
    DismissPet = cs(2641),
    --雄鹰守护
    AspectoftheHawk = cs(13165),
    --龙鹰守护
    AspectoftheDragonhawk = cs(61846),
    --驯服野兽
    TameBeast = cs(1515),
    --野兽之眼
    EyesoftheBeast = cs(1002),
    --胁迫
    Intimidation = cs(19577),
    --恐吓野兽
    ScareBeast = cs(1513),
    --猎豹守护
    AspectoftheCheetah = cs(5118),
    --鹰眼术
    EagleEye = cs(6197),
    --杀戮命令
    KillCommand = cs(34026),
    --喂养宠物
    FeedPet = cs(6991),
    --复活宠物
    RevivePet = cs(982),
    --蝰蛇守护
    AspectoftheViper = cs(34074),
    --狂野之怒
    BestialWrath = cs(19574),
    --乱射
    Volley = cs(1510),
    --多重射击--瞄准射击
    MultiShot = cs(2643),
    --强击光环
    TrueshotAura = cs(19506),
    --瞄准射击
    AimedShot = cs(20900),
    --稳固射击
    SteadyShot = cs(56641),
    --震荡射击
    ConcussiveShot = cs(5116),
    --猎人印记
    HuntersMark = cs(1130),
    --急速射击
    RapidFire = cs(3045),
    --自动射击
    AutoShot = cs(75),
    --奥术射击 爆炸射击
    ArcaneShot = cs(3044),
    --毒蛇钉刺
    SerpentSting = cs(1978),
    --扰乱射击
    DistractingShot = cs(20736),
    --宁神射击 19801
    TranquilizingShot = cs(19801),
    --杀戮射击
    KillShot = cs(53351),
    --奇美拉射击
    ChimeraShot = cs(53209),
    -->>生存天赋<<
    --逃脱
    Disengage = cs(781),
    --追踪人型生物
    TrackHumanoids = cs(19883),
    --猫鼬撕咬
    MongooseBite = cs(1495),
    --冰冻陷阱
    FreezingTrap = cs(1499),
    bsxj = cs(13809),
    --追踪不死生物
    TrackUndead = cs(19884),
    --追踪野兽
    TrackBeasts = cs(1494),
    --摔绊
    shuaiban = cs(2974),
    --猛禽一击
    RaptorStrike = cs(2973),
    --威慑
    Deterrence = cs(19263),
    --献祭陷阱
    ImmolationTrap = cs(13795),
    --爆炸陷阱
    ExplosiveTrap = cs(14316),
    --假死
    FeignDeath = cs(5384),
    --宠物低吼
    PetGrowl = cs(2649),
    --假死
    FeignDeath = cs(5384),
    --毒蛇陷阱 34600
    SnakeTrap = cs(34600),
    --误导 34477
    wudao = cs(34477),
    --黑箭3674 -63668
    BlackArrow = cs(3674),
    --冰冻之箭 60192
    FreezingArrow = cs(60192),
    --爆炸射击
    ExplosiveShot = cs(53301),
    --proc 荷枪实弹
    heqiangshidan = cs(56453),
}
return spells