local ffi = require 'ffi'
local buffer = require 'string.buffer'
local table = table

ecs_ftime_t = ecs_ftime_t or 'float'
ecs_float_t = ecs_float_t or 'float'

ffi.cdef('typedef ' .. ecs_ftime_t .. ' ecs_ftime_t;')
ffi.cdef('typedef ' .. ecs_float_t .. ' ecs_float_t;')

ffi.cdef[[
typedef uint64_t ecs_id_t;
typedef ecs_id_t ecs_entity_t;
typedef uint8_t ecs_flags8_t;
typedef uint16_t ecs_flags16_t;
typedef uint32_t ecs_flags32_t;
typedef uint64_t ecs_flags64_t;
typedef struct ecs_world_t ecs_world_t;
typedef struct ecs_world_info_t {
  ecs_entity_t last_component_id;
  ecs_entity_t min_id;
  ecs_entity_t max_id;
  ecs_ftime_t delta_time_raw;
  ecs_ftime_t delta_time;
  ecs_ftime_t time_scale;
  ecs_ftime_t target_fps;
  ecs_ftime_t frame_time_total;
  ecs_ftime_t system_time_total;
  ecs_ftime_t emit_time_total;
  ecs_ftime_t merge_time_total;
  ecs_ftime_t rematch_time_total;
  double world_time_total;
  double world_time_total_raw;
  int64_t frame_count_total;
  int64_t merge_count_total;
  int64_t eval_comp_monitors_total;
  int64_t rematch_count_total;
  int64_t id_create_total;
  int64_t id_delete_total;
  int64_t table_create_total;
  int64_t table_delete_total;
  int64_t pipeline_build_count_total;
  int64_t systems_ran_frame;
  int64_t observers_ran_frame;
  int32_t tag_id_count;
  int32_t component_id_count;
  int32_t pair_id_count;
  int32_t table_count;
  int32_t empty_table_count;
  struct {
    int64_t add_count;
    int64_t remove_count;
    int64_t delete_count;
    int64_t clear_count;
    int64_t set_count;
    int64_t ensure_count;
    int64_t modified_count;
    int64_t discard_count;
    int64_t event_count;
    int64_t other_count;
    int64_t batched_entity_count;
    int64_t batched_command_count;
  } cmd;
  const char *name_prefix;
} ecs_world_info_t;
static const int ECS_STAT_WINDOW = 60;
typedef struct ecs_gauge_t {
  ecs_float_t avg[ECS_STAT_WINDOW];
  ecs_float_t min[ECS_STAT_WINDOW];
  ecs_float_t max[ECS_STAT_WINDOW];
} ecs_gauge_t;
typedef struct ecs_counter_t {
  ecs_gauge_t rate;
  double value[ECS_STAT_WINDOW];
} ecs_counter_t;
typedef union ecs_metric_t {
  ecs_gauge_t gauge;
  ecs_counter_t counter;
} ecs_metric_t;
typedef struct ecs_world_stats_t {
  int64_t first_;
  struct {
    ecs_metric_t count;
    ecs_metric_t not_alive_count;
  } entities;
  struct {
    ecs_metric_t tag_count;
    ecs_metric_t component_count;
    ecs_metric_t pair_count;
    ecs_metric_t type_count;
    ecs_metric_t create_count;
    ecs_metric_t delete_count;
  } components;
  struct {
    ecs_metric_t count;
    ecs_metric_t empty_count;
    ecs_metric_t create_count;
    ecs_metric_t delete_count;
  } tables;
  struct {
    ecs_metric_t query_count;
    ecs_metric_t observer_count;
    ecs_metric_t system_count;
  } queries;
  struct {
    ecs_metric_t add_count;
    ecs_metric_t remove_count;
    ecs_metric_t delete_count;
    ecs_metric_t clear_count;
    ecs_metric_t set_count;
    ecs_metric_t ensure_count;
    ecs_metric_t modified_count;
    ecs_metric_t other_count;
    ecs_metric_t discard_count;
    ecs_metric_t batched_entity_count;
    ecs_metric_t batched_count;
  } commands;
  struct {
    ecs_metric_t frame_count;
    ecs_metric_t merge_count;
    ecs_metric_t rematch_count;
    ecs_metric_t pipeline_build_count;
    ecs_metric_t systems_ran;
    ecs_metric_t observers_ran;
    ecs_metric_t event_emit_count;
  } frame;
  struct {
    ecs_metric_t world_time_raw;
    ecs_metric_t world_time;
    ecs_metric_t frame_time;
    ecs_metric_t system_time;
    ecs_metric_t emit_time;
    ecs_metric_t merge_time;
    ecs_metric_t rematch_time;
    ecs_metric_t fps;
    ecs_metric_t delta_time;
  } performance;
  struct {
    ecs_metric_t alloc_count;
    ecs_metric_t realloc_count;
    ecs_metric_t free_count;
    ecs_metric_t outstanding_alloc_count;
    ecs_metric_t block_alloc_count;
    ecs_metric_t block_free_count;
    ecs_metric_t block_outstanding_alloc_count;
    ecs_metric_t stack_alloc_count;
    ecs_metric_t stack_free_count;
    ecs_metric_t stack_outstanding_alloc_count;
  } memory;
  struct {
    ecs_metric_t request_received_count;
    ecs_metric_t request_invalid_count;
    ecs_metric_t request_handled_ok_count;
    ecs_metric_t request_handled_error_count;
    ecs_metric_t request_not_handled_count;
    ecs_metric_t request_preflight_count;
    ecs_metric_t send_ok_count;
    ecs_metric_t send_error_count;
    ecs_metric_t busy_count;
  } http;
  int64_t last_;
  int32_t t;
} ecs_world_stats_t;
typedef struct ecs_entities_t {
    const ecs_entity_t *ids;
    int32_t count;
    int32_t alive_count;
} ecs_entities_t;

ecs_world_t* ecs_init(void);
ecs_world_t* ecs_mini(void);
void ecs_fini(ecs_world_t *world);
bool ecs_is_fini(const ecs_world_t *world);
const ecs_world_info_t* ecs_get_world_info(const ecs_world_t *world);
void ecs_world_stats_get(const ecs_world_t *world, ecs_world_stats_t *stats);
void ecs_dim(ecs_world_t *world, int32_t entity_count);
void ecs_quit(ecs_world_t *world);
bool ecs_should_quit(const ecs_world_t *world);
ecs_entities_t ecs_get_entities(const ecs_world_t *world);
ecs_flags32_t ecs_world_get_flags(const ecs_world_t *world);
void ecs_measure_frame_time(ecs_world_t *world, bool enable);
void ecs_measure_system_time(ecs_world_t *world, bool enable);
void ecs_set_target_fps(ecs_world_t *world, ecs_ftime_t fps);
void ecs_set_default_query_flags(ecs_world_t *world, ecs_flags32_t flags);
]]

local ecs_world_info_t = ffi.typeof 'ecs_world_info_t'
local ecs_world_stats_t = ffi.typeof 'ecs_world_stats_t'
local ecs_metric_t = ffi.typeof 'ecs_metric_t'

ffi.metatype('ecs_world_t', {
  __index = {
    is_fini = function(self)
      return ffi.C.ecs_is_fini(self)
    end,
    info = function(self)
      return ffi.C.ecs_get_world_info(self)
    end,
    stats = function(self)
      local stats = ecs_world_stats_t()
      ffi.C.ecs_world_stats_get(self, stats)
      return stats
    end,
    dim = function(self, entity_count)
      ffi.C.ecs_dim(self, entity_count)
    end,
    quit = function(self)
      ffi.C.ecs_quit(self)
    end,
    should_quit = function(self)
      return ffi.C.ecs_should_quit(self)
    end,
    get_entities = function(self)
      local entities = ffi.C.ecs_get_entities(self)
      local alive = {}
      local dead = {}

      for i = 0, entities.alive_count - 1 do
        table.insert(alive, entities.ids[i])
      end

      for i = entities.alive_count + 1, entities.count - 1 do
        table.insert(dead, entities.ids[i])
      end

      return { alive = alive, dead = dead }
    end,
    get_flags = function(self)
      return ffi.C.ecs_world_get_flags(self)
    end,
    measure_frame_time = function(self, enable)
      ffi.C.ecs_measure_frame_time(self, enable)
    end,
    measure_system_time = function(self, enable)
      ffi.C.ecs_measure_system_time(self, enable)
    end,
    set_target_fps = function(self, fps)
      ffi.C.ecs_set_target_fps(self, fps)
    end,
    set_default_query_flags = function(self, flags)
      ffi.C.ecs_set_default_query_flags(self, flags)
    end,
  },
  __metatable = nil,
})

ffi.metatype(ecs_world_info_t, {
  __tostring = function(self)
    local buf = buffer.new()

    buf:put 'World information:'
    buf:put '\nLast component id: '
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
    buf:put '\nEmpty table count: '
    buf:put(self.empty_table_count)
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
  __tostring = function(self)
    local buf = buffer.new()

    buf:put '\nEntities count:'
    buf:put(self.entities.count)
    buf:put '\nEntities not alive count:'
    buf:put(self.entities.not_alive_count)
    buf:put '\nComponents tag count:'
    buf:put(self.components.tag_count)
    buf:put '\nComponents component count:'
    buf:put(self.components.component_count)
    buf:put '\nComponents pair count:'
    buf:put(self.components.pair_count)
    buf:put '\nComponents type count:'
    buf:put(self.components.type_count)
    buf:put '\nComponents create count:'
    buf:put(self.components.create_count)
    buf:put '\nComponents delete count:'
    buf:put(self.components.delete_count)
    buf:put '\nTables count:'
    buf:put(self.tables.count)
    buf:put '\nTables empty count:'
    buf:put(self.tables.empty_count)
    buf:put '\nTables create count:'
    buf:put(self.tables.create_count)
    buf:put '\nTables delete count:'
    buf:put(self.tables.delete_count)
    buf:put '\nQueries query count:'
    buf:put(self.queries.query_count)
    buf:put '\nQueries observer count:'
    buf:put(self.queries.observer_count)
    buf:put '\nQueries system count:'
    buf:put(self.queries.system_count)
    buf:put '\nCommands add count:'
    buf:put(self.commands.add_count)
    buf:put '\nCommands remove count:'
    buf:put(self.commands.remove_count)
    buf:put '\nCommands delete count:'
    buf:put(self.commands.delete_count)
    buf:put '\nCommands clear count:'
    buf:put(self.commands.clear_count)
    buf:put '\nCommands set count:'
    buf:put(self.commands.set_count)
    buf:put '\nCommands ensure count:'
    buf:put(self.commands.ensure_count)
    buf:put '\nCommands modified count:'
    buf:put(self.commands.modified_count)
    buf:put '\nCommands other count:'
    buf:put(self.commands.other_count)
    buf:put '\nCommands discard count:'
    buf:put(self.commands.discard_count)
    buf:put '\nCommands batched entity count:'
    buf:put(self.commands.batched_entity_count)
    buf:put '\nCommands batched count:'
    buf:put(self.commands.batched_count)
    buf:put '\nFrame frame count:'
    buf:put(self.frame.frame_count)
    buf:put '\nFrame merge count:'
    buf:put(self.frame.merge_count)
    buf:put '\nFrame rematch count:'
    buf:put(self.frame.rematch_count)
    buf:put '\nFrame pipeline build count:'
    buf:put(self.frame.pipeline_build_count)
    buf:put '\nFrame systems ran:'
    buf:put(self.frame.systems_ran)
    buf:put '\nFrame observers ran:'
    buf:put(self.frame.observers_ran)
    buf:put '\nFrame event emit count:'
    buf:put(self.frame.event_emit_count)
    buf:put '\nPerformance world time raw:'
    buf:put(self.performance.world_time_raw)
    buf:put '\nPerformance world time:'
    buf:put(self.performance.world_time)
    buf:put '\nPerformance frame time:'
    buf:put(self.performance.frame_time)
    buf:put '\nPerformance system time:'
    buf:put(self.performance.system_time)
    buf:put '\nPerformance emit time:'
    buf:put(self.performance.emit_time)
    buf:put '\nPerformance merge time:'
    buf:put(self.performance.merge_time)
    buf:put '\nPerformance rematch time:'
    buf:put(self.performance.rematch_time)
    buf:put '\nPerformance fps:'
    buf:put(self.performance.fps)
    buf:put '\nPerformance delta time:'
    buf:put(self.performance.delta_time)
    buf:put '\nMemory alloc count:'
    buf:put(self.memory.alloc_count)
    buf:put '\nMemory realloc count:'
    buf:put(self.memory.realloc_count)
    buf:put '\nMemory free count:'
    buf:put(self.memory.free_count)
    buf:put '\nMemory outstanding alloc count:'
    buf:put(self.memory.outstanding_alloc_count)
    buf:put '\nMemory block alloc count:'
    buf:put(self.memory.block_alloc_count)
    buf:put '\nMemory block free count:'
    buf:put(self.memory.block_free_count)
    buf:put '\nMemory block outstanding alloc count:'
    buf:put(self.memory.block_outstanding_alloc_count)
    buf:put '\nMemory stack alloc count:'
    buf:put(self.memory.stack_alloc_count)
    buf:put '\nMemory stack free count:'
    buf:put(self.memory.stack_free_count)
    buf:put '\nMemory stack outstanding alloc count:'
    buf:put(self.memory.stack_outstanding_alloc_count)
    buf:put '\nHTTP request received count:'
    buf:put(self.http.request_received_count)
    buf:put '\nHTTP request invalid count:'
    buf:put(self.http.request_invalid_count)
    buf:put '\nHTTP request handled ok count:'
    buf:put(self.http.request_handled_ok_count)
    buf:put '\nHTTP request handled error count:'
    buf:put(self.http.request_handled_error_count)
    buf:put '\nHTTP request not handled count:'
    buf:put(self.http.request_not_handled_count)
    buf:put '\nHTTP request preflight count:'
    buf:put(self.http.request_preflight_count)
    buf:put '\nHTTP send ok count:'
    buf:put(self.http.send_ok_count)
    buf:put '\nHTTP send error count:'
    buf:put(self.http.send_error_count)
    buf:put '\nHTTP busy count:'
    buf:put(self.http.busy_count)

    return buf:get()
  end,
  __metatable = nil,
})

ffi.metatype(ecs_metric_t, {
  __metatable = nil,
})

local ret = {}

function ret.init()
  return ffi.gc(ffi.C.ecs_init(), ffi.C.ecs_fini)
end

function ret.mini()
  return ffi.gc(ffi.C.ecs_mini(), ffi.C.ecs_fini)
end

return ret
