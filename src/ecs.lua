local ffi = require 'ffi'

ffi.cdef[[
typedef struct ecs_world_t ecs_world_t;

ecs_world_t* ecs_init(void);
void ecs_fini(ecs_world_t* world);
]]

ffi.metatype("ecs_world_t", {
  __index = {
  },
  __metatable = nil
})

local ret = {}

function ret.init()
  return ffi.gc(ffi.C.ecs_init(), ffi.C.ecs_fini)
end

return ret
