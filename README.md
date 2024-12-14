# flecs-luajit
Pure Lua bindings for [flecs](https://github.com/SanderMertens/flecs/) using the LuaJIT FFI.
## How to build and run
Standard CMake build. You need to copy or make a symbolic link to `ecs.lua` and `tests.lua` alongside the built binary.
## Configuration
Before `require`'ing the library, you can set the globals `ecs_ftime_t` and `ecs_float_t` to any string representing a C type matching any custom `#define`s you might have provided to flecs; for example `#define ecs_ftime_t double`. They must match in Lua and in C! They are both `float` by default, just like flecs' defaults.
