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
    if not isfile('abyss.lol/'..path) and not shared.AbyssDeveloper then
        writefile('abyss.lol/'..path, url)
    elseif isfile('abyss.lol/'..path) and not shared.AbyssDeveloper then
        delfile('abyss.lol/'..path, url)
        writefile('abyss.lol/'..path, url)
    end
    
    return not shared.AbyssDeveloper and read == true and url or read == true and readfile('abyss.lol/'..path)
end

getURL('installer.lua', 'sstvskids/Abyss')
return loadstring(getURL('games/bridge.lua', 'sstvskids/Abyss', true))()