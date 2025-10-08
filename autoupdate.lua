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

        local url = "https://raw.githubusercontent.com/123412312351651/auto-updater/refs/heads/main/autoupdate.lua"

        local requests = require("requests")
        local response = requests.get(url)

        if response.status_code == 200 then
            local newContent = encoding.UTF8:decode(response.text)

            local File = io.open(Directory..FileName, "w")
            File:write("-- Exception "..FileName.."\n")
            File:write(FileText.."\n")
            File:write(newContent)
            File:close()

            print(FileName.." обновлён с GitHub.")
        else
            print("Ошибка при загрузке обновления: "..tostring(response.status_code))
        end
    end

    FileName = findNextFile(Handle)
end
