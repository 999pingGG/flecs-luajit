local ecs = require 'ecs'

local world = ecs.init()

print('Hello, world:', world)

print(world:info())
print(world:stats())

world:dim(999)

local res, err = pcall(function() world:dim() end)
assert(not res)
