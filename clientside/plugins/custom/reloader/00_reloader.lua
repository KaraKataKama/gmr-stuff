SLASH_AMSTREPLUG1 = "/amstreplug"
local function print(msg)
    return GMR.Print("[Reloader] " .. msg)
end

SlashCmdList["AMSTREPLUG"] = function()
    _G["AMSTREPLUG_IN_PROGRESS"] = true
    print("Start reloading plugins")
    local directoryPath = GMR.Variables.Directory .. "Plugins"
    for _, fileName in ipairs(GMR.GetDirectoryFiles(directoryPath)) do
        print("- reloading '" .. fileName .. "';")
        GMR.RunString(GMR.ReadFile(directoryPath .. "/" .. fileName))
    end
    print("Plugins reloaded")
    _G["AMSTREPLUG_IN_PROGRESS"] = false
end