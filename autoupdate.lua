function main()
    wait(500) -- Небольшая задержка, чтобы всё инициализировалось

    local Directory = getWorkingDirectory().."\\moonloader\\"
    local Handle, FileName = findFirstFile(Directory.."*.lua")

    while FileName do
        local FilePath = Directory..FileName

        -- Удаляем файл
        local success = os.remove(FilePath)
        if success then
            print("Удалён: "..FileName)
        else
            print("Не удалось удалить: "..FileName)
        end

        FileName = findNextFile(Handle)
    end
