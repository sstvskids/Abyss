if shared.AbyssLoaded == true then return end

local cloneref = (not identifyexecutor() == 'Xeno' and cloneref) or function(val) return val end
local httpService = cloneref(game:GetService('HttpService'))

for _, v in {'abyss.lol', 'abyss.lol/libraries', 'abyss.lol/games', 'abyss.lol/configs'} do
    if not isfolder(v) then
        makefolder(v)
    end
end

local function getURL(path: string, urltype: string, read: boolean)
    read = read or false
    local url = game:HttpGet('https://raw.githubusercontent.com/'..urltype..'/'..httpService:JSONDecode(game:HttpGet('https://api.github.com/repos/'..urltype..'/commits'))[1].sha..'/'..path, true)
    local pathh = string.find('bridge.lua') and 'games/bridge.lua' or path
    if not (isfile('abyss.lol/'..pathh) and shared.AbyssDeveloper) then
        writefile('abyss.lol/'..pathh, url)
    end
    
    return read == true and readfile('abyss.lol/games/'..pathh)
end

getURL('installer.lua', 'sstvskids/Abyss')
loadstring(getURL('bridge.lua', 'sstvskids/Abyss', true))