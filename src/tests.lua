local ecs = require 'ecs'

local world = ecs.init()

print('Hello, world:', world)

print(world:info())
print(world:stats())

world:dim(999)

local res = pcall(function() world:dim() end)
assert(not res)

local entities = world:get_entities()
local alive = #entities.alive
local dead = #entities.dead

print(alive, 'alive')
print(dead, 'dead')

local entity = world:new_entity()
local new_alive = #world:get_entities().alive
assert(new_alive == alive + 1)
assert(not world:get_name(entity))
print("Created a new, empty entity. Now there's " .. new_alive .. ' alive entities.')

world:set_name(entity, 'First Test Entity')
print('The new entity now has name: "' .. world:get_name(entity) .. '"')

local success, error = pcall(function() entity = world:new_entity(entity, 'First Test Entity') end)
assert(not success)
print('Tried to make a new entity with the same ID and the same name. Task failed successfully with message: ' .. error)

assert(world:new_entity(entity, 'First Test Entity New Name') == entity)
assert(world:get_name(entity) ~= 'First Test Entity New Name')
print('Attempted to make a new entity with the same ID but a different name. Nothing was effectively done successfully.')

local malicious_table = setmetatable({}, {
  __tostring = function ()
    return 'A malicious name!'
  end
})
print('A malicious table has a __tostring() method that returns: "' .. tostring(malicious_table) .. '"')

success, error = pcall(function()
  world:set_name(entity, malicious_table)
end)
assert(not success)
print("Attempt to set an entity's name by passing said table failed successfully with message: " .. error)

assert(new_alive == alive + 1)
