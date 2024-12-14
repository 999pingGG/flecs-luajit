#include <flecs.h>
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

int main(void) {
  lua_State *L = luaL_newstate();
  if (!L) {
    fprintf(stderr, "Failed to create Lua state\n");
    goto error;
  }

  luaL_openlibs(L);

  if (luaL_loadfile(L, "tests.lua") != LUA_OK) {
    fprintf(stderr, "%s\n", lua_tostring(L, -1));
    goto error;
  }

  lua_pushcfunction(L, traceback);
  lua_insert(L, -2);

  if (lua_pcall(L, 0, 0, -2) != LUA_OK) {
    fprintf(stderr, "Error: %s\n", lua_tostring(L, -1));
    goto error;
  }

  lua_close(L);
  return EXIT_SUCCESS;

  error:
  lua_close(L);
  return EXIT_FAILURE;
}
