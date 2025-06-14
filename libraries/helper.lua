local cloneref = (not identifyexecutor() == 'Xeno' and cloneref) or function(val) return val end
local players = cloneref(game:GetService('Players'))
local lplr = players.LocalPlayer

local bdhelper = {}
bdhelper.isAlive = function(plr)
    plr = plr or lplr
    return plr.Character and character:FindFirstChild('Head') and character:FindFirstChild('Humanoid') and character.Humanoid.Health > 0
end

bdhelper.getClosest() = function()
    return nil
end

return entity