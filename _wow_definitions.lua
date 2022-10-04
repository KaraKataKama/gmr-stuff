---Executes a string of Lua code
---@param scriptAsText string
---@return void
function RunScript(scriptAsText) end
---@return number current time
function GetTime() end
---@param unit string
---@return number
function UnitHealth(unit) end
---@param id number
---@return number
function GetRuneType(id) end
---@param spell number
---@return number
function GetSpellCount(spell)  end
---@param tabIndex number
---@param talentIndex number
---@param isInspect boolean|nil
---@return string, number, number, number, number, number, number, number name, iconTexture, tier, column, rank, maxRank, isExceptional, available
function GetTalentInfo(tabIndex, talentIndex, isInspect)  end