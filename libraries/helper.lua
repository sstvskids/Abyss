local cloneref = (not identifyexecutor() == 'Xeno' and cloneref) or function(val) return val end
local players = cloneref(game:GetService('Players'))
local lplr = players.LocalPlayer

local entity = {
    isAlive = false,
    character = lplr.Character,
    list = {}
}

entitylib.getplayers = function()
    for _,v in players:getplayers() do
        if v ~= lplr then
            table.insert(entity.list, v)
        end
    end
end

repeat task.wait()
    if entity.isAlive == false and entity.character.Humanoid then
        entity.isAlive = true
    end
until shared.AbyssLoaded == false

return entity