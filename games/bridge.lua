if shared.AbyssLoaded == true then return end
local run = function(func) func() end

local cloneref = (not identifyexecutor() == 'Xeno' and cloneref) or function(val) return val end
local playersService = cloneref(game:GetService('Players'))
local httpService = cloneref(game:GetService('HttpService'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local collectionService = cloneref(game:GetService('CollectionService'))
local lplr = playersService.LocalPlayer

local function getURL(path: string, urltype: string)
    local url = game:HttpGet('https://raw.githubusercontent.com/'..urltype..'/'..httpService:JSONDecode(game:HttpGet('https://api.github.com/repos/'..urltype..'/commits'))[1].sha..'/'..path, true)
    local pathh = string.find(path, 'source.lua') and path or 'entity.lua'
    if not (isfile('abyss.lol/libraries/'..pathh) and shared.AbyssDeveloper) then
        writefile('abyss.lol/libraries/'..pathh, url)
    end
    
    return not shared.AbyssDeveloper and url or readfile('abyss.lol/libraries/'..pathh)
end

local Rayfield = loadstring(getURL('source.lua', 'SiriusSoftwareLtd/Rayfield'))()
local entitylib = loadstring(getURL('libraries/entity.lua', '7GrandDadPGN/VapeV4ForRoblox'))()
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
        local remote
        for _, v in pairs(game:GetDescendants()) do
            if (v:IsA('RemoteEvent') or v:IsA('RemoteFunction')) and v.Name == name then
                remote = v
                break
            end
        end
        if name == nil then return Instance.new('RemoteEvent') end
        return remote
    end
    bd.Remotes = {
        AttackPlayer = bd.GetRemote('AttackPlayerWithSword'),
		BlockSword = bd.GetRemote('ToggleBlockSword'),
		EnterQueue = bd.GetRemote('EnterQueue'),
        PlaceBlock = bd.GetRemote('PlaceBlock')
    }
end)

run(function()
	local oldstart = entitylib.start
	local function teamcheck(ent)
		local suc, res = pcall(function()
			if ent.Team or ent.Character.Humanoid.Team then
				return lplr.Team ~= (ent.Team or ent.Character.Humanoid.Team)
			end
		end)
		return (suc and res) or true
	end
	local function customEntity(ent)
		if not ent:HasTag('NPC') then return end
		if ent:IsDescendantOf(workspace) then
			if ent.Name:find("%[BOT%]") then
				ent.Name = ent.Name:gsub('<font.->', ''):gsub('</font>', ''):gsub('%[BOT%]%s*', '')
			end
			entitylib.addEntity(ent, nil, ent:HasTag('NPC') and function(self)
				return teamcheck(self)
			end)
		end
	end

	entitylib.start = function()
		oldstart()
		if entitylib.Running then
			for _, ent in collectionService:GetTagged('NPC') do
				customEntity(ent)
			end
			table.insert(entitylib.Connections, collectionService:GetInstanceAddedSignal('NPC'):Connect(customEntity))
			table.insert(entitylib.Connections, collectionService:GetInstanceRemovedSignal('NPC'):Connect(function(ent)
				entitylib.removeEntity(ent)
			end))
		end
	end
end)

entitylib.start()

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
                    Content = "Velocity will be disabled after match or rejoin",
                    Duration = 6.5,
                    Image = "shield-alert",
                })
            end
        end,
        Flag = 'Velocity'
    })
end)

-- blatant
tabs.Blatant:CreateSection('Blatant')

--[[run(function()
    local Aura
    local Range
end)]]

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