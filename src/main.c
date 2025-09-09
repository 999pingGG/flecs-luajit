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

int main(const int argc, const char* argv[]) {
  if (argc != 3) {
    fprintf(stderr, "Usage: %s <path-to-distr-ecs.lua> <path-to-tests.lua>\n", argv[0]);
    return EXIT_FAILURE;
  }

  lua_State* L = luaL_newstate();
  if (!L) {
    fprintf(stderr, "Failed to create Lua state\n");
    goto error;
  }

  luaL_openlibs(L);

  // Push error handler once, keep its index
  lua_pushcfunction(L, traceback);
  const int error_handler_index = lua_gettop(L);

  // Load ecs.lua
  if (luaL_loadfile(L, argv[1]) != LUA_OK) {
    fprintf(stderr, "%s\n", lua_tostring(L, -1));
    goto error;
  }

  // expect 1 return value (the ecs table)
  if (lua_pcall(L, 0, 1, error_handler_index) != LUA_OK) {
    fprintf(stderr, "%s\n", lua_tostring(L, -1));
    goto error;
  }

  if (!lua_istable(L, -1)) {
    fprintf(stderr, "%s must return a table!\n", argv[1]);
    goto error;
  }

  // stack: error_handler_index, ecs_table

  // load tests.lua
  if (luaL_loadfile(L, argv[2]) != LUA_OK) {
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
