AMST_SHARE = AMST_SHARE or {}
AMST_SHARE["CR>P/R.LOADED"] = true
local VERSION = "v1.1.0"
local printMsgPrefix = "[CR>P/R|" .. VERSION .. "] "

---Print message with CR prefix
---@param msg string
local function Print(msg)
	GMR.Print(printMsgPrefix .. msg)
end

local function Error(msg)
	Print(printMsgPrefix .. "[ERROR]  " .. msg)
end

local spells = {
	exorcism = GetSpellInfo(5614),
	flashOfLight = GetSpellInfo(19939),
	hammerOfWrath = GetSpellInfo(24275),
	handOfReckoning = GetSpellInfo(62124),
	purify = GetSpellInfo(1152),
	cleanse = GetSpellInfo(4987),
	crusaderStrike = GetSpellInfo(35395),
	consecrations = GetSpellInfo(20116),
	divineStorm = GetSpellInfo(53385)
}

local buffs = {
	theArtOfWar = GetSpellInfo(59578),
}

local debuffs = {

}

local spellKnown = {
	exorcism = GMR.IsSpellKnown(spells.exorcism),
	flashOfLight = GMR.IsSpellKnown(spells.flashOfLight),
	hammerOfWrath = GMR.IsSpellKnown(spells.hammerOfWrath),
	handOfReckoning = GMR.IsSpellKnown(spells.handOfReckoning),
	purify = GMR.IsSpellKnown(spells.purify),
	cleanse = GMR.IsSpellKnown(spells.cleanse),
	crusaderStrike = GMR.IsSpellKnown(spells.crusaderStrike),
	consecrations = GMR.IsSpellKnown(spells.consecrations),
	divineStorm = GMR.IsSpellKnown(spells.divineStorm),
}

local glyphSpells = {
}

---@class PaladinConfig
local Config = {
	---Toggle debug mode. Turn on, if you encounter some issues and want to deal with it, or record a video and send
	---to author.
	debug = false,
	---Use standard CombatRotation pluggable function. Change only if you know what you are doing.
	useCombatRotationLauncher = true,
	---Use online loading feature to get last updates
	onlineLoad = true,
	consumeArtOfWarFlashLightMinHp = 80,
	consumeArtOfWarFlashLightIfAuraDepletedSoon = true,
	useConsecrationsMinEnemies = 2,
	useDivineStormMinEnemies = 2,
}
function Config:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	return o
end

---Apply object to change default values
---@param object PaladinConfig another config
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

---@class PaladinState
local State = {
}
function State:new()
	local o = { }
	setmetatable(o, self)
	self.__index = self
	return o
end

---Determine state
---@param cfg PaladinConfig config
---@return void
function State:determine(cfg)

end

---@param cfg PaladinConfig
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

---@class PaladinRotation
local Rotation = {
	---@type PaladinConfig
	cfg = nil,
	---@type PaladinState
	state = nil,
	---@type fun(msg:string):void
	dbgPrint = function(msg)
	end
}
---@param cfg PaladinConfig
---@param state PaladinState
---@return PaladinRotation
function Rotation:new(cfg, state)
	local dbgPrint = createDbgPrintFunc(cfg)

	---@type PaladinRotation
	local o = {
		cfg = cfg,
		state = state,
		dbgPrint = dbgPrint,
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

---@return void
function Rotation:execute()
	if spellKnown.handOfReckoning and not GMR.UnitIsUnit("targettarget", "player")
		and GMR.IsCastable(spells.handOfReckoning, "target")
	then
		self.dbgPrint("should cast hand of reckoning to make some damage")
		GMR.Cast(spells.handOfReckoning, "target")
		return
	end

	for i = 1, #GMR.Tables.Attackables do
		local attackable = GMR.Tables.Attackables[i][1]
		if GMR.ObjectExists(attackable) and GMR.GetHealth(attackable) > 0 and GMR.GetHealth(attackable) < 20
			and GMR.IsCastable(spells.hammerOfWrath, attackable)
		then
			self.dbgPrint("should cast hammer of wrath")
			GMR.Cast(spells.hammerOfWrath, "target")
			return
		end
	end

	for index = 1, 40 do
		local localeName, _, _, debuffType, duration, expireAtTime, _, _, _, spellId = GMR.UnitDebuff("player", index)
		if localeName and expireAtTime - GetTime() < duration - math.random(5,10)/10 then
			if debuffType == "Disease" or debuffType == "Magic" or debuffType == "Poison" and
				spellKnown.cleanse and GMR.IsCastable(spells.cleanse, "player")
			then
				self.dbgPrint("should cast cleanse to remove debuff '" .. localeName .. "':" .. tostring(spellId) .. ".")
				GMR.Cast(spells.cleanse, "player")
				return
			elseif debuffType == "Disease" or debuffType == "Poison" and
				spellKnown.purify and GMR.IsCastable(spells.purify, "player")
			then
				self.dbgPrint("should cast purify to remove debuff '" .. localeName .. "':" .. tostring(spellId) .. ".")
				GMR.Cast(spells.purify, "player")
				return
			end
		end
	end

	if GMR.HasBuff("player", buffs.theArtOfWar) then
		if spellKnown.flashOfLight and GMR.GetHealth("player") < self.cfg.consumeArtOfWarFlashLightMinHp
			and GMR.IsCastable(spells.flashOfLight, "player")
		then
			self.dbgPrint("should cast flash of light on self to consume the art of war aura")
			GMR.Cast(spells.flashOfLight, "player")
			return
		elseif spellKnown.exorcism and GMR.IsCastable(spells.exorcism, "target") then
			self.dbgPrint("should cast exorcism on target to consume the art of war aura")
			GMR.Cast(spells.exorcism, "target")
			return
		elseif self.cfg.consumeArtOfWarFlashLightIfAuraDepletedSoon and spellKnown.flashOfLight
			and GMR.GetBuffExpiration("player", buffs.theArtOfWar) < 2
			and GMR.GetHealth("player") < 100 and GMR.IsCastable(spells.flashOfLight, "player")
		then
			self.dbgPrint("should cast flash of light on self to consume the art of war aura. Aura will deplete soon.")
			GMR.Cast(spells.flashOfLight, "player")
			return
		end
	end

	if spellKnown.consecrations and GMR.GetNumEnemies("player", 10) >= self.cfg.useConsecrationsMinEnemies
		and GMR.IsCastable(spells.consecrations, "player")
	then
		self.dbgPrint("should use consecrations")
		GMR.Cast(spells.consecrations, "player")
		return
	end

	if spellKnown.divineStorm and GMR.GetNumEnemies("player", 8) >= self.cfg.useDivineStormMinEnemies
		and GMR.IsCastable(spells.divineStorm, "player")
	then
		self.dbgPrint("should use divine storm")
		GMR.Cast(spells.divineStorm, "player")
		return
	end

	if spellKnown.crusaderStrike and GMR.IsCastable(spells.crusaderStrike, "target") then
		self.dbgPrint("should cast crusader strike")
		GMR.Cast(spells.crusaderStrike, "target")
		return
	end
end

do
	local isSuccess, err = pcall(function()
		if GMR.GetClass("player") == "PALADIN" then
			Print("Rotation would be initialized")

			local cfg = Config:new()
			cfg:apply(AMST_SHARE["CR>P/R.CFG"])

			local state = State:new()
			state:determine(cfg)

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
							Error("Can't launch previous custom combat rotation: " .. err)
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