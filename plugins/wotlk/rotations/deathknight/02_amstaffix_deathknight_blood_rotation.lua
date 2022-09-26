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

AMST_SHARE = AMST_SHARE or {}
local VERSION = "v1.13.0"
local printMsgPrefix = "[CR>DK/B|" .. VERSION .. "] "
---Print message with CR prefix
---@param msg string
local function Print(msg)
	GMR.Print(printMsgPrefix .. msg)
end

local function Error(msg)
	Print(printMsgPrefix .. "[ERROR] " .. msg)
end

local spells = {
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
}

local spellKnown = {
	pestilence = GMR.IsSpellKnown(spells.pestilence),
	heartStrike = GMR.IsSpellKnown(spells.heartStrike),
	deathStrike = GMR.IsSpellKnown(spells.deathStrike),
	runeTap = GMR.IsSpellKnown(spells.runeTap),
	vampiricBlood = GMR.IsSpellKnown(spells.vampiricBlood),
	iceboundFortitude = GMR.IsSpellKnown(spells.iceboundFortitude),
	bloodBoil = GMR.IsSpellKnown(spells.bloodBoil),
	bloodTap = GMR.IsSpellKnown(spells.bloodTap),
	frostPresence = GMR.IsSpellKnown(spells.frostPresence),
	unholyPresence = GMR.IsSpellKnown(spells.unholyPresence),
	runeStrike = GMR.IsSpellKnown(spells.runeStrike),
	raiseDead = GMR.IsSpellKnown(spells.raiseDead),
	hornOfWinter = GMR.IsSpellKnown(spells.hornOfWinter),
	mindFreeze = GMR.IsSpellKnown(spells.mindFreeze),
	strangulate = GMR.IsSpellKnown(spells.strangulate),
	deathGrip = GMR.IsSpellKnown(spells.deathGrip),
	arcaneTorrent = GMR.IsSpellKnown(spells.arcaneTorrent),
	unholyFrenzy = GMR.IsSpellKnown(spells.unholyFrenzy),
	deathAndDecay = GMR.IsSpellKnown(spells.deathAndDecay),
	dancingRuneWeapon = GMR.IsSpellKnown(spells.dancingRuneWeapon),
	markOfBlood = GMR.IsSpellKnown(spells.markOfBlood),
	corpseExplosion = GMR.IsSpellKnown(spells.corpseExplosion),
}

local glyphSpells = {
	glyphOfDisease = GetSpellInfo(63334),
	glyphOfPestilence = GetSpellInfo(59309),
	glyphOfRaiseDead = GetSpellInfo(60200),
}

---@class DeathKnightBloodConfig
local Config = {
	---Toggle debug mode. Turn on, if you encounter some issues and want to deal with it, or record a video and send
	---to author.
	debug = false,
	---Use standard CombatRotation pluggable function. Change only if you know what you are doing.
	useCombatRotationLauncher = true,
	---Use online loading feature to get last updates
	onlineLoad = true,
	---Min HP to cast Rune Tap, if known
	runeTapHpUse = 80,
	---Min HP to cast Vampiric Blood
	vampiricBloodHpUse = 70,
	---Min HP to cast Icebound Fortitude
	iceboundFortitudeHpUse = 50,
	bloodBoilEnabled = true,
	---Should bot use only blood runes for blood-runes offensive spells like Blood Boil, Heart/Blood Strike
	useBloodFillersWithBloodRunesOnly = true,
	---Min enemies to start using Blood Boil instead off Blood/Hearth Strike
	bloodBoilMinEnemies = 3,
	---Default presence
	--- - 1:blood;
	--- - 2:frost;
	--- - 3:unholy;
	defaultPresence = 1,
	---Change presence on frost, if HP < X. Change it to 0 to turn off
	minHpToChangeToFrostPresence = 60,
	---Min enemies to cast raise dead spell
	minEnemiesCountToRaiseDead = 2,
	---Should use Rune Strike
	useRuneStrike = true,
	---Delay between Rune Strike usage. If you encounter some issues with rune strike, tune this option.
	useRuneStrikeDelay = 0.5,
	---Min HP to start using Death Strike more often
	minHPToUseDeathStrikeMoreOften = 90,
	minHPToUseDeathPact = 80,
	useStrangulateToInterruptCasts = true,
	useDeathGripToInterruptCasts = true,

	useUnholyFrenzyOnSelf = true,
	useUnholyFrenzyMinEnemies = 3,

	useDeathAndDecay = false,
	useDeathAndDecayMinEnemies = 3,

	useDancingRuneWeaponMinEnemies = 3,

	useMarkOfBloodMinEnemies = 3,
	useMarkOfBloodMinHP = 70,

	useDeathCoilOnEnemy = true,
	useDeathCoilOnEnemyMaxEnemies = 1,

	useCorpseExplosion = true,
	useCorpseExplosionMinEnemies = 3,
}
function Config:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	return o
end

---Apply object to change default values
---@param object DeathKnightBloodConfig another config
function Config:apply(object)
	object = object or {}
	for k, v in pairs(object) do
		if self[k] == nil then
			Print("Unknown config key '" .. tostring(k) .. "', skip.")
		elseif self[k] ~= v then
			Print("Option '" .. tostring(k) .. "' changed from '" .. tostring(self[k]) .. "' to '" .. tostring(v) .. "'.")
			self[k] = v
		end
	end
end

local RUNETYPE_BLOOD = 1
local RUNETYPE_UNHOLY = 2
local RUNETYPE_FROST = 3
local RUNETYPE_DEATH = 4

---@class DeathKnightBloodState
local State = {
	defaultPresenceSkill = spells.bloodPresence,
	hasGlyphOfDisease = false,
	pestilenceRadius = 10,
	raiseDeadConsumeItem = true,
	lastRuneStrikeUsed = 0,
	explodedCorpses = {},
	lastCorpseIdForExplosion = "",
}
function State:new()
	local o = { }
	setmetatable(o, self)
	self.__index = self
	return o
end

---Determine state
---@param cfg DeathKnightBloodConfig config
---@return void
function State:determine(cfg)
	if cfg.defaultPresence == 1 then
		self.defaultPresenceSkill = spells.bloodPresence
	elseif cfg.defaultPresence == 2 and spellKnown.frostPresence then
		self.defaultPresenceSkill = spells.frostPresence
	elseif cfg.defaultPresence == 3 and spellKnown.unholyPresence then
		self.defaultPresenceSkill = spells.unholyPresence
	end
	Print("Character will use '" .. self.defaultPresenceSkill .. "' as default presence")

	for socketId = 1, GetNumGlyphSockets() do
		local enabled, _, spellId = GetGlyphSocketInfo(socketId)
		if enabled then
			local spellInfo = GetSpellInfo(spellId)
			if spellInfo == glyphSpells.glyphOfDisease then
				Print("Character has Glyph of Disease, CR should use pestilence to renew debuffs.")
				self.hasGlyphOfDisease = true
			elseif spellInfo == glyphSpells.glyphOfPestilence then
				Print("Character has Glyph of Pestilence, radius of Pestilence is 15 now.")
				self.pestilenceRadius = 15
			elseif spellInfo == glyphSpells.glyphOfRaiseDead then
				self.raiseDeadConsumeItem = false
			end
		end
	end
end

---@param cfg DeathKnightBloodConfig
---@return fun(msg:string):void
local function createDbgPrintFunc(cfg)
	if cfg.debug == false then
		return function()
		end
	end

	return function(msg)
		local message = "[DEBUG] " .. msg
		GMR.Print(message)
		GMR.Log(message)
	end
end

---@class DeathKnightBloodRotation
local Rotation = {
	---@type DeathKnightBloodConfig
	cfg = nil,
	---@type DeathKnightBloodState
	state = nil,
	---@type fun(msg:string):void
	dbgPrint = function(msg)
	end
}
---@param cfg DeathKnightBloodConfig
---@param state DeathKnightBloodState
---@return DeathKnightBloodRotation
function Rotation:new(cfg, state)
	local dbgPrint = createDbgPrintFunc(cfg)

	---@type DeathKnightBloodRotation
	local o = {
		cfg = cfg,
		state = state,
		dbgPrint = dbgPrint,
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

---@return boolean spell casted
function Rotation:useSpellWithPreBloodTap(spell, unit)
	-- spell cd and shortage on runes use same cooldown info, so we can understand which type of CD it only by CD
	-- duration
	local cooldownDuration = select(2, GetSpellCooldown(spell))
	if cooldownDuration > 10 then
		return false
	end

	if not GMR.IsCastable(spell, unit) and spellKnown.bloodTap then
		if GetSpellCooldown(spells.bloodTap) == 0 then
			self.dbgPrint("should cast blood tap to generate blood rune")
			GMR.Cast(spells.bloodTap, "player")
			return true
		end
	end

	if GMR.IsCastable(spell, unit) then
		self.dbgPrint("should cast blood tap to generate blood rune")
		GMR.Cast(spell, unit)
		return true
	end

	return false
end

---Calculate available runes and group them by type
---@return table<number, number> map runeType to count
local function calculateRunes()
	local runesSummary = {
		[RUNETYPE_BLOOD] = 0,
		[RUNETYPE_FROST] = 0,
		[RUNETYPE_UNHOLY] = 0,
		[RUNETYPE_DEATH] = 0,
	}
	for runeSlot = 1, 6 do
		if select(3, GetRuneCooldown(runeSlot)) then
			local runeType = GetRuneType(runeSlot)
			runesSummary[runeType] = runesSummary[runeType] + 1
		end
	end

	return runesSummary
end

---@return void
function Rotation:execute()
	for i = 1, #GMR.Tables.Attackables do
		local attackable = GMR.Tables.Attackables[i][1]
		if GMR.ObjectExists(attackable) and GMR.IsInterruptable(attackable) and GMR.UnitCastingTime(attackable, 2) then
			if spellKnown.mindFreeze and GMR.IsCastable(spells.mindFreeze) and GMR.IsSpellInRange(spells.mindFreeze, attackable)
				and GetSpellCooldown(spells.mindFreeze) == 0 then
				self.dbgPrint("should use mind freeze to interrupt cast.")
				GMR.Cast(spells.mindFreeze, attackable)
				return
			elseif spellKnown.arcaneTorrent and GMR.GetDistance("player", attackable, "<", 8)
				and GMR.IsCastable(spells.arcaneTorrent, "player") and GetSpellCooldown(spells.arcaneTorrent) == 0
			then
				self.dbgPrint("should use arcane torrent to interrupt cast.")
				GMR.Cast(spells.arcaneTorrent, "player")
				return
			elseif self.cfg.useStrangulateToInterruptCasts and spellKnown.strangulate
				and GMR.GetDistance("player", attackable, ">", 8) and GMR.IsSpellInRange(spells.strangulate, attackable)
				and GMR.IsCastable(spells.strangulate, attackable) and GetSpellCooldown(spells.strangulate) == 0
			then
				self.dbgPrint("should use strangulate to interrupt cast.")
				GMR.Cast(spells.strangulate, attackable)
				return
			elseif self.cfg.useDeathGripToInterruptCasts and spellKnown.deathGrip
				and GMR.GetDistance("player", attackable, ">", 5) and GMR.IsSpellInRange(spells.deathGrip, attackable)
				and GMR.IsCastable(spells.deathGrip, attackable) and GetSpellCooldown(spells.deathGrip) == 0
			then
				self.dbgPrint("should use death grip to interrupt cast.")
				GMR.Cast(spells.deathGrip, attackable)
				return
			end
			break -- if nothing works, just stop iteration
		end
	end

	if self.cfg.useUnholyFrenzyOnSelf and spellKnown.unholyFrenzy and GMR.IsCastable(spells.unholyFrenzy, "player")
		and GMR.GetNumEnemies("player", 10) >= self.cfg.useUnholyFrenzyMinEnemies
	then
		self.dbgPrint("should cast unholy frenzy")
		GMR.Cast(spells.unholyFrenzy, "player")
		return
	end

	if spellKnown.raiseDead and GetSpellCooldown(spells.raiseDead) > 0 then
		local secondsLeftAfterCast = GetTime() - GetSpellCooldown(spells.raiseDead)
		if secondsLeftAfterCast >= 45 and secondsLeftAfterCast <= 60 and GMR.GetHealth("player") < self.cfg.minHPToUseDeathPact
			and GMR.IsCastable(spells.deathPact, "player")
		then
			self.dbgPrint("should cast Death Pact to heal")
			GMR.Cast(spells.deathPact, "player")
			return
		end
	end

	if self.cfg.useRuneStrike and spellKnown.runeStrike and GMR.IsCastable(spells.runeStrike, "target")
		and GetTime() - self.state.lastRuneStrikeUsed > 0.5
	then
		self.dbgPrint("should turn on rune strike")
		GMR.Cast(spells.runeStrike, "target")
		self.state.lastRuneStrikeUsed = GetTime()
	end

	--self.dbgPrint("should do")

	if self.cfg.useDeathCoilOnEnemy and GMR.GetNumEnemies("player", 10) <= self.cfg.useDeathCoilOnEnemyMaxEnemies
		and UnitPower("player", 6) >= 85 and GMR.IsCastable(spells.deathCoil, "target")
		and GMR.IsSpellInRange(spells.deathCoil, "target")
	then
		self.dbgPrint("use deth coil to spend rune power")
		GMR.Cast(spells.deathCoil, "target")
		return
	end

	--- Testing in progress, do not use it on your own
	if self.cfg.useCorpseExplosion and spellKnown.corpseExplosion and GMR.IsCastable(spells.corpseExplosion, "player")
		and GMR.GetNumEnemies("player", 10) >= self.cfg.useCorpseExplosionMinEnemies
	then
		local corpseIdToExplode = ""
		local objs = GMR.GetNearbyObjects(10)
		for id, _ in pairs(objs) do
			local createTypeId = GMR.ObjectCreatureTypeId(id)
			if createTypeId then
				if GMR.UnitIsDead(id) then
					local found = false
					for alreadyExplodedCorpseObjectId, _ in pairs(self.state.explodedCorpses) do
						if alreadyExplodedCorpseObjectId == id then
							found = true
							break
						end
					end
					if not found then
						corpseIdToExplode = id
						self.dbgPrint("Has corpse to explode id:'" .. tostring(id) .. "'; create-type-id:'" .. tostring(createTypeId) .. "'")
						break
					end
				end
			end
		end
		if corpseIdToExplode ~= "" then
			self.dbgPrint("should use corpse explosion")
			GMR.Cast(spells.corpseExplosion, "player")
			self.state.lastCorpseIdForExplosion = corpseIdToExplode
			return
		end
	end
	if GetSpellCooldown(spells.corpseExplosion) ~= 0 and self.state.lastCorpseIdForExplosion then
		self.state.explodedCorpses[self.state.lastCorpseIdForExplosion] = GetTime() + 60
		self.state.lastCorpseIdForExplosion = ""
	end

	if GMR.HasBuff("player", self.state.defaultPresenceSkill) then
		if self.state.defaultPresenceSkill ~= spells.frostPresence and GMR.GetHealth("player") < self.cfg.minHpToChangeToFrostPresence
			and GMR.IsCastable(spells.frostPresence, "player")
		then
			self.dbgPrint("should use frost presence")
			GMR.Cast(spells.frostPresence, "player")
			return
		end
	else
		if GMR.GetHealth("player") >= 99 and GMR.IsCastable(self.state.defaultPresenceSkill, "player") then
			self.dbgPrint("should use default presence '" .. self.state.defaultPresenceSkill .. "'")
			GMR.Cast(self.state.defaultPresenceSkill, "player")
			return
		end
	end

	if spellKnown.vampiricBlood and GMR.GetHealth("player") <= self.cfg.vampiricBloodHpUse then
		local casted = self:useSpellWithPreBloodTap(spells.vampiricBlood, "player")
		if casted then
			return
		end
	end

	if spellKnown.runeTap and GMR.GetHealth("player") <= self.cfg.runeTapHpUse then
		local casted = self:useSpellWithPreBloodTap(spells.runeTap, "player")
		if casted then
			return
		end
	end

	--self.dbgPrint("should do stage 2")

	if spellKnown.iceboundFortitude and GMR.IsCastable(spells.iceboundFortitude, "player")
		and GMR.GetHealth("player") <= self.cfg.iceboundFortitudeHpUse
	then
		self.dbgPrint("should use icebound fortitude")
		GMR.Cast(spells.iceboundFortitude, "player")
		return
	end

	if spellKnown.dancingRuneWeapon and GMR.IsCastable(spells.dancingRuneWeapon, "target")
		and GMR.GetNumEnemies("player", 10) >= self.cfg.useDancingRuneWeaponMinEnemies
	then
		self.dbgPrint("should cast dancing weapon")
		GMR.Cast(spells.dancingRuneWeapon, "target")
		return
	end

	if spellKnown.markOfBlood and GMR.IsCastable(spells.markOfBlood, "target")
		and GMR.GetHealth("player") <= self.cfg.useMarkOfBloodMinHP
		and GMR.GetNumEnemies("player", 10) >= self.cfg.useMarkOfBloodMinEnemies
	then
		self.dbgPrint("should use mark of blood")
		GMR.Cast(spells.markOfBlood, "target")
		return
	end

	if self.cfg.useDeathAndDecay and spellKnown.deathAndDecay
		and GMR.GetNumEnemies("player", 10) >= self.cfg.useDeathAndDecayMinEnemies
		and GMR.IsCastable(spells.deathAndDecay, "player")
	then
		self.dbgPrint("should use death and decay")
		GMR.Cast(spells.deathAndDecay, "player")
		return
	end

	local targetBloodPlagueDuration = GMR.GetDebuffExpiration("target", spells.bloodPlague)
	local targetFrostFeverDuration = GMR.GetDebuffExpiration("target", spells.frostFever)

	local shouldCastPlagueStrike = false
	local shouldCastIcyTouch = false
	if self.state.hasGlyphOfDisease then
		if targetBloodPlagueDuration <= 0 then
			shouldCastPlagueStrike = true
		end
		if targetFrostFeverDuration <= 0 then
			shouldCastIcyTouch = true
		end
	else
		if targetBloodPlagueDuration <= 3 then
			shouldCastPlagueStrike = true
		end
		if targetFrostFeverDuration <= 3 then
			shouldCastIcyTouch = true
		end
	end

	if shouldCastIcyTouch and GMR.IsCastable(spells.icyTouch, "target")
		and GMR.IsSpellInRange(spells.icyTouch, "target")
	then
		self.dbgPrint("renew frost fever debuff with icy touch")
		GMR.Cast(spells.icyTouch, "target")
		return
	end

	if shouldCastPlagueStrike and GMR.IsCastable(spells.plagueStrike, "target")
		and GMR.IsSpellInRange(spells.plagueStrike, "target")
	then
		self.dbgPrint("renew blood plague debuff with plague strike")
		GMR.Cast(spells.plagueStrike, "target")
		return
	end

	local enemiesToTransferDebuff = 0
	local enemiesWithDebuff = 0
	local enemiesAround = 0
	for i = 1, #GMR.Tables.Attackables do
		local attackable = GMR.Tables.Attackables[i][1]
		-- gather debuff info for pestilence
		if GMR.ObjectExists(attackable) and GMR.GetDistance("player", attackable, "<", self.state.pestilenceRadius) then
			local attackableBloodPlagueDuration = GMR.GetDebuffExpiration(attackable, spells.bloodPlague)
			local attackableFrostFeverDuration = GMR.GetDebuffExpiration(attackable, spells.frostFever)
			if attackableBloodPlagueDuration < 3 or attackableFrostFeverDuration < 3 then
				enemiesToTransferDebuff = enemiesToTransferDebuff + 1
			else
				enemiesWithDebuff = enemiesWithDebuff + 1
			end
		end

		-- blood boil information gathering
		if GMR.ObjectExists(attackable) and GMR.GetDistance("player", attackable, "<", 10) then
			enemiesAround = enemiesAround + 1
		end
	end

	--self.dbgPrint("should do stage 3")

	local needToCastPestilenceSpell = false
	if targetBloodPlagueDuration > 3 and targetFrostFeverDuration > 3 and enemiesToTransferDebuff > 0 then
		needToCastPestilenceSpell = true
	elseif self.state.hasGlyphOfDisease and (targetBloodPlagueDuration > 0 and targetBloodPlagueDuration < 5)
		and (targetFrostFeverDuration > 0 and targetFrostFeverDuration < 5)
	then
		needToCastPestilenceSpell = true
	end

	if needToCastPestilenceSpell and spellKnown.pestilence then
		if GMR.IsCastable(spells.pestilence, "target") then
			self.dbgPrint("should use Pestilence")
			GMR.Cast(spells.pestilence, "target")
			return
		else
			self.dbgPrint("wait for possibility of pesilence usage")
		end
	end

	-- we need hp in first place, after that we will use some damage spells
	if GMR.GetHealth("player") < self.cfg.minHPToUseDeathStrikeMoreOften and GMR.IsCastable(spells.deathStrike, "target")
		and GMR.IsSpellInRange(spells.deathStrike, "target")
	then
		self.dbgPrint("should use death strike to heal yourself")
		GMR.Cast(spells.deathStrike, "target")
		return
	end

	if enemiesAround >= self.cfg.minEnemiesCountToRaiseDead then
		if GMR.IsCastable(spells.raiseDead, "player") and not self.state.raiseDeadConsumeItem then
			self.dbgPrint("should use raise dead")
			GMR.Cast(spells.raiseDead)
			return
		end
	end

	if not (needToCastPestilenceSpell and spellKnown.pestilence) then
		local shouldUseBloodFillers = true
		if self.cfg.useBloodFillersWithBloodRunesOnly and calculateRunes()[RUNETYPE_BLOOD] == 0 then
			shouldUseBloodFillers = false
		end
		if shouldUseBloodFillers then
			local shouldUseBloodBoil = self.cfg.bloodBoilEnabled and enemiesAround >= self.cfg.bloodBoilMinEnemies
			if shouldUseBloodBoil and GMR.IsCastable(spells.bloodBoil, "player") then
				self.dbgPrint("should use blood boil")
				GMR.Cast(spells.bloodBoil, "player")
				return
			end
			if spellKnown.heartStrike then
				if GMR.IsCastable(spells.heartStrike, "target") and GMR.IsSpellInRange(spells.heartStrike, "target") then
					self.dbgPrint("should use heart strike")
					GMR.Cast(spells.heartStrike, "target")
					return
				end
			else
				if GMR.IsCastable(spells.bloodStrike, "target") and GMR.IsSpellInRange(spells.bloodStrike, "target") then
					self.dbgPrint("should use blood strike")
					GMR.Cast(spells.bloodStrike, "target")
					return
				end
			end
		end
	end

	-- filler to spent unholy and frost runes
	if spellKnown.deathStrike then
		if GMR.IsCastable(spells.deathStrike, "target") and GMR.IsSpellInRange(spells.deathStrike, "target") then
			self.dbgPrint("should use death strike as a filler")
			GMR.Cast(spells.deathStrike, "target")
			return
		end
	else
		if GMR.IsCastable(spells.plagueStrike, "target") and GMR.IsSpellInRange(spells.plagueStrike, "target") then
			self.dbgPrint("should use plague strike as a filler")
			GMR.Cast(spells.plagueStrike, "target")
			return
		end

		if GMR.IsCastable(spells.icyTouch, "target") and GMR.IsSpellInRange(spells.icyTouch, "target") then
			self.dbgPrint("should use icy touch as a filler")
			GMR.Cast(spells.icyTouch, "target")
			return
		end
	end

	if not GMR.HasBuff("player", spells.hornOfWinter) and GMR.IsCastable(spells.hornOfWinter, "player")
		and GetSpellCooldown(spells.hornOfWinter) == 0
	then
		self.dbgPrint("should use horn of winter")
		GMR.Cast(spells.hornOfWinter, "player")
		return
	end

	--self.dbgPrint("do nothing")
end

do
	local isSuccess, err = pcall(function()
        if AMST_SHARE["CR/DK/B.LOADED"] == true then
            Error("There are two versions of the rotation uploaded. It may happen if you downloaded 02_amstaffix_deathknight_blood_rotation.lua file.")
            Error("Please delete it, or change `Config.onlineLoad` to `false` if you want to use offline version of rotation.")
            return
        end
        AMST_SHARE["CR/DK/B.LOADED"] = true

		-- turn on only for death knight class
		if GMR.GetClass("player") == "DEATHKNIGHT" then
			Print("Rotation would be initialized")

			local cfg = Config:new()
			cfg:apply(AMST_SHARE["CR/DK/B.CFG"])

			local state = State:new()
			state:determine(cfg)

			C_Timer.NewTicker(60, function()
				local time = GetTime()
				for k, expire in pairs(state.explodedCorpses) do
					if expire > time then
						state.explodedCorpses[k] = nil
					end
				end
			end)

			local rotation = Rotation:new(cfg, state)
			local rotationFunc = function()
				local isSuccess, err = pcall(rotation.execute, rotation)
                if not isSuccess then
                    Error("Can't launch rotation: " .. err)
                end
			end

			if cfg.useCombatRotationLauncher then
				local resultFunction = nil
				if GMR.CustomCombatConditions == nil then
					resultFunction = rotationFunc
				else
					Print("There is another combat conditions, it will be merged with this rotation")
					local oldCombatConditions = GMR.CustomCombatConditions
					resultFunction = function()
						local isSuccess, err = pcall(oldCombatConditions)
						if not isSuccess then
							Error("can't launch previous custom combat rotation: " .. err)
						end
						rotationFunc()
					end
				end

				GMR.CustomCombatConditions = resultFunction
				C_Timer.NewTicker(1, function()
					if GMR.CustomCombatConditions ~= resultFunction then
						GMR.CustomCombatConditions = resultFunction
						Error("Something changed GMR.CustomCombatConditions func, it was changed back!")
					end
				end)
			else
				C_Timer.NewTicker(0.1, function()
					if (not GMR.IsExecuting() or not GMR.IsAlive()) then
						return
					end

					rotationFunc()
				end)
			end

			Print("Rotation fully initialed and turned on.")
		end
	end)

    if not isSuccess then
        Error(err)
    end
end
