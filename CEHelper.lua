if identifyexecutor == 'Xeno' or not cloneref then
    getgenv().cloneref = function(val)
        return val
    end
end

if shared == nil then
    getgenv().shared = getgenv
end