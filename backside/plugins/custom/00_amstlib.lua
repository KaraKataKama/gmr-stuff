--This file is part of the AmsTaFFix' GMR plugins/profiles distribution
--(https://github.com/AmsTaFFix/gmr-stuff).
--Copyright (C) 2022 Nikita Sapogov
--
--This program is free software: you can redistribute it and/or modify
--it under the terms of the GNU General Public License as published by
--the Free Software Foundation, either version 3 of the License, or
--(at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU General Public License for more details.
--
--You should have received a copy of the GNU General Public License
--along with this program.  If not, see <https://www.gnu.org/licenses/>.

local VERSION = 3
local isSuccess, err = pcall(function()
    if amstlib then
        if (amstlib.VERSION or 0) >= VERSION then
            if _G["AMSTREPLUG_IN_PROGRESS"] then
                (amstlib.close or function() end)()
                GMR.Print("Previous instance of amstlib has been closed, new one will load")
            else
                GMR.Print("Already have amstlib v" .. tostring(amstlib.VERSION) .. ", should not rewrite it")
                return -- older lib should not overwrite newer one
            end
        else
            GMR.Print("Already have amstlib, it is have older version v" .. tostring(amstlib.VERSION) .. " vs v" .. VERSION .. " version, should rewrite")
        end
    end
    ---@class AmstLib
    amstlib = {}
    ---@type number version of library
    amstlib.VERSION = VERSION
    ---@type table<string, AmstLibCombatRotation>
    amstlib.combatRotations = {}

    ---Check debuff expiration.
    ---
    ---I have to add my own version of that function, because GMR's not properly works, for example with death knight's
    ---diseases, when you are in a party with another DK
    ---
    ---@param unit string|userdata
    ---@param debuff string debuff's name
    ---@param byPlayer boolean work only with debuffs that sources from player
    ---@return number seconds to expire. 0 if not found, 99999 if infinite
    function amstlib.GetDebuffExpiration(unit, debuff, byPlayer)
        local spellName, expiration, owner
        local byPlayer = byPlayer or false
        for i = 1, 40 do
            spellName, _, _, _, _, expiration, owner = GMR.UnitDebuff(unit, i)
            if spellName and spellName == debuff and (not byPlayer or (byPlayer and owner == "player")) then
                if expiration - GMR.GetTime() > 0 then
                    return expiration - GMR.GetTime()
                elseif expiration == 0 then
                    return 99999
                end
            end
        end

        return 0
    end

    amstlib.CONST = {}
    amstlib.CONST.SPELL = {
        exorcism = GetSpellInfo(5614),
        flashOfLight = GetSpellInfo(19939),
        hammerOfWrath = GetSpellInfo(24275),
        handOfReckoning = GetSpellInfo(62124),
        purify = GetSpellInfo(1152),
        cleanse = GetSpellInfo(4987),
        crusaderStrike = GetSpellInfo(35395),
        consecrations = GetSpellInfo(20116),
        divineStorm = GetSpellInfo(53385),
        judgementOfLight = GetSpellInfo(20271),
        judgementOfWisdom = GetSpellInfo(53408),
        judgementOfJustice = GetSpellInfo(53407),
        devotionAura = GetSpellInfo(10293),
        retributionAura = GetSpellInfo(10301),
        concentrationAura = GetSpellInfo(19746),
        crusaderAura = GetSpellInfo(32223),
        blessingOfFreedom = GetSpellInfo(1044),
        blessingOfMight = GetSpellInfo(19837),
        blessingOfKings = GetSpellInfo(20217),
        sealOfRighteousness = GetSpellInfo(21084),
        sealOfJustice = GetSpellInfo(20164),
        sealOfLight = GetSpellInfo(20165),
        sealOfWisdom = GetSpellInfo(20166),
        sealOfCommand = GetSpellInfo(20375),
        greaterBlessingOfMight = GetSpellInfo(25916),
        greaterBlessingOfKings = GetSpellInfo(25898),
        shadowResistanceAura = GetSpellInfo(27151),
        frostResistanceAura = GetSpellInfo(19898),
        divineProtection = GetSpellInfo(498),
        handOfProtection = GetSpellInfo(5599),
        demonsBite = GetSpellInfo(162243),
        chaosStrike = GetSpellInfo(162794),
        immolationAura = GetSpellInfo(258920),
        eyeBeam = GetSpellInfo(198013),
        annihilation = GetSpellInfo(201427),
        deathSweep = GetSpellInfo(210152),
        bladeDance = GetSpellInfo(188499),
        glaiveTempest = GetSpellInfo(342817),
        sinfulBrand = GetSpellInfo(317009),
        doorOfShadows = GetSpellInfo(300728),
        frostBolt = GetSpellInfo(8408),
        rollTheBones = GetSpellInfo(315508),
        sinisterStrike = GetSpellInfo(193315),
        betweenTheEyes = GetSpellInfo(315341),
        pistolShot = GetSpellInfo(185763),
        dispatch = GetSpellInfo(2098),
        sliceAndDice = GetSpellInfo(315496),
        bladeRush = GetSpellInfo(271877),
        adrenalineRush = GetSpellInfo(13750),
        bladeFlurry = GetSpellInfo(13877),
        echoingReprimand = GetSpellInfo(323547),
        crimsonVial = GetSpellInfo(185311),
        kick = GetSpellInfo(1766),
        bearForm = GetSpellInfo(5487),
        swipe = GetSpellInfo(213771),
        mangle = GetSpellInfo(33917),
        thrash = GetSpellInfo(77758),
        moonfire = GetSpellInfo(8921),
        ironfur = GetSpellInfo(192081),
        bristlingFur = GetSpellInfo(155835),
        frenziedRegeneration = GetSpellInfo(22842),
        rake = GetSpellInfo(1822),
        shred = GetSpellInfo(5221),
        rip = GetSpellInfo(1079),
        ferociousBite = GetSpellInfo(22568),
        regrowth = GetSpellInfo(8936),
        thrash = GetSpellInfo(106830),
        primalWrath = GetSpellInfo(285381),
        catForm = GetSpellInfo(768),
        tigersFury = GetSpellInfo(5217),
        wildCharge = GetSpellInfo(49376),
        prowl = GetSpellInfo(5215),
        wrath = GetSpellInfo(190984),
        moonfire = GetSpellInfo(8921),
        plagueStrike = GetSpellInfo(45462),
        bloodPlague = GetSpellInfo(55078), -- plagues strike's debuff
        icyTouch = GetSpellInfo(45477),
        frostFever = GetSpellInfo(55095), -- icy touch's debuff
        pestilence = GetSpellInfo(50842),
        heartStrike = GetSpellInfo(55050),
        bloodStrike = GetSpellInfo(45902),
        deathStrike = GetSpellInfo(49998),
        runeTap = GetSpellInfo(48982),
        vampiricBlood = GetSpellInfo(55233),
        iceboundFortitude = GetSpellInfo(48792),
        bloodBoil = GetSpellInfo(48721),
        bloodTap = GetSpellInfo(45529),
        deathCoil = GetSpellInfo(47541),
        bloodPresence = GetSpellInfo(48266),
        frostPresence = GetSpellInfo(48263),
        unholyPresence = GetSpellInfo(48265),
        runeStrike = GetSpellInfo(56815),
        raiseDead = GetSpellInfo(46584),
        deathPact = GetSpellInfo(48743),
        hornOfWinter = GetSpellInfo(57330),
        mindFreeze = GetSpellInfo(47528),
        strangulate = GetSpellInfo(47476),
        deathGrip = GetSpellInfo(49576),
        arcaneTorrent = GetSpellInfo(50613),
        unholyFrenzy = GetSpellInfo(49016),
        deathAndDecay = GetSpellInfo(49936),
        dancingRuneWeapon = GetSpellInfo(49028),
        markOfBlood = GetSpellInfo(49005),
        corpseExplosion = GetSpellInfo(51328),
        frostStrike = GetSpellInfo(51418),
        obliterate = GetSpellInfo(51423),
        howlingBlast = GetSpellInfo(51409),
        unbreakableArmor = GetSpellInfo(51271),
        deathGate = GetSpellInfo(50977),
        chainsOfIce = GetSpellInfo(45524),
        empowerRuneWeapon = GetSpellInfo(47568),
        blessingOfWisdom = GetSpellInfo(27142),
        sealOfCorruption = GetSpellInfo(348704),
        sealOfVengeance = GetSpellInfo(31801),
        fireResistanceAura = GetSpellInfo(27153),
        holyLight = GetSpellInfo(25292),
        holyShock = GetSpellInfo(33072),
        shieldOfRighteousness = GetSpellInfo(53600),
        righteousFury = GetSpellInfo(25780),
        blessingOfSanctuary = GetSpellInfo(20911),
        holyShield = GetSpellInfo(20925),
        hammerOfTheRighteous = GetSpellInfo(53595),
        divinePlea = GetSpellInfo(54428),
        righteousDefense = GetSpellInfo(31789),
        beaconOfLight = GetSpellInfo(53563),
        arcaneBarrage = GetSpellInfo(44425),
        arcaneMissiles = GetSpellInfo(25345),
        fireBlast = GetSpellInfo(10199),
        coneOfCold = GetSpellInfo(10161),
        fireball = GetSpellInfo(10151),
        presenceOfMind = GetSpellInfo(12043),
        scourgeStrike = GetSpellInfo(55090),
        ghoulFrenzy = GetSpellInfo(63560),
        boneShield = GetSpellInfo(49222),
    }

    amstlib.CONST.SPELL_KNOWN = {
        exorcism = GMR.IsSpellKnown(amstlib.CONST.SPELL.exorcism),
        flashOfLight = GMR.IsSpellKnown(amstlib.CONST.SPELL.flashOfLight),
        hammerOfWrath = GMR.IsSpellKnown(amstlib.CONST.SPELL.hammerOfWrath),
        handOfReckoning = GMR.IsSpellKnown(amstlib.CONST.SPELL.handOfReckoning),
        purify = GMR.IsSpellKnown(amstlib.CONST.SPELL.purify),
        cleanse = GMR.IsSpellKnown(amstlib.CONST.SPELL.cleanse),
        crusaderStrike = GMR.IsSpellKnown(amstlib.CONST.SPELL.crusaderStrike),
        consecrations = GMR.IsSpellKnown(amstlib.CONST.SPELL.consecrations),
        divineStorm = GMR.IsSpellKnown(amstlib.CONST.SPELL.divineStorm),
        judgementOfLight = GMR.IsSpellKnown(amstlib.CONST.SPELL.judgementOfLight),
        judgementOfWisdom = GMR.IsSpellKnown(amstlib.CONST.SPELL.judgementOfWisdom),
        judgementOfJustice = GMR.IsSpellKnown(amstlib.CONST.SPELL.judgementOfJustice),
        devotionAura = GMR.IsSpellKnown(amstlib.CONST.SPELL.devotionAura),
        retributionAura = GMR.IsSpellKnown(amstlib.CONST.SPELL.retributionAura),
        concentrationAura = GMR.IsSpellKnown(amstlib.CONST.SPELL.concentrationAura),
        crusaderAura = GMR.IsSpellKnown(amstlib.CONST.SPELL.crusaderAura),
        blessingOfFreedom = GMR.IsSpellKnown(amstlib.CONST.SPELL.blessingOfFreedom),
        blessingOfMight = GMR.IsSpellKnown(amstlib.CONST.SPELL.blessingOfMight),
        blessingOfKings = GMR.IsSpellKnown(amstlib.CONST.SPELL.blessingOfKings),
        sealOfRighteousness = GMR.IsSpellKnown(amstlib.CONST.SPELL.sealOfRighteousness),
        sealOfJustice = GMR.IsSpellKnown(amstlib.CONST.SPELL.sealOfJustice),
        sealOfLight = GMR.IsSpellKnown(amstlib.CONST.SPELL.sealOfLight),
        sealOfWisdom = GMR.IsSpellKnown(amstlib.CONST.SPELL.sealOfWisdom),
        sealOfCommand = GMR.IsSpellKnown(amstlib.CONST.SPELL.sealOfCommand),
        greaterBlessingOfMight = GMR.IsSpellKnown(amstlib.CONST.SPELL.greaterBlessingOfMight),
        greaterBlessingOfKings = GMR.IsSpellKnown(amstlib.CONST.SPELL.greaterBlessingOfKings),
        shadowResistanceAura = GMR.IsSpellKnown(amstlib.CONST.SPELL.shadowResistanceAura),
        frostResistanceAura = GMR.IsSpellKnown(amstlib.CONST.SPELL.frostResistanceAura),
        divineProtection = GMR.IsSpellKnown(amstlib.CONST.SPELL.divineProtection),
        handOfProtection = GMR.IsSpellKnown(amstlib.CONST.SPELL.handOfProtection),
        demonsBite = GMR.IsSpellKnown(amstlib.CONST.SPELL.demonsBite),
        chaosStrike = GMR.IsSpellKnown(amstlib.CONST.SPELL.chaosStrike),
        immolationAura = GMR.IsSpellKnown(amstlib.CONST.SPELL.immolationAura),
        eyeBeam = GMR.IsSpellKnown(amstlib.CONST.SPELL.eyeBeam),
        annihilation = GMR.IsSpellKnown(amstlib.CONST.SPELL.annihilation),
        deathSweep = GMR.IsSpellKnown(amstlib.CONST.SPELL.deathSweep),
        bladeDance = GMR.IsSpellKnown(amstlib.CONST.SPELL.bladeDance),
        glaiveTempest = GMR.IsSpellKnown(amstlib.CONST.SPELL.glaiveTempest),
        sinfulBrand = GMR.IsSpellKnown(amstlib.CONST.SPELL.sinfulBrand),
        doorOfShadows = GMR.IsSpellKnown(amstlib.CONST.SPELL.doorOfShadows),
        frostBolt = GMR.IsSpellKnown(amstlib.CONST.SPELL.frostBolt),
        rollTheBones = GMR.IsSpellKnown(amstlib.CONST.SPELL.rollTheBones),
        sinisterStrike = GMR.IsSpellKnown(amstlib.CONST.SPELL.sinisterStrike),
        betweenTheEyes = GMR.IsSpellKnown(amstlib.CONST.SPELL.betweenTheEyes),
        pistolShot = GMR.IsSpellKnown(amstlib.CONST.SPELL.pistolShot),
        dispatch = GMR.IsSpellKnown(amstlib.CONST.SPELL.dispatch),
        sliceAndDice = GMR.IsSpellKnown(amstlib.CONST.SPELL.sliceAndDice),
        bladeRush = GMR.IsSpellKnown(amstlib.CONST.SPELL.bladeRush),
        adrenalineRush = GMR.IsSpellKnown(amstlib.CONST.SPELL.adrenalineRush),
        bladeFlurry = GMR.IsSpellKnown(amstlib.CONST.SPELL.bladeFlurry),
        echoingReprimand = GMR.IsSpellKnown(amstlib.CONST.SPELL.echoingReprimand),
        crimsonVial = GMR.IsSpellKnown(amstlib.CONST.SPELL.crimsonVial),
        kick = GMR.IsSpellKnown(amstlib.CONST.SPELL.kick),
        bearForm = GMR.IsSpellKnown(amstlib.CONST.SPELL.bearForm),
        swipe = GMR.IsSpellKnown(amstlib.CONST.SPELL.swipe),
        mangle = GMR.IsSpellKnown(amstlib.CONST.SPELL.mangle),
        thrash = GMR.IsSpellKnown(amstlib.CONST.SPELL.thrash),
        moonfire = GMR.IsSpellKnown(amstlib.CONST.SPELL.moonfire),
        ironfur = GMR.IsSpellKnown(amstlib.CONST.SPELL.ironfur),
        bristlingFur = GMR.IsSpellKnown(amstlib.CONST.SPELL.bristlingFur),
        frenziedRegeneration = GMR.IsSpellKnown(amstlib.CONST.SPELL.frenziedRegeneration),
        rake = GMR.IsSpellKnown(amstlib.CONST.SPELL.rake),
        shred = GMR.IsSpellKnown(amstlib.CONST.SPELL.shred),
        rip = GMR.IsSpellKnown(amstlib.CONST.SPELL.rip),
        ferociousBite = GMR.IsSpellKnown(amstlib.CONST.SPELL.ferociousBite),
        regrowth = GMR.IsSpellKnown(amstlib.CONST.SPELL.regrowth),
        thrash = GMR.IsSpellKnown(amstlib.CONST.SPELL.thrash),
        primalWrath = GMR.IsSpellKnown(amstlib.CONST.SPELL.primalWrath),
        catForm = GMR.IsSpellKnown(amstlib.CONST.SPELL.catForm),
        tigersFury = GMR.IsSpellKnown(amstlib.CONST.SPELL.tigersFury),
        prowl = GMR.IsSpellKnown(amstlib.CONST.SPELL.prowl),
        wrath = GMR.IsSpellKnown(amstlib.CONST.SPELL.wrath),
        moonfire = GMR.IsSpellKnown(amstlib.CONST.SPELL.moonfire),
        pestilence = GMR.IsSpellKnown(amstlib.CONST.SPELL.pestilence),
        heartStrike = GMR.IsSpellKnown(amstlib.CONST.SPELL.heartStrike),
        deathStrike = GMR.IsSpellKnown(amstlib.CONST.SPELL.deathStrike),
        runeTap = GMR.IsSpellKnown(amstlib.CONST.SPELL.runeTap),
        vampiricBlood = GMR.IsSpellKnown(amstlib.CONST.SPELL.vampiricBlood),
        iceboundFortitude = GMR.IsSpellKnown(amstlib.CONST.SPELL.iceboundFortitude),
        bloodBoil = GMR.IsSpellKnown(amstlib.CONST.SPELL.bloodBoil),
        bloodTap = GMR.IsSpellKnown(amstlib.CONST.SPELL.bloodTap),
        frostPresence = GMR.IsSpellKnown(amstlib.CONST.SPELL.frostPresence),
        unholyPresence = GMR.IsSpellKnown(amstlib.CONST.SPELL.unholyPresence),
        runeStrike = GMR.IsSpellKnown(amstlib.CONST.SPELL.runeStrike),
        raiseDead = GMR.IsSpellKnown(amstlib.CONST.SPELL.raiseDead),
        hornOfWinter = GMR.IsSpellKnown(amstlib.CONST.SPELL.hornOfWinter),
        mindFreeze = GMR.IsSpellKnown(amstlib.CONST.SPELL.mindFreeze),
        strangulate = GMR.IsSpellKnown(amstlib.CONST.SPELL.strangulate),
        deathGrip = GMR.IsSpellKnown(amstlib.CONST.SPELL.deathGrip),
        arcaneTorrent = GMR.IsSpellKnown(amstlib.CONST.SPELL.arcaneTorrent),
        unholyFrenzy = GMR.IsSpellKnown(amstlib.CONST.SPELL.unholyFrenzy),
        deathAndDecay = GMR.IsSpellKnown(amstlib.CONST.SPELL.deathAndDecay),
        dancingRuneWeapon = GMR.IsSpellKnown(amstlib.CONST.SPELL.dancingRuneWeapon),
        markOfBlood = GMR.IsSpellKnown(amstlib.CONST.SPELL.markOfBlood),
        corpseExplosion = GMR.IsSpellKnown(amstlib.CONST.SPELL.corpseExplosion),
        frostStrike = GMR.IsSpellKnown(amstlib.CONST.SPELL.frostStrike),
        obliterate = GMR.IsSpellKnown(amstlib.CONST.SPELL.obliterate),
        howlingBlast = GMR.IsSpellKnown(amstlib.CONST.SPELL.howlingBlast),
        unbreakableArmor = GMR.IsSpellKnown(amstlib.CONST.SPELL.unbreakableArmor),
        deathGate = GMR.IsSpellKnown(amstlib.CONST.SPELL.deathGate),
        chainsOfIce = GMR.IsSpellKnown(amstlib.CONST.SPELL.chainsOfIce),
        empowerRuneWeapon = GMR.IsSpellKnown(amstlib.CONST.SPELL.empowerRuneWeapon),
        blessingOfWisdom = GMR.IsSpellKnown(amstlib.CONST.SPELL.blessingOfWisdom),
        sealOfCorruption = GMR.IsSpellKnown(amstlib.CONST.SPELL.sealOfCorruption),
        sealOfVengeance = GMR.IsSpellKnown(amstlib.CONST.SPELL.sealOfVengeance),
        fireResistanceAura = GMR.IsSpellKnown(amstlib.CONST.SPELL.fireResistanceAura),
        holyLight = GMR.IsSpellKnown(amstlib.CONST.SPELL.holyLight),
        holyShock = GMR.IsSpellKnown(amstlib.CONST.SPELL.holyShock),
        shieldOfRighteousness = GMR.IsSpellKnown(amstlib.CONST.SPELL.shieldOfRighteousness),
        righteousFury = GMR.IsSpellKnown(amstlib.CONST.SPELL.righteousFury),
        blessingOfSanctuary = GMR.IsSpellKnown(amstlib.CONST.SPELL.blessingOfSanctuary),
        holyShield = GMR.IsSpellKnown(amstlib.CONST.SPELL.holyShield),
        hammerOfTheRighteous = GMR.IsSpellKnown(amstlib.CONST.SPELL.hammerOfTheRighteous),
        divinePlea = GMR.IsSpellKnown(amstlib.CONST.SPELL.divinePlea),
        righteousDefense = GMR.IsSpellKnown(amstlib.CONST.SPELL.righteousDefense),
        beaconOfLight = GMR.IsSpellKnown(amstlib.CONST.SPELL.beaconOfLight),
        arcaneBarrage = GMR.IsSpellKnown(amstlib.CONST.SPELL.arcaneBarrage),
        arcaneMissiles = GMR.IsSpellKnown(amstlib.CONST.SPELL.arcaneMissiles),
        fireBlast = GMR.IsSpellKnown(amstlib.CONST.SPELL.fireBlast),
        coneOfCold = GMR.IsSpellKnown(amstlib.CONST.SPELL.coneOfCold),
        fireball = GMR.IsSpellKnown(amstlib.CONST.SPELL.fireball),
        presenceOfMind = GMR.IsSpellKnown(amstlib.CONST.SPELL.presenceOfMind),
        scourgeStrike = GMR.IsSpellKnown(amstlib.CONST.SPELL.scourgeStrike),
        ghoulFrenzy = GMR.IsSpellKnown(amstlib.CONST.SPELL.ghoulFrenzy),
        boneShield = GMR.IsSpellKnown(amstlib.CONST.SPELL.boneShield),
    }

    amstlib.CONST.BUFF = {
        theArtOfWar = GetSpellInfo(59578),
        blessingOfMight = GetSpellInfo(19837),
        blessingOfKings = GetSpellInfo(20217),
        sealOfRighteousness = GetSpellInfo(21084),
        sealOfJustice = GetSpellInfo(20164),
        sealOfLight = GetSpellInfo(20165),
        sealOfWisdom = GetSpellInfo(20166),
        sealOfCommand = GetSpellInfo(20375),
        sealOfCorruption = GetSpellInfo(348704),
        sealOfVengeance = GetSpellInfo(31801),
        greaterBlessingOfMight = GetSpellInfo(25916),
        greaterBlessingOfKings = GetSpellInfo(25898),
        battleShout = GetSpellInfo(2048),
        devotionAura = GetSpellInfo(10293),
        retributionAura = GetSpellInfo(10301),
        concentrationAura = GetSpellInfo(19746),
        crusaderAura = GetSpellInfo(32223),
        shadowResistanceAura = GetSpellInfo(27151),
        frostResistanceAura = GetSpellInfo(19898),
        fireResistanceAura = GetSpellInfo(27153),
        metamorphosis = GetSpellInfo(162264),
        grandMelee = GetSpellInfo(193358),
        broadside = GetSpellInfo(193356),
        ruthlessPrecision = GetSpellInfo(193357),
        buriedTreasure = GetSpellInfo(199600),
        skullAndCrossbones = GetSpellInfo(199603),
        trueBearing = GetSpellInfo(193359),
        opportunity = GetSpellInfo(195627),
        sliceAndDice = GetSpellInfo(315496),
        echoingReprimand = GetSpellInfo(323560),
        bearForm = GetSpellInfo(5487),
        frenziedRegeneration = GetSpellInfo(22842),
        predatorySwiftness = GetSpellInfo(69369),
        catForm = GetSpellInfo(768),
        prowl = GetSpellInfo(5215),
        killingMachine = GetSpellInfo(51124),
        freezingFog = GetSpellInfo(59052),
        bloodTap = GetSpellInfo(45529),
        infusionOfLight = GetSpellInfo(54149),
        blessingOfWisdom = GetSpellInfo(27142),
        righteousFury = GetSpellInfo(25780),
        blessingOfSanctuary = GetSpellInfo(20911),
        holyShield = GetSpellInfo(20925),
        divinePlea = GetSpellInfo(54428),
        beaconOfLight = GetSpellInfo(53563),
        missileBarrage = GetSpellInfo(44401),
        presenceOfMind = GetSpellInfo(12043),
        desolation = GetSpellInfo(66817),
        ghoulFrenzy = GetSpellInfo(63560),
        boneShield = GetSpellInfo(49222),
    }

    amstlib.CONST.DEBUFF = {
        sinfulBrand = GetSpellInfo(317009),
        rake = GetSpellInfo(155722),
        rip = GetSpellInfo(1079),
        thrash = GetSpellInfo(106830),
        moonfire = GetSpellInfo(164812),
        bloodPlague = GetSpellInfo(55078), -- plagues strike's debuff
        frostFever = GetSpellInfo(55095), -- icy touch's debuff
        hammerOfJustice = GetSpellInfo(10308),
        wintersChill = GetSpellInfo(12579),
        improvedScorch = GetSpellInfo(22959),
        livingBomb = GetSpellInfo(44457),
        corruption = GetSpellInfo(27216),
        ignite = GetSpellInfo(12654),
        frostFever = GetSpellInfo(55095),
        frostbite = GetSpellInfo(12494),
        righteousVengeance = GetSpellInfo(61840),
        chainsOfIce = GetSpellInfo(45524),
        seedOfCorruption = GetSpellInfo(27243),
        strangulate = GetSpellInfo(47476),
        infectedWounds = GetSpellInfo(58181),
        coneOfCold = GetSpellInfo(27087),
        flameShock = GetSpellInfo(25457),
        moonfire = GetSpellInfo(26988),
        holyVengeance = GetSpellInfo(31803),
        thunderclap = GetSpellInfo(15588),
        woundPoison5 = GetSpellInfo(27189),
        shatteredBarrier = GetSpellInfo(55080),
        judgementOfLight = GetSpellInfo(20185),
        shadowWordPain = GetSpellInfo(25367),
        silencedShieldOfTheTemplar = GetSpellInfo(63529),
        psychicScream = GetSpellInfo(10890),
        bloodPlague = GetSpellInfo(55078),
        huntersMark = GetSpellInfo(14325),
        vampiricTouch = GetSpellInfo(34917),
        frostNova = GetSpellInfo(27088),
        judgementOfJustice = GetSpellInfo(20184),
        vindication = GetSpellInfo(26017),
        chilled = GetSpellInfo(7321),
        devouringPlague = GetSpellInfo(25467),
        insectSwarm = GetSpellInfo(27013),
        repentance = GetSpellInfo(20066),
        frostbolt = GetSpellInfo(38697),
        serpentSting = GetSpellInfo(27016),
        earthAndMoon = GetSpellInfo(60433),
        shadowfury = GetSpellInfo(30414),
        immolate = GetSpellInfo(27215),
        viperSting = GetSpellInfo(3034),
        unstableAffliction = GetSpellInfo(31117),
        haunt = GetSpellInfo(59161),
        ebonPlague = GetSpellInfo(51735),
        deathCoil = GetSpellInfo(27223),
        judgementOfWisdom = GetSpellInfo(20186),
        deadlyPoison = GetSpellInfo(34655),
        silencingShot = GetSpellInfo(34490),
        psychicHorror = GetSpellInfo(64044),
        deadlyPoison7 = GetSpellInfo(27187),
        avengersShield = GetSpellInfo(32700),
        mindTrauma = GetSpellInfo(48301),
        shadowMastery = GetSpellInfo(17800),
        shadowEmbrace = GetSpellInfo(32391),
        earthbind = GetSpellInfo(3600),
        dragonsBreath = GetSpellInfo(33043),
        cripplingPoison = GetSpellInfo(3409),
        spellLock = GetSpellInfo(24259),
        faerieFire = GetSpellInfo(770),
        envelopingWeb = GetSpellInfo(15471),
        aftermath = GetSpellInfo(18118),
        entrapment = GetSpellInfo(19185),
        cryptFever = GetSpellInfo(50509),
        blackArrow = GetSpellInfo(63670),
        faerieFireFeral = GetSpellInfo(16857),
        forbearance = GetSpellInfo(25771),
        freezingTrapEffect = GetSpellInfo(14309),
        markOfBlood = GetSpellInfo(49005),
        freeze = GetSpellInfo(33395),
    }

    amstlib.CONST.GLYPH = {
        glyphOfDisease = GetSpellInfo(63334),
        glyphOfPestilence = GetSpellInfo(59309),
        glyphOfRaiseDead = GetSpellInfo(60200),
        glyphofFrostStrike = GetSpellInfo(57216),
    }

    amstlib.CONST.INVENTORY = {}

    amstlib.CONST.INVENTORY.SLOT_ID = {
        TRINKET_1 = 13,
        TRINKET_2 = 14,
    }

    amstlib.CONST.CLASS = {
        WARRIOR = "WARRIOR",
        PALADIN = "PALADIN",
        HUNTER = "HUNTER",
        ROGUE = "ROGUE",
        PRIEST = "PRIEST",
        DEATHKNIGHT = "DEATHKNIGHT",
        SHAMAN = "SHAMAN",
        MAGE = "MAGE",
        WARLOCK = "WARLOCK",
        MONK = "MONK",
        DRUID = "DRUID",
        DEMONHUNTER = "DEMONHUNTER",
        EVOKER = "EVOKER",
    }

    function amstlib.close()
        for name, cr in pairs(amstlib.combatRotations) do
            GMR.Print("closing '" .. name .. "' rotation")
            cr:close()
            GMR.Print("'" .. name .. "' rotation has been closed")
        end
    end

    ---@class AmstLibCombatRotation
    AmstLibCombatRotation = {}
    AmstLibCombatRotation.id = ""
    ---@type boolean
    AmstLibCombatRotation.isPrepared = false
    ---@type boolean
    AmstLibCombatRotation.isInitialized = false
    AmstLibCombatRotation.version = ""
    AmstLibCombatRotation.msgPrefix = "[CR]"
    AmstLibCombatRotation.previousDbgMessagePerSlot = {}
    ---@type AmstLibTimerList
    AmstLibCombatRotation.timers = {}
    AmstLibCombatRotation.closeFuncs = {}
    AmstLibCombatRotation.config = {
        onlineLoad = true,
        debug = false,
        ---@type boolean
        useCombatRotationLauncher = true,
    }

    ---@param id string
    ---@return AmstLibCombatRotation
    function AmstLibCombatRotation:new(id)
        ---@type AmstLibCombatRotation
        local o = {id = id, timers = AmstLibTimerList:new()}
        setmetatable(o, self)
        self.__index = self

        o.msgPrefix = "[" .. id .. "]"

        return o
    end

    ---@param id string
    ---@return AmstLibCombatRotation
    function amstlib:getCombatRotation(id)
        if not self.combatRotations[id] then
            self.combatRotations[id] = AmstLibCombatRotation:new(id)
        end

        return self.combatRotations[id]
    end

    ---@param config table
    function AmstLibCombatRotation:validateConfig(config)
        local fields = {"debug", "onlineLoad", "useCombatRotationLauncher"}
        for _, f in ipairs(fields) do
            if config[f] == nil then
                error("there is no '" .. f .. "' field in config")
            end
        end
    end

    function AmstLibCombatRotation:close()
        self.timers:close()
        GMR.CustomCombatConditions = function() end
        for _, closeFunc in ipairs(self.closeFuncs) do
            closeFunc()
        end
        GMR.Print(tostring(#self.closeFuncs) .. " close-funcs has been called")
    end

    ---@param config table
    ---@return boolean, string result and details
    function AmstLibCombatRotation:prepare(config)
        self:validateConfig(config)

        self.config = config
        self.isPrepared = true
    end

    ---@param msg string
    ---@return void
    function AmstLibCombatRotation:print(msg)
        GMR.Print(self.msgPrefix .. " " .. msg)
    end

    ---@param msg string
    ---@param slot number
    ---@return void
    function AmstLibCombatRotation:printDbg(msg, slot)
        slot = slot or 1
        if not self.config.debug then
            return
        end

        if msg == self.previousDbgMessagePerSlot[slot] then
            return
        end

        GMR.Print(self.msgPrefix .. "[DEBUG] " .. tostring(msg))
        self.previousDbgMessagePerSlot[slot] = msg
    end

    ---@param msg string
    ---@return void
    function AmstLibCombatRotation:printError(msg)
        GMR.Print(self.msgPrefix .. "[ERROR] " .. tostring(msg))
    end

    function AmstLibCombatRotation:getConfig()
        if not self.isPrepared then
            error("Combat rotation is not prepared")
        end

        return self.config
    end

    ---@param link string URL to load
    ---@param callback fun():void function to call after exec link's content
    ---@return boolean, string result and details
    function AmstLibCombatRotation:load(link, callback)
        if not self.isPrepared then
            error("rotation not prepared, should call prepare() func first")
            return
        end

        if self.config.onlineLoad then
            self:printDbg("start loading rotation file '" .. link .. "'")
            GMR.SendHttpRequest({
                Url = link,
                Method = "Get",
                Callback = function(content)
                    self:printDbg("rotation has been downloaded, executing it")
                    RunScript(content)
                    self:printDbg("rotation has been executed")
                    if callback then
                        self:printDbg("rotation's loader has callback, start executing it")
                        callback()
                        self:printDbg("callback has been executed")
                    end
                end
            })
        else
            self:print("Offline loading turned on")
        end
    end

    ---@param version string
    ---@param checkFunc fun():boolean
    ---@param createFunc fun():fun(),fun(),fun() function create of rotation's executer, after launch utility function, close operations function
    function AmstLibCombatRotation:initialize(version, checkFunc, createFunc)
        if not version then
            error("version is empty")
        end
        if not self.isPrepared then
            error("rotation is not prepared")
        end
        self.version = version
        self.msgPrefix = "[" .. self.id .. "|" .. version .. "]"

        if not checkFunc() then
            return false
        end

        if self.isInitialized then
            self:print("this combat rotation already initialized, nothing new will happen")
            return
        end
        self.isInitialized = true

        self:print("Rotation would be initialized")
        local rotation, callAfterLaunch, closeFunc = createFunc()
        local executeRotationFunc = function()
            local isSuccess, err = pcall(rotation)
            if not isSuccess then
                self:printError("Can't launch rotation: " .. err)
            end
        end

        if self.config.useCombatRotationLauncher then
            local resultFunction
            if GMR.CustomCombatConditions == nil then
                resultFunction = executeRotationFunc
            else
                self:print("There is another combat conditions, it will be merged with this rotation")
                local oldCombatConditions = GMR.CustomCombatConditions
                resultFunction = function()
                    local isSuccess, err = pcall(oldCombatConditions)
                    if not isSuccess then
                        self:printError("Can't launch previous custom combat rotation: " .. err)
                    end
                    executeRotationFunc()
                end
            end

            GMR.CustomCombatConditions = resultFunction
            self.timers:add(C_Timer.NewTicker(1, function()
                if GMR.CustomCombatConditions ~= resultFunction then
                    GMR.CustomCombatConditions = resultFunction
                    self:printError("Something changed GMR.CustomCombatConditions func, it was changed back!")
                end
            end))
        else
            self.timers:add(C_Timer.NewTicker(0.1, function()
                if (not GMR.IsExecuting() or not GMR.IsAlive()) then
                    return
                end

                if GMR.IsEating("player") or GMR.IsDrinking("player") then
                    return
                end

                executeRotationFunc()
            end))
        end

        if callAfterLaunch then
            callAfterLaunch()
        end

        if closeFunc then
            table.insert(self.closeFuncs, closeFunc)
        end

        self:print("Rotation fully initialized and turned on.")
        return
    end

    ---Check is spell castable. I have to add this method, because original GMR.IsCastable and even WoW's API methods not
    ---works properly with some melee spells (Retail Rogue, Retail Demon Hunter) and can't determine properly valid
    ---destination (it think valid destination is shorter).
    ---
    ---@param spellToCheckRange string spell, that would be used to determine real destination instead of spell with issue
    ---@return fun(spell:string, unit:string):boolean
    function amstlib.createIsCastableFunc(spellToCheckRange)
        return function(spell, unit)
            local isSpellInRange = GMR.IsSpellInRange(spell, unit)
            if isSpellInRange == nil then
                GMR.IsSpellInRange(spellToCheckRange, unit)
            end
            return isSpellInRange
                and GMR.IsSpellUsable(spell)
                and GetSpellCooldown(spell) == 0
                and GMR.InLoS("player", unit)
        end
    end

    ---@class AmstLibInterrupter
    AmstLibInterrupter = {
        ---@type string[]
        priority1List = {},
        ---@type string[]
        priority2List = {},

    }

    ---@return AmstLibInterrupter
    function AmstLibInterrupter:new(priority1List, priority2List)
        local o = {priority1List = priority1List, priority2List = priority2List}
        setmetatable(o, self)
        self.__index = self
        return o
    end

    ---@param unit string|userdata
    ---@return number @2 - interrupt at all cost, 1 - interrupt with common interrupt spell, 0 - do not interrupt
    function AmstLibInterrupter:shouldInterrupt(unit)
        if not amstlib.Util.canInterruptSafely(unit) then
            return 0
        end

        local name = GMR.UnitCastingInfo(unit)
        if not name then
            return 0
        end

        for _, spell in ipairs(self.priority2List) do
            if spell == name then
                return 2
            end
        end

        for _, spell in ipairs(self.priority1List) do
            if spell == name then
                return 1
            end
        end

        return 0
    end

    ---@param distance number
    ---@return userdata[], userdata[] unitPriority1List, unitPriority2List; 1 - use common interrupt spell, 2 - interrupt at all cost
    function AmstLibInterrupter:searchUnitToInterrupt(distance)
        local unitPriority1List = {}
        local unitPriority2List = {}
        for i = 1, #GMR.Tables.Attackables do
            local attackable = GMR.Tables.Attackables[i][1]
            if GMR.ObjectExists(attackable) and GMR.GetDistance("player", attackable, "<", distance) then
                local res = self:shouldInterrupt(attackable)
                if res == 1 then
                    table.insert(unitPriority1List, attackable)
                elseif res == 2 then
                    table.insert(unitPriority2List, attackable)
                end
            end
        end

        return unitPriority1List, unitPriority2List
    end

    amstlib.defaultInterrupter = AmstLibInterrupter:new({}, {
        amstlib.CONST.SPELL.frostBolt,
    })

    amstlib.Util = {}
    ---@param unit string|userdata
    ---@return boolean
    function amstlib.Util.canInterruptSafely(unit)
        local name, _, _, startTimeMS = GMR.UnitCastingInfo(unit)
        if not name then
            return false
        end

        --- should not cast it instantaneously
        if (GetTime() - startTimeMS / 1000) < math.random(5, 8) / 10 then
            return false
        end

        return true
    end

    function amstlib.Util.printTable(tbl)
        for k, v in pairs(tbl) do
            GMR.Print("[" .. tostring(k) .. "] => '" .. tostring(v) .. "'")
        end
    end

    ---Calculates total amount of talents in each tab
    ---@return table<number, number> table, key is tab index, value is total count of talents in that tab
    function amstlib.Util.calculateTalentsPerTab()
        local talents = {}
        for tabIndex = 1, GetNumTalentTabs() do
            talents[tabIndex] = 0
            for talentIndex = 1, GetNumTalents(tabIndex) do
                talents[tabIndex] = talents[tabIndex] + select(5, GetTalentInfo(tabIndex, talentIndex))
            end
        end

        return talents
    end

    ---@return number tab index with most talents points spent
    function amstlib.Util.getDeepestTalentTab()
        local talentsSummary = amstlib.Util.calculateTalentsPerTab()
        local maxTabIndex = 0
        local maxTalentsCount = 0
        for tabIndex, count in ipairs(talentsSummary) do
            if count > maxTalentsCount then
                maxTabIndex = tabIndex
                maxTalentsCount = count
            end
        end

        return maxTabIndex
    end

    GMR.RunEncryptedScript("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")

    -- ---------------- --
    -- --- TRINKETS --- --
    -- ---------------- --

    amstlib.CONST.TRINKET_TYPE = {
        SELF_BUFF = 1,
        TARGET_HARMFUL = 2,
        AOE_HARMFUL = 3,
    }

    ---@class AmstLibTrinket
    AmstLibTrinket = {}
    ---@type number
    AmstLibTrinket.index = 0
    ---@type number
    AmstLibTrinket.inventoryId = 0
    ---@type number
    AmstLibTrinket.type = 0

    ---@return AmstLibTrinket
    function AmstLibTrinket:new(index, type)
        local inventoryId = 0
        if index == 1 then
            inventoryId = amstlib.CONST.INVENTORY.SLOT_ID.TRINKET_1
        elseif index == 2 then
            inventoryId = amstlib.CONST.INVENTORY.SLOT_ID.TRINKET_2
        else
            error("invalid trinket index '" .. tostring(type) .. "'")
        end

        if type ~= amstlib.CONST.TRINKET_TYPE.SELF_BUFF and type ~= amstlib.CONST.TRINKET_TYPE.TARGET_HARMFUL
            and type ~= amstlib.CONST.TRINKET_TYPE.AOE_HARMFUL
        then
            error("invalid type '" .. tostring(type) .. "'")
        end

        local o = {
            index = index,
            inventoryId = inventoryId,
            type = type,
        }
        setmetatable(o, self)
        self.__index = self
        return o
    end

    ---@class AmstLibTrinketer
    AmstLibTrinketer = {}
    ---@type AmstLibCombatRotation
    AmstLibTrinketer.cr = nil
    ---@type AmstLibTrinket[]
    AmstLibTrinketer.trinkets = {}
    ---@type boolean
    AmstLibTrinketer.isInitialized = false
    AmstLibTrinketer.spellToCheckGCD = ""

    ---@param cr AmstLibCombatRotation
    function AmstLibTrinketer:new(cr)
        local o = {cr = cr}
        setmetatable(o, self)
        self.__index = self
        return o
    end

    ---@param spellToCheckGCD string
    ---@return void
    function AmstLibTrinketer:initialize(spellToCheckGCD)
        if not self.cr.isPrepared then
            error("can't initialize trinket usage, because rotation not prepared")
        end
        if not spellToCheckGCD then
            error("spell to check GCD is empty")
        end

        local fieldsToUse = {"useTrinket1", "useTrinket1Type", "useTrinket2", "useTrinket2Type"}
        local missedFields = {}
        for _, field in ipairs(fieldsToUse) do
            if self.cr:getConfig()[field] == nil then
                table.insert(missedFields, field)
            end
        end

        if #missedFields > 0 then
            local fieldsAsStr = ""
            for i, f in ipairs(missedFields) do
                if i > 1 then
                    fieldsAsStr = fieldsAsStr .. ", "
                end
                fieldsAsStr = fieldsAsStr .. f
            end
            self.cr:printError("can't initialize trinket usage, because config do not have necessary fields: " .. fieldsAsStr)
            return
        end

        self.spellToCheckGCD = spellToCheckGCD

        local trinketRawData = {}
        if self.cr:getConfig()["useTrinket1"] then
            table.insert(trinketRawData, {1, self.cr:getConfig()["useTrinket1Type"]})
        end
        if self.cr:getConfig()["useTrinket2"] then
            table.insert(trinketRawData, {2, self.cr:getConfig()["useTrinket2Type"]})
        end
        for _, trinketData in ipairs(trinketRawData) do
            local trinket = AmstLibTrinket:new(trinketData[1], trinketData[2])
            table.insert(self.trinkets, trinket)
            self.cr:print("Character will use trinket with inventory id '" .. tostring(trinket.inventoryId) .. "' type '" .. tostring(trinket.type) .. "' ")
        end

        self.isInitialized = true
    end

    ---@return boolean has been used
    function AmstLibTrinketer:useTrinkets()
        if not self.isInitialized then
            return false
        end

        for _, trinket in ipairs(self.trinkets) do
            local itemId = GetInventoryItemID("player", trinket.inventoryId)
            local cooldownStart, duration = GetItemCooldown(itemId)
            if cooldownStart == 0 and GMR.IsCastable(self.spellToCheckGCD, "player") then
                if trinket.type == amstlib.CONST.TRINKET_TYPE.AOE_HARMFUL then
                    if not GMR.IsMoving() and GMR.GetNumEnemies("player", 15) >= 1 then
                        self.cr:printDbg("should use trinket #" .. tostring(trinket.index) .. " as AOE")
                        GMR.RunMacroText("/use [@player] " .. tostring(trinket.inventoryId))
                        return true
                    end
                elseif trinket.type == amstlib.CONST.TRINKET_TYPE.SELF_BUFF
                    and GMR.GetDistance("player", "target", "<", 6)
                then
                    self.cr:printDbg("should use trinket #" .. tostring(trinket.index) .. " as self-buff")
                    GMR.Use(itemId)
                    return true
                elseif trinket.type == amstlib.CONST.TRINKET_TYPE.TARGET_HARMFUL
                    and GMR.GetDistance("player", "target", "<", 6)
                then
                    self.cr:printDbg("should use trinket #" .. tostring(trinket.index) .. " as target harmful")
                    GMR.Use(itemId)
                    return true
                end
            end
        end

        return false
    end

    -- ----------- --
    -- TTL Storage --
    -- ----------- --

    ---@class AmstLibTtlStorage
    AmstLibTtlStorage = {}
    ---@type table<string, table>
    AmstLibTtlStorage.data = {}
    ---@type AmstLibTimerList
    AmstLibTtlStorage.timers = nil

    function AmstLibTtlStorage:new()
        ---@type AmstLibTtlStorage
        local o = {
            timers = AmstLibTimerList:new()
        }
        setmetatable(o, self)
        self.__index = self

        o.timers:add(C_Timer.NewTicker(0.1, function()
            local curTime = GetTime()
            local keysToRemove = {}
            for k, v in pairs(o.data) do
                if v[2] < curTime then
                    table.insert(keysToRemove, k)
                end
            end

            for _, keyToRemove in ipairs(keysToRemove) do
                o.data[keyToRemove] = nil
            end
        end))

        return o
    end
    function AmstLibTtlStorage:get(key)
        if not self.data[key] then
            return nil
        end

        return self.data[key][1]
    end
    function AmstLibTtlStorage:set(key, value, ttl)
        self.data[key] = {value, GetTime() + ttl}
    end
    function AmstLibTtlStorage:close()
        self.timers:close()
    end

    -- ---------- --
    -- Timer List --
    -- ---------- --

    ---@class AmstLibTimerList
    AmstLibTimerList = {}
    ---@type WoWAPITimer[]
    AmstLibTimerList.timers = {}

    function AmstLibTimerList:new()
        ---@type AmstLibTimerList
        local o = {
            timers = {},
        }
        setmetatable(o, self)
        self.__index = self

        return o
    end
    ---@param timer WoWAPITimer
    function AmstLibTimerList:add(timer)
        table.insert(self.timers, timer)
    end
    function AmstLibTimerList:close()
        for _, timer in ipairs(self.timers) do
            timer:Cancel()
        end
        GMR.Print(tostring(#self.timers) .. " timers has been closed")
        self.timers = {}
    end
end)

if not isSuccess then
    GMR.Print("[ERROR] " .. err)
end