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
assert(success, 'Attempt to make a new entity with the same ID and same name failed.')

local success = pcall(function() world:new(entity, 'First Test Entity New Name') end)
assert(not success, 'Calling world:new() with an existing entity ID but different name succeeded.')

local table_with_tostring = setmetatable({}, {
  __tostring = function ()
    return 'Table with __tostring()'
  end
})

success = pcall(function() world:set_name(entity, table_with_tostring) end)
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
assert(tag, 'Failed to create tag.')
assert(world:new_tag 'tagname' == tag, 'Creating a tag with an existing tag name returned a different ID.')
assert(world:name(tag) == 'tagname', 'Got an unexpected name from the tag.')

assert(world:lookup 'tagname' == tag, 'world:lookup() failed for tag.')

assert(world:new_enum('New Enum', '{ Element1, Element2, Element3 }'), 'Failed to create enum.')
assert(
  world:new_bitmask('New Bitmask', '{ Element1 = 1, Element2 = 2, Element3 = 3 }'),
  'Failed to create bitmask.'
)
assert(world:new_array('New Array', world:lookup_symbol('i32'), 100), 'Failed to create array.')

local translation = world:new_struct('Translation', '{ double x; double y; double z; }')
assert(translation, 'Failed to create struct.')

assert(not pcall(function() world:new_alias() end), 'Calling new_alias() without parameters succeeded.')
success = pcall(function() world:new_alias('non-existent component', 'SomeAlias') end)
assert(not success, 'Calling new_alias() with non-existent component succeeded.')

world:new('NotAComponent')
success = pcall(function() world:new_alias('NotAComponent', 'SomeAlias') end)
assert(not success,'Calling new_alias() with a non-component succeeded.')

world:new_alias('Translation', 'Position')
success = pcall(function() world:new_alias('Translation', 'Position') end)
assert(not success, 'Calling new_alias() with an existing alias succeeded.')

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

local world2 = ecs.init()

assert(not world2:lookup 'New Enum', 'An enum from some world exists in another one.')
assert(not world2:lookup 'Translation', 'A struct from some world exists in another one.')

local translation2d = world2:new_struct('Translation', '{ float x; float y; }')
assert(translation2d, 'Failed to create struct with the same name in another world.')

local configuration = world2:new_struct('Configuration', '{ int fps_cap; float max_players; }')
world2:singleton_add(configuration)
assert(world2:has(configuration, configuration), "Singleton wasn't added to second world.")

success = pcall(function() world2:new_struct('Pointers', '{ char* CanIHazPointers; }') end)
assert(not success, 'Creating a struct with pointer succeeded.')

success = pcall(function() world2:new_struct('Arrays', '{ char CanIHazArrays[10]; }') end)
assert(not success, 'Creating a struct with array succeeded.')

-- TODO: Test creating a struct with no members. Currently, Flecs crashes in that case.

success = pcall(function()
  world:new_struct('With Spaces', '{ int i; }\t\t')
  world:new_struct('123startsWithNumber', '{char      \t     a; \t\t}')
  world2:new_struct('---', '{          bool is_true; }')
end)
assert(not success, 'Creating a struct with invalid name succeeded.')

local mixed = world2:new_struct('MixedTypes', '{float foo;i32 bar;}')
entity = world2:new('Mixed entity', 'MixedTypes')
world2:set(entity, mixed, { foo = 123.456, bar = 12.84 })

local value = world2:get(entity, mixed)
assert(
  math.abs(value.foo - 123.456) < 0.00001 and value.bar == 12,
  'Got back incorrect component values: ' .. value.foo .. ', ' .. value.bar
)

local monster_component = world:new_struct('MonsterComponent', [[{
  bool bool_field;
  char char_field;
  byte byte_field;
  u8 u8_field;
  uint8_t u8_field2;
  u16 u16_field;
  uint16_t u16_field2;
  u32 u32_field;
  uint32_t u32_field2;
  u64 u64_field;
  uint64_t u64_field2;
  i8 i8_field;
  int8_t i8_field2;
  i16 i16_field;
  int16_t i16_field2;
  i32 i32_field;
  int32_t i32_field2;
  int i32_field3;
  i64 i64_field;
  int64_t i64_field2;
  float float_field;
  double double_field;
}]])

world:singleton_add(monster_component)
world:singleton_get(monster_component)
world:singleton_remove(monster_component)
world:singleton_set(monster_component, {
  bool_field = true,
  char_field = 'a',
  byte_field = 1,
  u8_field = 2,
  u8_field2 = 3,
  u16_field = 4,
  u16_field2 = 5,
  u32_field = 6,
  u32_field2 = 7,
  u64_field = 8,
  u64_field2 = 9,
  i8_field = 10,
  i8_field2 = 11,
  i16_field = 12,
  i16_field2 = 13,
  i32_field = 14,
  i32_field2 = 15,
  i32_field3 = 16,
  i64_field = 17,
  i64_field2 = 18,
  float_field = 11.11,
  double_field = 22.22,
})

print('All tests passed successfully!')
