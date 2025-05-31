local BlekLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/sstvskids/Abyss/main/ui/source.lua"))()

local win = BlekLib:Create({
    Name = "Blek Library",
    StartupSound = {
        Toggle = true,
        SoundID = "rbxassetid://6958727243", -- Win 11 Startup Sound
        TimePosition = 1
    }
})

local maintab = win:Tab('Main')
local charactertab = win:Tab('Character')
local uitab = win:Tab('UI')

maintab:Toggle('Aimbot', function(a)
    print(a)
end)

maintab:Toggle('Use FOV', function(a)
    print(a)
end)

maintab:Slider('FOV', 30, 10, 300, function(a)
    print(a)
end)

maintab:Textbox('Custom FOV', function(a)
    print(a)
end)

charactertab:Button('Reset Character', function()
    game.Players.LocalPlayer.Character:BreakJoints()
end)

uitab:Button('Destroy GUI', function()
    win:Exit()
end)