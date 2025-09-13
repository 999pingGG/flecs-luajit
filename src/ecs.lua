local bit = require 'bit'
local ffi = require 'ffi'
local buffer = require 'string.buffer'
local table = table

ffi.cdef[[
// Define some opaque types we can (hopefully) safely expose to the public.
// I say safely because fortunately, LuaJIT doesn't allow pointer arithmetic on those
// nor implicit casts between incompatible types.
typedef struct public_ecs_query_t public_ecs_query_t;
typedef struct public_ecs_iter_t  public_ecs_iter_t;

// Define some helper types.
typedef struct world_binding_context_t {
  // Maps component IDs to the names the FFI understands.
  ecs_map_t component_c_types;
  // Maps that works as sets. The keys are pointers to query_wrapper_t and iter_wrapper_t
  // that need to be finished upon world destruction. Values are unused.
  ecs_map_t alive_iterators, alive_queries;
} world_binding_context_t;

typedef struct query_wrapper_t {
  ecs_query_t* query;
} query_wrapper_t;

// Define some helper custom types we need internally.
typedef struct iter_wrapper_t {
  ecs_iter_t iter;
  int32_t i;
  bool invalid;
} iter_wrapper_t;
]]

local c = ffi.C

-- Flecs types

local ecs_world_info_t            = ffi.typeof 'ecs_world_info_t'
local ecs_world_stats_t           = ffi.typeof 'ecs_world_stats_t'
local ecs_metric_t                = ffi.typeof 'ecs_metric_t'
local EcsType                     = ffi.typeof 'EcsType'

-- Standard C types

local uint32_t                    = ffi.typeof 'uint32_t'
local uint64_t                    = ffi.typeof 'uint64_t'
local uint64_t_vla                = ffi.typeof 'uint64_t[?]'

-- Convenience types

local void_ptr                    = ffi.typeof 'void*'
local void_func                   = ffi.typeof 'void (*)(void)'
local char_ptr                    = ffi.typeof 'char*'
local char_ptr_ptr                = ffi.typeof 'char**'

local world_binding_context_t     = ffi.typeof 'world_binding_context_t'
local world_binding_context_t_ptr = ffi.typeof 'world_binding_context_t*'

local ecs_entity_desc_t           = ffi.typeof 'ecs_entity_desc_t'

local ecs_array_desc_t            = ffi.typeof 'ecs_array_desc_t'

local ecs_query_desc_t            = ffi.typeof 'ecs_query_desc_t'

local ecs_map_t                   = ffi.typeof 'ecs_map_t'
local ecs_map_t_ptr               = ffi.typeof 'ecs_map_t*'
local ecs_map_iter_t_vla          = ffi.typeof 'ecs_map_iter_t[?]'

local ecs_query_t_ptr             = ffi.typeof 'ecs_query_t*'
local public_ecs_query_t          = ffi.typeof 'public_ecs_query_t'
local public_ecs_query_t_ptr      = ffi.typeof 'public_ecs_query_t*'
local query_wrapper_t             = ffi.typeof 'query_wrapper_t'
local query_wrapper_t_ptr         = ffi.typeof 'query_wrapper_t*'

local ecs_iter_t_ptr              = ffi.typeof 'ecs_iter_t*'
-- local ecs_iter_t_vla             = ffi.typeof 'ecs_iter_t[?]'
local public_ecs_iter_t           = ffi.typeof 'public_ecs_iter_t'
local public_ecs_iter_t_ptr       = ffi.typeof 'public_ecs_iter_t*'
local iter_wrapper_t              = ffi.typeof 'iter_wrapper_t'
local iter_wrapper_t_ptr          = ffi.typeof 'iter_wrapper_t*'

local function is_entity(entity)
  return type(entity) == 'cdata' and ffi.typeof(entity) == uint64_t
end

local function ecs_entity_t_lo(value)
  return ffi.cast(uint32_t, value)
end

local function ecs_entity_t_hi(value)
  return ffi.rshift(ffi.cast(uint32_t, value), 32)
end

local function ecs_entity_t_comb(lo, hi)
  return bit.lshift(ffi.cast(uint64_t, hi), 32) + ffi.cast(uint32_t, lo)
end

local function ecs_pair(pred, obj)
  return bit.bor(c.ECS_PAIR, ecs_entity_t_comb(obj, pred))
end

local function ecs_add_pair(world, subject, first, second)
  c.ecs_add_id(world, subject, ecs_pair(first, second))
end

local function ecs_get_path(world, entity)
  return c.ecs_get_path_w_sep(world, 0, entity, '.', nil)
end

local function ecs_has_pair(world, entity, first, second)
  return c.ecs_has_id(world, entity, ecs_pair(first, second))
end

local function ecs_remove_pair(world, subject, first, second)
  c.ecs_remove_id(world, subject, ecs_pair(first, second))
end

local ECS_ID_FLAGS_MASK = bit.lshift(0xFFull, 60)
local ECS_ENTITY_MASK = 0xFFFFFFFFull
local ECS_GENERATION_MASK = bit.lshift(0xFFFFull, 32)

local function ECS_GENERATION(e)
  return bit.rshift(bit.band(e, ECS_GENERATION_MASK), 32)
end

local function ECS_GENERATION_INC(e)
  return bit.bor(bit.band(e, bit.bnot(ECS_GENERATION_MASK)), bit.lshift(bit.band(0xffff, ECS_GENERATION(e) + 1), 32))
end

local ECS_COMPONENT_MASK = bit.bnot(ECS_ID_FLAGS_MASK)

local function ECS_HAS_ID_FLAG(e, flag)
  return bit.band(e, flag) ~= 0
end

local function ECS_IS_PAIR(id)
  return bit.band(id, ECS_ID_FLAGS_MASK) == c.ECS_PAIR
end

local function ECS_PAIR_FIRST(e)
  return ecs_entity_t_hi(bit.band(e, ECS_COMPONENT_MASK))
end

local function ECS_PAIR_SECOND(e)
  return ecs_entity_t_lo(e)
end

local function ecs_pair_first(world, pair)
  return c.ecs_get_alive(world, ECS_PAIR_FIRST(pair))
end

local function ecs_pair_second(world, pair)
  return c.ecs_get_alive(world, ECS_PAIR_SECOND(pair))
end

local ecs_pair_relation = ecs_pair_first
local ecs_pair_target = ecs_pair_second

local function ECS_HAS_RELATION(e, rel)
  return ECS_HAS_ID_FLAG(e, c.ECS_PAIR) and ECS_PAIR_FIRST() ~= 0
end

local function init_scope(world, id)
  local scope = c.ecs_get_scope(world)
  if scope ~= 0 then
    ecs_add_pair(world, id, c.EcsChildOf, scope)
  end
end

local forbidden_struct_patterns = {
  { pattern = '%*',                    error_message = 'No pointers allowed.'       },
  { pattern = '[%[%]]',                error_message = 'No arrays allowed.'         },
  { pattern = '%f[%w_]uptr%f[^%w_]',   error_message = 'No pointers allowed.'       },
  { pattern = '%f[%w_]iptr%f[^%w_]',   error_message = 'No pointers allowed.'       },
  { pattern = '%f[%w_]string%f[^%w_]', error_message = 'No strings allowed (yet?).' },
}

local c_type_map = {
  byte = 'unsigned char',
  u8   = 'uint8_t',
  u16  = 'uint16_t',
  u32  = 'uint32_t',
  u64  = 'uint64_t',
  i8   = 'int8_t',
  i16  = 'int16_t',
  i32  = 'int32_t',
  i64  = 'int64_t',
  f32  = 'float',
  f64  = 'double',
}

local flecs_type_map = {
  uint8_t  = 'u8',
  uint16_t = 'u16',
  uint32_t = 'u32',
  uint64_t = 'u64',
  int8_t   = 'i8',
  int16_t  = 'i16',
  int32_t  = 'i32',
  int64_t  = 'i64',
  float    = 'f32',
  double   = 'f64',
  int      = 'i32',
}

local function check_c_identifier(identifier)
  if not identifier:match '^%a[%a_%d]*$' then
    error('Not a valid C identifier: "' .. identifier .. '"', 3)
  end
end

local function filter_unsafe_constructs(s)
  for i = 1, #forbidden_struct_patterns do
    local pattern = forbidden_struct_patterns[i]
    if s:match(pattern.pattern) then
      error(pattern.error_message, 4)
    end
  end
end

local function substitute_types(input, type_map)
  -- Replace types only when they are full words (surrounded by non-word boundaries).
  return input:gsub("(%f[%w_])(%a[%w_]*)(%f[^%w_])", function (prefix, word, suffix)
    local replacement = type_map[word] or word
    return prefix .. replacement .. suffix
  end)
end

local function generate_definitions(description)
  filter_unsafe_constructs(description)

  local flecs_definition = substitute_types(description, flecs_type_map)
  local c_definition = substitute_types(description, c_type_map)

  return flecs_definition, c_definition
end

local c_identifier_sequence = 0

local function finish_query_wrapper(wrapper)
  wrapper = ffi.cast(query_wrapper_t_ptr, wrapper)
  if wrapper.query ~= nil then
    c.ecs_query_fini(wrapper.query)
    local binding_context = ffi.cast(world_binding_context_t_ptr, c.ecs_get_binding_ctx(wrapper.query.world))
    c.ecs_map_remove(binding_context.alive_queries, ffi.cast(uint64_t, wrapper))
  end
  c.ecs_os_api.free_(wrapper)
end

local function invalidate_query_wrapper(wrapper)
  ffi.cast(query_wrapper_t_ptr, wrapper).query = nil
end

ffi.metatype('ecs_world_t', {
  __index = {
    is_fini = function (self)
      return c.ecs_is_fini(self)
    end,
    info = function (self)
      return c.ecs_get_world_info(self)
    end,
    stats = function (self)
      local stats = ecs_world_stats_t()
      c.ecs_world_stats_get(self, stats)
      return stats
    end,
    dim = function (self, entity_count)
      c.ecs_dim(self, entity_count)
    end,
    quit = function (self)
      c.ecs_quit(self)
    end,
    should_quit = function (self)
      return c.ecs_should_quit(self)
    end,
    get_entities = function (self)
      local entities = c.ecs_get_entities(self)
      local alive = {}
      local dead = {}

      for i = 0, entities.alive_count - 1 do
        table.insert(alive, entities.ids[i])
      end

      for i = entities.alive_count, entities.count - 1 do
        table.insert(dead, entities.ids[i])
      end

      return { alive = alive, dead = dead }
    end,
    get_flags = function (self)
      return c.ecs_world_get_flags(self)
    end,
    measure_frame_time = function (self, enable)
      c.ecs_measure_frame_time(self, enable)
    end,
    measure_system_time = function (self, enable)
      c.ecs_measure_system_time(self, enable)
    end,
    set_target_fps = function (self, fps)
      c.ecs_set_target_fps(self, fps)
    end,
    set_default_query_flags = function (self, flags)
      c.ecs_set_default_query_flags(self, flags)
    end,
    new = function (self, arg1, arg2, arg3)
      local entity
      local name
      local components

      if not arg1 and not arg2 then
        --  entity | name(string)
        entity = c.ecs_new(self)
      elseif arg2 and not arg3 then
        if is_entity(arg1) then
          -- entity, name (string)
          entity = arg1
          if type(arg2) == 'string' then
            name = arg2
          else
            error('Expected a name after the entity.', 2)
          end
        else
          -- name (string|nil), components
          name = arg1
          components = arg2
        end
      elseif arg1 and arg3 then
        -- entity, name (string|nil), components
        entity = arg1
        name = arg2
        components = arg3
      end

      if entity and name and c.ecs_is_alive(self, entity) then
        local existing = c.ecs_get_name(self, entity)
        if existing ~= nil then
          if ffi.string(existing) == name then
            return entity
          end

          error('Entity redefined with a different name.', 2)
        end
      end

      if (not entity or entity == 0) and name then
        entity = c.ecs_lookup(self, name)
        if entity and entity ~= 0 then
          return entity
        end
      end

      -- Create an entity, the following functions will take the same ID.
      if (not entity or entity == 0) and (arg1 or arg2) then
        entity = c.ecs_new(self)
      end

      if (entity and entity ~= 0) and not c.ecs_is_alive(self, entity) then
        c.ecs_make_alive(self, entity)
      end

      local scope = c.ecs_get_scope(self)
      if scope ~= 0 then
        ecs_add_pair(self, entity, c.EcsChildOf, scope)
      end

      if components then
        -- TODO: Check whether this creates under the current scope, if any.
        entity = c.ecs_entity_init(self, ecs_entity_desc_t({ id = entity, add_expr = components }))
      end

      if name then
        c.ecs_set_name(self, entity, name)
      end

      return entity ~= 0 and entity or nil
    end,
    delete = function (self, entity)
      if is_entity(entity) then
        c.ecs_delete(self, entity)
      else
        for i = 1, #entity do
          c.ecs_delete(self, entity[i])
        end
      end
    end,
    new_tag = function (self, name)
      local entity = c.ecs_lookup(self, name)
      if entity == 0 then
        entity = c.ecs_set_name(self, entity, name)
      end

      return entity ~= 0 and entity or nil
    end,
    name = function (self, entity, numeric_name)
      local name = c.ecs_get_name(self, entity)
      if name ~= nil then
        return ffi.string(name)
      elseif numeric_name and self:is_alive(entity) then
        return '#' .. tostring(entity)
      end
    end,
    set_name = function (self, entity, name)
      c.ecs_set_name(self, entity, name)
    end,
    symbol = function (self, entity)
      local symbol = c.ecs_get_symbol(self, entity)
      if symbol ~= nil then
        return ffi.string(symbol)
      end
    end,
    path = function (self, entity)
      local path = ecs_get_path(self, entity)
      local ret = ffi.string(path)
      c.ecs_os_api.free_(path)
      return ret
    end,
    lookup = function (self, path)
      local ret = c.ecs_lookup(self, path)
      return ret ~= 0 and ret or nil
    end,
    lookup_child = function (self, parent, name)
      local ret = c.ecs_lookup_child(self, parent, name)
      return ret ~= 0 and ret or nil
    end,
    lookup_path = function (self, parent, path, sep, prefix)
      local ret = c.ecs_lookup_path_w_sep(self, parent, path, sep, prefix, false)
      return ret ~= 0 and ret or nil
    end,
    lookup_symbol = function (self, symbol)
      local ret = c.ecs_lookup_symbol(self, symbol, true, false)
      return ret ~= 0 and ret or nil
    end,
    set_alias = function (self, entity, name)
      c.ecs_set_alias(self, entity, name)
    end,
    has = function (self, entity, arg1, arg2)
      if entity and arg1 and arg2 then
        return ecs_has_pair(self, entity, arg1, arg2)
      else
        return c.ecs_has_id(self, entity, arg1)
      end
    end,
    owns = function (self, entity, id)
      return c.ecs_owns_id(self, entity, id)
    end,
    is_alive = function (self, entity)
      return c.ecs_is_alive(self, entity)
    end,
    is_valid = function (self, entity)
      return c.ecs_is_valid(self, entity)
    end,
    alive = function (self, entity)
      local ret = c.ecs_get_alive(self, entity)
      return ret
    end,
    make_alive = function (self, entity)
      c.ecs_make_alive(self, entity)
    end,
    exists = function (self, entity)
      return c.ecs_exists(self, entity)
    end,
    add = function (self, entity, arg1, arg2)
      if entity and arg1 and arg2 then
        ecs_add_pair(self, entity, arg1, arg2)
      else
        c.ecs_add_id(self, entity, arg1)
      end
    end,
    remove = function (self, entity, arg1, arg2)
      if arg1 and arg2 then
        ecs_remove_pair(self, entity, arg1, arg2)
      else
        c.ecs_remove_id(self, entity, arg1)
      end
    end,
    clear = function (self, entity)
      c.ecs_clear(self, entity)
    end,
    enable = function (self, entity, component)
      if component then
        c.ecs_enable_id(self, entity, component, true)
      else
        c.ecs_enable(self, entity, true)
      end
    end,
    disable = function (self, entity, component)
      if component then
        c.ecs_enable_id(self, entity, component, false)
      else
        c.ecs_enable(self, entity, false)
      end
    end,
    count = function (self, entity)
      return c.ecs_count_id(self, entity)
    end,
    delete_children = function (self, parent)
      c.ecs_delete_with(self, ecs_pair(c.EcsChildOf, parent))
    end,
    parent = function (self, entity)
      local ret = c.ecs_get_target(self, entity, c.EcsChildOf, 0)
      return ret
    end,
    is_component_enabled = function (self, entity, component)
      return c.ecs_is_enabled_id(self, entity, component)
    end,
    pair = function (predicate, object)
      return ecs_pair(predicate, object)
    end,
    is_pair = function (id)
      return ECS_IS_PAIR(id)
    end,
    pair_target = function (self, pair)
      return ecs_pair_target(self, pair)
    end,
    add_is_a = function (self, entity, base)
      ecs_add_pair(self, entity, c.EcsIsA, base)
    end,
    remove_is_a = function (self, entity, base)
      ecs_remove_pair(self, entity, c.EcsIsA, base)
    end,
    add_child_of = function (self, entity, parent)
      ecs_add_pair(self, entity, c.EcsChildOf, parent)
    end,
    remove_child_of = function (self, entity, parent)
      ecs_remove_pair(self, entity, c.EcsChildOf, parent)
    end,
    auto_override = function (self, entity, component)
      c.ecs_add_id(self, entity, bit.bor(c.ECS_AUTO_OVERRIDE, component))
    end,
    new_enum = function (self, name, description)
      if c.ecs_lookup(self, name) ~= 0 then
        error('Component already exists.', 2)
      end

      local component = c.ecs_entity_init(self, ecs_entity_desc_t({ use_low_id = true }))
      if component == 0 then
        return
      end
      c.ecs_set_name(self, component, name)
      if c.ecs_meta_from_desc(self, component, c.EcsEnumType, description) ~= 0 then
        error('Invalid descriptor.', 2)
      end

      init_scope(self, component)
      return component
    end,
    new_bitmask = function (self, name, description)
      if c.ecs_lookup(self, name) ~= 0 then
        error('Component already exists.', 2)
      end

      local component = c.ecs_entity_init(self, ecs_entity_desc_t({ use_low_id = true }))
      if component == 0 then
        return
      end
      c.ecs_set_name(self, component, name)
      if c.ecs_meta_from_desc(self, component, c.EcsBitmaskType, description) ~= 0 then
        error('Invalid descriptor.', 2)
      end

      init_scope(self, component)
      return component
    end,
    new_array = function (self, name, element, count)
      if count < 0 or count > 0x7fffffff then
        error(string.format('Element count out of range (%f)', count), 2)
      end

      if c.ecs_lookup(self, name) ~= 0 then
        error('Component already exists.', 2)
      end

      local component = c.ecs_array_init(self, ecs_array_desc_t({ type = element, count = count }))
      if component == 0 then
        return
      end
      c.ecs_set_name(self, component, name)

      init_scope(self, component)
      return component
    end,
    new_struct = function (self, name, description)
      check_c_identifier(name)

      if c.ecs_lookup(self, name) ~= 0 then
        error('Component already exists.', 2)
      end

      local flecs_definition, c_definition = generate_definitions(description)

      local component = c.ecs_entity_init(self, ecs_entity_desc_t({ use_low_id = true }))
      if component == 0 then
        return
      end
      c.ecs_set_name(self, component, name)
      if c.ecs_meta_from_desc(self, component, c.EcsStructType, flecs_definition) ~= 0 then
        error('Invalid descriptor.', 2)
      end

      c.ecs_set_id(self, component, c.FLECS_IDEcsTypeID_, ffi.sizeof(EcsType), EcsType({ kind = c.EcsStructType }))

      local path = c.ecs_get_path_w_sep(self, 0, component, '_', nil)
      local c_identifier = ffi.string(path) .. '_' .. c_identifier_sequence
      c_identifier_sequence = c_identifier_sequence + 1
      c.ecs_os_api.free_(path)

      local success, error_message = pcall(function ()
        ffi.cdef('typedef struct ' .. c_identifier .. c_definition .. c_identifier)
      end)
      if not success then
        c.ecs_delete(self, component)
        error(error_message, 2)
      end
      local component_c_types = ffi.cast(world_binding_context_t_ptr, c.ecs_get_binding_ctx(self)).component_c_types
      c.ecs_map_insert(component_c_types, component, ffi.cast(uint64_t, c.ecs_os_api.strdup_(c_identifier)))

      ffi.metatype(c_identifier, {
        __tostring = function (this)
          local ptr = c.ecs_ptr_to_expr(self, component, this)
          local result = ffi.string(ptr)
          c.ecs_os_api.free_(ptr)
          return result
        end,
        __metatable = nil,
      })

      init_scope(self, component)
      return component
    end,
    new_alias = function (self, name, alias)
      local type_entity = c.ecs_lookup(self, name)
      if type_entity == 0 then
        error('Component does not exist.', 2)
      end

      if not c.ecs_has_id(self, type_entity, c.FLECS_IDEcsComponentID_) then
        error('Not a component,', 2)
      end

      if c.ecs_get_id(self, type_entity, c.FLECS_IDEcsTypeID_) == nil then
        error('Missing descriptor.', 2)
      end

      if c.ecs_lookup(self, alias) ~= 0 then
        error('Alias already exists.', 2)
      end

      local component = c.ecs_entity_init(self, ecs_entity_desc_t({ use_low_id = true }))
      if component == 0 then
        return
      end
      c.ecs_set_name(self, component, alias)
      -- TODO: Should we copy components?

      init_scope(self, component)
      return component
    end,
    new_prefab = function (self, id, expression)
      local entity
      if not id then
        entity = c.ecs_new(self)
        local scope = c.ecs_get_scope(self)
        if scope ~= 0 then
          ecs_add_pair(self, entity, c.EcsChildOf, scope)
        end
        c.ecs_add_id(self, entity, c.EcsPrefab)
      else
        entity = c.ecs_entity_init(self, ecs_entity_desc_t({
          name = id,
          add_expr = expression,
          add = uint64_t_vla(2, { c.EcsPrefab, 0 }),
        }))
      end

      return entity ~= 0 and entity or nil
    end,
    -- For safety, this function always returns a new struct initialized with the component's value.
    -- Client code should have no access to pointers, references, or arrays.
    -- And, since we're returning a copy here, there's no need for a get_mut function.
    get = function (self, entity, component)
      local data = c.ecs_get_id(self, entity, component)
      if data == nil then
        return
      end

      local ctype = c.ecs_map_get(
        ffi.cast(world_binding_context_t_ptr, c.ecs_get_binding_ctx(self)).component_c_types,
        component)
      if ctype == nil then
        error('Component ' .. self:name(component, true) .. " does not exist or it's missing serialization data.", 2)
      end
      ctype = ffi.string(ffi.cast(char_ptr_ptr, ctype)[0])

      return ffi.new(ctype, (ffi.cast(ctype .. '*', data)[0]))
    end,
    -- TODO: Get ref.
    set = function (self, entity, component, value)
      if not value then
        error('Value must not be nil', 2)
      end

      local ctype = c.ecs_map_get(
        ffi.cast(world_binding_context_t_ptr, c.ecs_get_binding_ctx(self)).component_c_types,
        component)
      if ctype == nil then
        error('Component ' .. self:name(component, true) .. " does not exist or it's missing serialization data.", 2)
      end
      ctype = ffi.string(ffi.cast(char_ptr_ptr, ctype)[0])

      c.ecs_set_id(self, entity, component, ffi.sizeof(ctype), type(value) == 'table' and ffi.new(ctype, value) or value)
    end,
    singleton_add = function (self, component)
      self:add(component, component)
    end,
    singleton_remove = function (self, component)
      self:remove(component, component)
    end,
    singleton_get = function (self, component)
      return self:get(component, component)
    end,
    singleton_set = function (self, component, value)
      if not value then
        error('Value must not be nil', 2)
      end
      self:set(component, component, value)
    end,
    query = function (self, query_or_description)
      local description
      local wrapper = query_wrapper_t_ptr(c.ecs_os_api.malloc_(ffi.sizeof(query_wrapper_t)))

      if type(query_or_description) == 'string' then
        description = ecs_query_desc_t({
          expr = query_or_description,
          binding_ctx = wrapper,
        })
        -- Queries without an associated entity don't have their binding_ctx_free function called
        -- upon world destruction. Do it ourselves with this mechanism.
        c.ecs_map_insert(
          ffi.cast(world_binding_context_t_ptr, c.ecs_get_binding_ctx(self)).alive_queries,
          ffi.cast(uint64_t, wrapper),
          0)
      else
        -- Clear dangerous, unreviewed or unimplemented fields.
        query_or_description._canary = 0;
        query_or_description.flags = 0;
        query_or_description.order_by_callback = nil;
        query_or_description.order_by_table_callback = nil;
        query_or_description.order_by = nil;
        query_or_description.group_by = nil;
        query_or_description.group_by_callback = nil;
        query_or_description.on_group_create = nil;
        query_or_description.on_group_delete = nil;
        query_or_description.group_by_ctx = nil;
        query_or_description.group_by_ctx_free = nil;
        query_or_description.ctx = nil;
        query_or_description.ctx_free = nil;

        -- Setup our binding context.
        query_or_description.binding_ctx = wrapper
        if not query_or_description.entity or query_or_description.entity == 0 then
          c.ecs_map_insert(
            ffi.cast(world_binding_context_t_ptr, c.ecs_get_binding_ctx(self)).alive_queries,
            ffi.cast(uint64_t, wrapper),
            0)
        else
          query_or_description.binding_ctx_free = invalidate_query_wrapper
        end

        description = ecs_query_desc_t(query_or_description)

        -- Clear dangerous stuff once again before handing it back to the user.
        query_or_description.binding_ctx = nil
        query_or_description.binding_ctx_free = nil
      end

      wrapper.query = c.ecs_query_init(self, description)

      return ffi.gc(ffi.cast(public_ecs_query_t_ptr, wrapper), finish_query_wrapper)
    end,
  },
  __tostring = function (self)
    return string.format('Flecs world 0x%x', ffi.cast(uint64_t, self))
  end,
  __metatable = nil,
})

ffi.metatype(ecs_world_info_t, {
  __tostring = function (self)
    local buf = buffer.new()

    buf:put 'Last component id: '
    buf:put(self.last_component_id)
    buf:put '\nMin id: '
    buf:put(self.min_id)
    buf:put '\nMax id: '
    buf:put(self.max_id)
    buf:put '\nDelta time raw: '
    buf:put(self.delta_time_raw)
    buf:put '\nDelta time: '
    buf:put(self.delta_time)
    buf:put '\nTime scale: '
    buf:put(self.time_scale)
    buf:put '\nTarget fps: '
    buf:put(self.target_fps)
    buf:put '\nFrame time total: '
    buf:put(self.frame_time_total)
    buf:put '\nSystem time total: '
    buf:put(self.system_time_total)
    buf:put '\nEmit time total: '
    buf:put(self.emit_time_total)
    buf:put '\nMerge time total: '
    buf:put(self.merge_time_total)
    buf:put '\nRematch time total: '
    buf:put(self.rematch_time_total)
    buf:put '\nWorld time total: '
    buf:put(self.world_time_total)
    buf:put '\nWorld time total raw: '
    buf:put(self.world_time_total_raw)
    buf:put '\nFrame count total: '
    buf:put(self.frame_count_total)
    buf:put '\nMerge count total: '
    buf:put(self.merge_count_total)
    buf:put '\nEval comp monitors total: '
    buf:put(self.eval_comp_monitors_total)
    buf:put '\nRematch count total: '
    buf:put(self.rematch_count_total)
    buf:put '\nId create total: '
    buf:put(self.id_create_total)
    buf:put '\nId delete total: '
    buf:put(self.id_delete_total)
    buf:put '\nTable create total: '
    buf:put(self.table_create_total)
    buf:put '\nTable delete total: '
    buf:put(self.table_delete_total)
    buf:put '\nPipeline build count total: '
    buf:put(self.pipeline_build_count_total)
    buf:put '\nSystems ran frame: '
    buf:put(self.systems_ran_frame)
    buf:put '\nObservers ran frame: '
    buf:put(self.observers_ran_frame)
    buf:put '\nTag id count: '
    buf:put(self.tag_id_count)
    buf:put '\nComponent id count: '
    buf:put(self.component_id_count)
    buf:put '\nPair id count: '
    buf:put(self.pair_id_count)
    buf:put '\nTable count: '
    buf:put(self.table_count)
    buf:put '\nCommand add count: '
    buf:put(self.cmd.add_count)
    buf:put '\nCommand remove count: '
    buf:put(self.cmd.remove_count)
    buf:put '\nCommand delete count: '
    buf:put(self.cmd.delete_count)
    buf:put '\nCommand clear count: '
    buf:put(self.cmd.clear_count)
    buf:put '\nCommand set count: '
    buf:put(self.cmd.set_count)
    buf:put '\nCommand ensure count: '
    buf:put(self.cmd.ensure_count)
    buf:put '\nCommand modified count: '
    buf:put(self.cmd.modified_count)
    buf:put '\nCommand discard count: '
    buf:put(self.cmd.discard_count)
    buf:put '\nCommand event count: '
    buf:put(self.cmd.event_count)
    buf:put '\nCommand other count: '
    buf:put(self.cmd.other_count)
    buf:put '\nCommand batched entity count: '
    buf:put(self.cmd.batched_entity_count)
    buf:put '\nCommand batched command count: '
    buf:put(self.cmd.batched_command_count)
    buf:put '\nName prefix: '
    if self.name_prefix == nil then
      buf:put '(null)'
    else
      buf:put(ffi.string(self.name_prefix))
    end

    return buf:get()
  end,
  __metatable = nil,
})

ffi.metatype(ecs_world_stats_t, {
  __tostring = function (self)
    local buf = buffer.new()

    buf:put 'Entities count:'
    buf:put(self.entities.count.counter.value[self.t])
    buf:put '\nEntities not alive count:'
    buf:put(self.entities.not_alive_count.counter.value[self.t])
    buf:put '\nComponents tag count:'
    buf:put(self.components.tag_count.counter.value[self.t])
    buf:put '\nComponents component count:'
    buf:put(self.components.component_count.counter.value[self.t])
    buf:put '\nComponents pair count:'
    buf:put(self.components.pair_count.counter.value[self.t])
    buf:put '\nComponents type count:'
    buf:put(self.components.type_count.counter.value[self.t])
    buf:put '\nComponents create count:'
    buf:put(self.components.create_count.counter.value[self.t])
    buf:put '\nComponents delete count:'
    buf:put(self.components.delete_count.counter.value[self.t])
    buf:put '\nTables count:'
    buf:put(self.tables.count.counter.value[self.t])
    buf:put '\nTables empty count:'
    buf:put(self.tables.empty_count.counter.value[self.t])
    buf:put '\nTables create count:'
    buf:put(self.tables.create_count.counter.value[self.t])
    buf:put '\nTables delete count:'
    buf:put(self.tables.delete_count.counter.value[self.t])
    buf:put '\nQueries query count:'
    buf:put(self.queries.query_count.counter.value[self.t])
    buf:put '\nQueries observer count:'
    buf:put(self.queries.observer_count.counter.value[self.t])
    buf:put '\nQueries system count:'
    buf:put(self.queries.system_count.counter.value[self.t])
    buf:put '\nCommands add count:'
    buf:put(self.commands.add_count.counter.value[self.t])
    buf:put '\nCommands remove count:'
    buf:put(self.commands.remove_count.counter.value[self.t])
    buf:put '\nCommands delete count:'
    buf:put(self.commands.delete_count.counter.value[self.t])
    buf:put '\nCommands clear count:'
    buf:put(self.commands.clear_count.counter.value[self.t])
    buf:put '\nCommands set count:'
    buf:put(self.commands.set_count.counter.value[self.t])
    buf:put '\nCommands ensure count:'
    buf:put(self.commands.ensure_count.counter.value[self.t])
    buf:put '\nCommands modified count:'
    buf:put(self.commands.modified_count.counter.value[self.t])
    buf:put '\nCommands other count:'
    buf:put(self.commands.other_count.counter.value[self.t])
    buf:put '\nCommands discard count:'
    buf:put(self.commands.discard_count.counter.value[self.t])
    buf:put '\nCommands batched entity count:'
    buf:put(self.commands.batched_entity_count.counter.value[self.t])
    buf:put '\nCommands batched count:'
    buf:put(self.commands.batched_count.counter.value[self.t])
    buf:put '\nFrame frame count:'
    buf:put(self.frame.frame_count.counter.value[self.t])
    buf:put '\nFrame merge count:'
    buf:put(self.frame.merge_count.counter.value[self.t])
    buf:put '\nFrame rematch count:'
    buf:put(self.frame.rematch_count.counter.value[self.t])
    buf:put '\nFrame pipeline build count:'
    buf:put(self.frame.pipeline_build_count.counter.value[self.t])
    buf:put '\nFrame systems ran:'
    buf:put(self.frame.systems_ran.counter.value[self.t])
    buf:put '\nFrame observers ran:'
    buf:put(self.frame.observers_ran.counter.value[self.t])
    buf:put '\nFrame event emit count:'
    buf:put(self.frame.event_emit_count.counter.value[self.t])
    buf:put '\nPerformance world time raw:'
    buf:put(self.performance.world_time_raw.counter.value[self.t])
    buf:put '\nPerformance world time:'
    buf:put(self.performance.world_time.counter.value[self.t])
    buf:put '\nPerformance frame time:'
    buf:put(self.performance.frame_time.counter.value[self.t])
    buf:put '\nPerformance system time:'
    buf:put(self.performance.system_time.counter.value[self.t])
    buf:put '\nPerformance emit time:'
    buf:put(self.performance.emit_time.counter.value[self.t])
    buf:put '\nPerformance merge time:'
    buf:put(self.performance.merge_time.counter.value[self.t])
    buf:put '\nPerformance rematch time:'
    buf:put(self.performance.rematch_time.counter.value[self.t])
    buf:put '\nPerformance fps:'
    buf:put(self.performance.fps.counter.value[self.t])
    buf:put '\nPerformance delta time:'
    buf:put(self.performance.delta_time.counter.value[self.t])
    buf:put '\nMemory alloc count:'
    buf:put(self.memory.alloc_count.counter.value[self.t])
    buf:put '\nMemory realloc count:'
    buf:put(self.memory.realloc_count.counter.value[self.t])
    buf:put '\nMemory free count:'
    buf:put(self.memory.free_count.counter.value[self.t])
    buf:put '\nMemory outstanding alloc count:'
    buf:put(self.memory.outstanding_alloc_count.counter.value[self.t])
    buf:put '\nMemory block alloc count:'
    buf:put(self.memory.block_alloc_count.counter.value[self.t])
    buf:put '\nMemory block free count:'
    buf:put(self.memory.block_free_count.counter.value[self.t])
    buf:put '\nMemory block outstanding alloc count:'
    buf:put(self.memory.block_outstanding_alloc_count.counter.value[self.t])
    buf:put '\nMemory stack alloc count:'
    buf:put(self.memory.stack_alloc_count.counter.value[self.t])
    buf:put '\nMemory stack free count:'
    buf:put(self.memory.stack_free_count.counter.value[self.t])
    buf:put '\nMemory stack outstanding alloc count:'
    buf:put(self.memory.stack_outstanding_alloc_count.counter.value[self.t])
    buf:put '\nHTTP request received count:'
    buf:put(self.http.request_received_count.counter.value[self.t])
    buf:put '\nHTTP request invalid count:'
    buf:put(self.http.request_invalid_count.counter.value[self.t])
    buf:put '\nHTTP request handled ok count:'
    buf:put(self.http.request_handled_ok_count.counter.value[self.t])
    buf:put '\nHTTP request handled error count:'
    buf:put(self.http.request_handled_error_count.counter.value[self.t])
    buf:put '\nHTTP request not handled count:'
    buf:put(self.http.request_not_handled_count.counter.value[self.t])
    buf:put '\nHTTP request preflight count:'
    buf:put(self.http.request_preflight_count.counter.value[self.t])
    buf:put '\nHTTP send ok count:'
    buf:put(self.http.send_ok_count.counter.value[self.t])
    buf:put '\nHTTP send error count:'
    buf:put(self.http.send_error_count.counter.value[self.t])
    buf:put '\nHTTP busy count:'
    buf:put(self.http.busy_count.counter.value[self.t])

    return buf:get()
  end,
  __metatable = nil,
})

ffi.metatype(ecs_metric_t, {
  __metatable = nil,
})

local function finish_iter_wrapper(wrapper)
  wrapper = ffi.cast(iter_wrapper_t_ptr, wrapper)
  if not wrapper.invalid then
    c.ecs_map_remove(
      ffi.cast(world_binding_context_t_ptr, c.ecs_get_binding_ctx(wrapper.iter.world)).alive_iterators,
      ffi.cast(uint64_t, wrapper))
    c.ecs_iter_fini(wrapper.iter)
  end
  c.ecs_os_api.free_(wrapper)
end

local function invalidate_iter_wrapper(wrapper)
  ffi.cast(iter_wrapper_t_ptr, ffi.cast(ecs_iter_t_ptr, wrapper).binding_ctx).invalid = true
end

ffi.metatype(public_ecs_query_t, {
  __index = {
    iter = function (self)
      local query_wrapper = ffi.cast(query_wrapper_t_ptr, self)
      if query_wrapper.query == nil then
        error('The query has been finished.', 2)
      end

      local world = query_wrapper.query.world

      local wrapper = ffi.cast(
        iter_wrapper_t_ptr,
        c.ecs_os_api.malloc_(ffi.sizeof(iter_wrapper_t)))
      wrapper.iter = c.ecs_query_iter(world, query_wrapper.query)
      wrapper.iter.binding_ctx = wrapper
      wrapper.iter.fini = invalidate_iter_wrapper
      wrapper.i = 0
      wrapper.invalid = false

      c.ecs_map_insert(
        ffi.cast(world_binding_context_t_ptr, c.ecs_get_binding_ctx(world)).alive_iterators,
        ffi.cast(uint64_t, wrapper),
        0)

      return ffi.gc(ffi.cast(public_ecs_iter_t_ptr, wrapper), finish_iter_wrapper)
    end,
  },
  is_valid = function ()
    local query_wrapper = ffi.cast(query_wrapper_t_ptr, self)
    return query_wrapper.query ~= nil
  end,
  __tostring = function (self)
    local query_wrapper = ffi.cast(query_wrapper_t_ptr, self)
    if query_wrapper.query == nil then
      return 'Invalid query.'
    end

    local ptr = c.ecs_query_str(query_wrapper.query)
    local result = ffi.string(ptr)
    c.ecs_os_api.free_(ptr)
    return result
  end,
  __metatable = nil,
})

ffi.metatype(public_ecs_iter_t, {
  __tostring = function (self)
    local wrapper = ffi.cast(iter_wrapper_t_ptr, self)
    if wrapper.invalid then
      return 'Invalid iterator.'
    end
    return 'Iterator for query: ' .. tostring(ffi.cast(public_ecs_query_t_ptr, wrapper.iter.query.binding_ctx))
  end,
  is_valid = function (self)
    local iter_wrapper = ffi.cast(iter_wrapper_t_ptr, self)
    return not iter_wrapper.invalid
  end,
  __metatable = nil,
})

local function finish_world_binding_context(binding_context)
  binding_context = ffi.cast(world_binding_context_t_ptr, binding_context)

  -- Free all contained strings.
  local iter = ecs_map_iter_t_vla(1)
  iter[0] = c.ecs_map_iter(binding_context.component_c_types)
  while c.ecs_map_next(iter) do
    c.ecs_os_api.free_(ffi.cast(void_ptr, iter[0].res[1]))
  end

  -- Finish all alive queries.
  iter[0] = c.ecs_map_iter(binding_context.alive_queries)
  while c.ecs_map_next(iter) do
    local wrapper = ffi.cast(query_wrapper_t_ptr, iter[0].res[0])
    c.ecs_query_fini(wrapper.query)
    wrapper.query = nil
  end

  -- Finish all alive iterators.
  iter[0] = c.ecs_map_iter(binding_context.alive_iterators)
  while c.ecs_map_next(iter) do
    local wrapper = ffi.cast(iter_wrapper_t_ptr, iter[0].res[0])
    c.ecs_iter_fini(wrapper.iter)
    wrapper.invalid = true
  end

  c.ecs_map_fini(binding_context.component_c_types)
  c.ecs_map_fini(binding_context.alive_queries)
  c.ecs_map_fini(binding_context.alive_iterators)
  c.ecs_os_api.free_(binding_context)
end

local function init_world(world)
  local binding_context = ffi.cast(
    world_binding_context_t_ptr,
    c.ecs_os_api.malloc_(ffi.sizeof(world_binding_context_t)))
  c.ecs_map_init(binding_context.component_c_types, nil)
  c.ecs_map_init(binding_context.alive_iterators, nil)
  c.ecs_map_init(binding_context.alive_queries, nil)
  c.ecs_set_binding_ctx(world, binding_context, finish_world_binding_context)
  return world
end

local function finish_world(world)
  c.ecs_fini(world)
end

local ret = {}

function ret.init()
  return ffi.gc(init_world(c.ecs_init()), finish_world)
end

function ret.mini()
  return ffi.gc(init_world(c.ecs_mini()), finish_world)
end

ret.inout = {
  default = c.EcsInOutDefault,
  none = c.EcsInOutNone,
  filter = c.EcsInOutFilter,
  inout = c.EcsInOut,
  in_ = c.EcsIn,
  out = c.EcsOut,
}

ret.cache = {
  default = c.EcsQueryCacheDefault,
  auto = c.EcsQueryCacheAuto,
  all = c.EcsQueryCacheAll,
  none = c.EcsQueryCacheNone,
}

return ret
