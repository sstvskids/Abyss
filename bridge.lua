if shared.AbyssLoaded == true then return end

local cloneref = (not identifyexecutor() == 'Xeno' and cloneref) or function(val) return val end
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local run = function(func) func() end

for _, v in {'abyss.lol', 'abyss.lol/libraries', 'abyss.lol/configs'} do
    if not isfolder(v) then
        makefolder(v)
    end
end

local function getURL(path: string, urltype: string)
    local url = game:HttpGet('https://raw.githubusercontent.com/'..urltype..'/'..httpService:JSONDecode(game:HttpGet('https://api.github.com/repos/'..urltype..'/commits'))[1].sha..'/'..path, true)
    local pathh = string.find(path, 'source.lua') and path or 'entity.lua'
    if not (isfile('abyss.lol/libraries/'..pathh) and shared.AbyssDeveloper) then
        writefile('abyss.lol/libraries/'..pathh, url)
    end
    
    return not shared.AbyssDeveloper and url or readfile('abyss.lol/libraries/'..pathh)
end

local Rayfield = loadstring(getURL('source.lua', 'SiriusSoftwareLtd/Rayfield'))()
local entity = loadstring(getURL('libraries/entity.lua', '7GrandDadPGN/VapeV4ForRoblox'))()
local bd = {}

-- init.lua
local Window = Rayfield:CreateWindow({
    Name = 'abyss.lol',
    Icon = 0,
    LoadingTitle = 'abyss.lol',
    LoadingSubtitle = 'by @stav',
    Theme = 'Default',
    ToggleUIKeybind = Enum.KeyCode.RightShift,
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = 'abyss.lol/configs',
        FileName = "abyss.json"
    },
    Discord = {
        Enabled = true,
        Invite = "98UQA75epW",
        RememberJoins = true
    },
    KeySystem = false
})

run(function()
    bd.GetRemote = function(name: RemoteEvent | RemoteFunction): RemoteEvent | RemoteFunction
        task.spawn(function()
            local remote
			for _, v in pairs(game:GetDescendants()) do
				if (v:IsA('RemoteEvent') or v:IsA('RemoteFunction')) and v.Name == name then
					remote = v
					break
				end
			end
            if name == nil then return Instance.new('RemoteEvent') end
            return remote
        end)
    end
    bd.Remotes = {
        AttackPlayer = bd.GetRemote('AttackPlayerWithSword'),
		BlockSword = bd.GetRemote('ToggleBlockSword'),
		EnterQueue = bd.GetRemote('EnterQueue'),
        PlaceBlock = bd.GetRemote('PlaceBlock')
    }
end)

local tabs = {
    Combat = Window:CreateTab('Combat', 'swords'),
    Blatant = Window:CreateTab('Blatant', 'skull'),
    Misc = Window:CreateTab('Misc', 'haze')
}

-- combat
tabs.Combat:CreateSection('Combat')

run(function()
    local Velocity
    Velocity = tabs.Combat:CreateToggle({
        Name = 'Velocity',
        CurrentValue = false,
        Callback = function(val)
            if val then
                pcall(function()
                    local old = replicatedStorage.Modules.Knit.Services.CombatService.RE.KnockBackApplied
                    old:Destroy()
                end)
            else
                Rayfield:Notify({
                    Title = "Abyss",
                    Content = "Velocity won't be disabled after match or rejoin",
                    Duration = 6.5,
                    Image = "shield-warning",
                })
            end
        end,
        Flag = 'Velocity'
    })
end)

-- misc
tabs.Misc:CreateSection('Misc')

run(function()
    local Uninject
    Uninject = tabs.Misc:CreateButton({
        Name = "Uninject",
        Callback = function()
            bd = nil
            entity = nil
            shared.AbyssLoaded = nil
            Rayfield:Destroy()
        end,
    })
end)

Rayfield:LoadConfiguration()
shared.AbyssLoaded = true