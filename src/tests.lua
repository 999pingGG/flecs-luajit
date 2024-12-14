local ecs = require 'ecs'

local world = ecs.init()

print('Hello, world:', world)

print(world:info())
print(world:stats())

world:dim(999)

local res = pcall(function() world:dim() end)
assert(not res)

local entities = world:get_entities()

print(#entities.alive, 'alive')
print(#entities.dead, 'dead')
