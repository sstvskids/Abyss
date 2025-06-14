if shared.AbyssLoaded == true then return end

local cloneref = (not identifyexecutor() == 'Xeno' and cloneref) or function(val) return val end
local httpService = cloneref(game:GetService('HttpService'))
local function getURL(urltype: string, path: string)
    task.spawn(function()
        pcall(function()
            if urltype == 'Sirius' then
                return game:HttpGet('https://github.com/SiriusSoftwareLTD/Rayfield/'..httpService:JSONDecode(game:HttpGet('https://api.github.com/repos/SiriusSoftwareLTD/Rayfield/commits'))[1].sha..'/'..path, true)
            elseif urltype == 'entitylib' and path ~= nil then
                return game:HttpGet('https://github.com/7GrandDadPGN/VapeV4ForRoblox/'..httpService:JSONDecode(game:HttpGet('https://api.github.com/repos/7GrandDadPGN/VapeV4ForRoblox/commits'))[1].sha..'/'..path, true)
            elseif urltype == 'Abyss' and path ~= nil then
                return not shared.AbyssDev and game:HttpGet('https://github.com/sstvskids/Abyss/'..httpService:JSONDecode(game:HttpGet('https://api.github.com/repos/sstvskids/Abyss/commits'))[1].sha..'/'..path, true) or readfile('abyss.lol/'..path)
            end
        end)
    end)
end

for _, v in {'abyss.lol', 'abyss.lol/configs'} do
    if not isfolder(v) then
        makefolder(v)
    end
end

local Rayfield = loadstring(getURL('Sirius'))()
local entity = loadstring(getURL('entitylib', 'libraries/entity.lua'))()

-- init.lua
local Abyss = Rayfield:CreateWindow({
    Title = 'abyss.lol',
    Subtitle
})