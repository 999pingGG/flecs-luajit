#include <luajit-2.1/lua.h>
#include <luajit-2.1/lualib.h>
#include <luajit-2.1/lauxlib.h>

#include <stdlib.h>

static int traceback(lua_State *L) {
  const char *msg = lua_tostring(L, 1);
  if (msg) {
    luaL_traceback(L, L, msg, 1);
  } else {
    lua_pushliteral(L, "No error message");
  }
  return 1;
}

#include "flecs.h"
#include <time.h>

static void add_entities(ecs_world_t* world, ecs_entity_t* components, int count, int n) {
  for (int i = 0; i < n; i++) {
    ecs_entity_t entity = ecs_new(world);
    for (int i = 0; i < (rand() % 5) + 1; i++) {
        ecs_add_id(world, entity, components[rand() % count]);
    }
  }
}

int main(const int argc, const char* argv[]) {
  (void)argc;
  (void)argv;

  ecs_world_t* world = ecs_init();

  ecs_entity_t components[] = {
      ecs_new(world),
      ecs_new(world),
      ecs_new(world),
      ecs_new(world),
      ecs_new(world),
      ecs_new(world),
      ecs_new(world),
      ecs_new(world),
  };

  srand((unsigned int)time(NULL));

  add_entities(world, components, sizeof(components) / sizeof(components[0]), 100);

  ecs_query_t* q = ecs_query_init(world, &(ecs_query_desc_t){
      .terms = {
        { .id = components[0] },
	  }
  });

  ecs_iter_t it = ecs_query_iter(world, q);
  int tables = 0;
  while (ecs_query_next(&it)) {
	printf("Matched %d entities\n", it.count);
    for (int i = 0; i < it.count; i++) {
      printf("Entity %llu has component %llu\n", it.entities[i], components[0]);
    }
    if (++tables > 4) {
        printf("bailing out\n");
        break;
    }
  }

  add_entities(world, components, sizeof(components) / sizeof(components[0]), 10000);

  while (ecs_query_next(&it)) {
      printf("Matched %d entities\n", it.count);
      for (int i = 0; i < it.count; i++) {
          printf("Entity %llu has component %llu\n", it.entities[i], components[0]);
      }
      if (++tables > 4) {
          printf("bailing out\n");
          break;
      }
  }

  //ecs_iter_fini(&it);

  ecs_fini(world);
  return 0;

  lua_State* L = luaL_newstate();
  if (!L) {
    fprintf(stderr, "Failed to create Lua state\n");
    goto error;
  }

  luaL_openlibs(L);

  // Push error handler once, keep its index
  lua_pushcfunction(L, traceback);
  const int error_handler_index = lua_gettop(L);

  if (luaL_loadfile(L, "ecs.lua") != LUA_OK) {
    fprintf(stderr, "%s\n", lua_tostring(L, -1));
    goto error;
  }

  // expect 1 return value (the ecs table)
  if (lua_pcall(L, 0, 1, error_handler_index) != LUA_OK) {
    fprintf(stderr, "%s\n", lua_tostring(L, -1));
    goto error;
  }

  if (!lua_istable(L, -1)) {
    fprintf(stderr, "ecs.lua must return a table!\n");
    goto error;
  }

  // stack: error_handler_index, ecs_table

  if (luaL_loadfile(L, "tests.lua") != LUA_OK) {
    fprintf(stderr, "%s\n", lua_tostring(L, -1));
    goto error;
  }

  // stack: error_handler_index, ecs_table, tests_function

  // Push ecs_table as arg for tests.lua
  lua_pushvalue(L, -2); // copy ecs_table
  // stack: error_handler_index, ecs_table, tests_function, ecs_table

  // 1 argument passed, 0 return values
  if (lua_pcall(L, 1, 0, error_handler_index) != LUA_OK) {
    fprintf(stderr, "%s\n", lua_tostring(L, -1));
    goto error;
  }

  lua_close(L);
  return EXIT_SUCCESS;

  error:
  lua_close(L);
  return EXIT_FAILURE;
}
