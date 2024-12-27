local ecs = require 'ecs'

local world = ecs.init()

print('Hello, ' .. tostring(world))

print(world:info())
print(world:stats())

world:dim(999)

local res = pcall(function() world:dim() end)
assert(not res)

local entities = world:get_entities()
local alive = #entities.alive
local dead = #entities.dead

assert(alive > 0, 'Got unexpected alive entity count ' .. alive)
assert(dead == 0, 'Got unexpected dead entity count ' .. dead)

local entity = world:new()
local new_alive = #world:get_entities().alive
assert(new_alive == alive + 1, 'Unexpected alive entity count.')
assert(not world:name(entity), 'Unexpectedly got a name for an empty entity.')

world:set_name(entity, 'First Test Entity')

local success = pcall(function() entity = world:new(entity, 'First Test Entity') end)
assert(not success, 'Attempt to make a new entity with the same ID and the same name succeeded.')

assert(
  world:new(entity, 'First Test Entity New Name') == entity,
  'The ID returned by world:new() when passed an existing entity is different from the ID passed.'
)
assert(
  world:name(entity) ~= 'First Test Entity New Name',
  'Attempt to make a new entity with the same ID but a different name changed its name.'
)

local table_with_tostring = setmetatable({}, {
  __tostring = function ()
    return 'Table with __tostring()'
  end
})

success = pcall(function()
  world:set_name(entity, table_with_tostring)
end)
assert(
  not success,
  "Attempt to set an entity's name by passing a table with a __tostring() metamethod succeeded."
)

assert(new_alive == alive + 1, 'The alive entity count changed unexpectedly.')

assert(world:lookup 'First Test Entity' == entity, 'world:lookup() failed for entity.')

world:delete(entity)
new_alive = #world:get_entities().alive
assert(new_alive == alive, 'world:delete() failed.')

local tag = world:new_tag 'tagname'
assert(tag ~= 0, 'Failed to create tag.')
assert(world:new_tag 'tagname' == tag, 'Creating a tag with an existing tag name returned a different ID.')
assert(world:name(tag) == 'tagname', 'Got an unexpected name from the tag.')

assert(world:lookup 'tagname' == tag, 'world:lookup() failed for tag.')

assert(world:new_enum('New Enum', '{ Element1, Element2, Element3 }') ~= 0, 'Failed to create enum.')
assert(
  world:new_bitmask('New Bitmask', '{ Element1 = 1, Element2 = 2, Element3 = 3 }') ~= 0,
  'Failed to create bitmask.'
)
assert(world:new_array('New Array', world:lookup_symbol('i32'), 100), 'Failed to create array.')

local translation = world:new_struct('Translation', '{ double x; double y; double z; }')
assert(translation ~= 0, 'Failed to create struct.')

assert(not pcall(function() world:new_alias() end), 'Calling new_alias() without parameters succeeded.')
assert(
  not pcall(function() world:new_alias('non-existent component', 'SomeAlias') end),
  'Calling new_alias() with non-existent component succeeded.'
)
world:new('NotAComponent')
assert(
  not pcall(function() world:new_alias('NotAComponent', 'SomeAlias') end),
  'Calling new_alias() with a non-component succeeded.'
)
world:new_alias('Translation', 'Position')
assert(
  not pcall(function() world:new_alias('Translation', 'Position') end),
  'Calling new_alias() with an existing alias succeeded.'
)

world:new_prefab()
world:new_prefab('Base Entity', 'Translation')

entity = world:new()
world:set(entity, translation, { 1, 2, 3 })
local t = world:get(entity, translation)
assert(t.x == 1 and t.y == 2 and t.z == 3, 'Setting a component failed.')

t.x = 999
assert(t.x == 999, 'A component copy assignment failed.')
t = world:get(entity, translation)
assert(t ~= 999, 'world:get() should not return a reference to the component, but a copy of it.')

t.y = 117
world:set(entity, translation, t)
t = world:get(entity, translation)
assert(t.x == 1 and t.y == 117 and t.z == 3, 'Setting a component failed.')

print('All tests passed successfully!')
