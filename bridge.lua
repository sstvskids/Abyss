if shared.AbyssLoaded == true then return end

local cloneref = (not identifyexecutor() == 'Xeno' and cloneref) or function(val) return val end
local httpService = cloneref(game:GetService('HttpService'))
local function getURL(urltype: string, path: string)
    if urltype == 'MacLib' then
        return game:HttpGet('https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt')
    elseif urltype == 'Abyss' and path ~= nil then
        return not shared.AbyssDev and game:HttpGet('https://github.com/sstvskids/'..httpService:JSONDecode(game:HttpGet('https://api.github.com/repos/sstvskids/Abyss/commits'))[1].sha..'/'..path, true) or readfile('Abyss/'..path)
    end
end

local MacLib = loadstring(getURL('MacLib'))()