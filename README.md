# flecs-luajit
[![License: WTFPL](https://img.shields.io/badge/License-WTFPL-brightgreen.svg)](http://www.wtfpl.net/about/)

**WIP** single-file and pure Lua bindings for [Flecs](https://github.com/SanderMertens/flecs/) using the LuaJIT FFI. The aim is to implement at least all the basic Flecs' features that allows making a game. Unsafer operations are not implemented yet. Based on [https://github.com/flecs-hub/flecs-lua/]()

## How to build and run

Standard CMake build. You need to copy or make a symbolic link to `ecs.lua` and `tests.lua` alongside the built binary. Download, compile and install LuaJIT following the directions in the [official webpage](https://luajit.org/), or just install it from your distro's package repositories, but I don't peronally use those.

For Windows, after compiling LuaJIT, copy or symlink `lua51.lib` found at `luajit/src` after the build to a new directory under this project's root `libs/luajit`. Copy `lua.h`, `luaconf.h`, `lualib.h` and `lauxlib.h` to a new directory `libs/lua/luajit-2.1`. Blame Windows for not having a standard way to install development libraries.

### Embedding into another app

At the Lua side, you only need `ecs.lua`, the standard Lua libraries and the standard FFI, BitOp and string buffer LuaJIT libraries. At the C side, your app needs to export Flecs' symbols, which Linux does by default. For Windows, you need to comment out the second line `#define flecs_STATIC` in `flecs.h` and define `flecs_EXPORTS`, probably unless you use Flecs as a DLL but I haven't tested this. Also, it's important to define `FLECS_SOFT_ASSERT` to make Flecs do some checks and allow it to recover from recoverable errors, specially if you run third-party code!

## Configuration

Before `require`'ing the library, you can set the globals `ecs_ftime_t` and `ecs_float_t` to any string representing a C type matching any custom `#define`s you might have provided to Flecs; for example, `#define ecs_ftime_t double`. They must match in Lua and in C! They are both `float` by default, just like Flecs' defaults.

### Caveats

This library uses `ffi.C.free()` to release the memory allocated and returned by Flecs, so don't pass custom memory management functions to Flecs (for example, by using `ecs_os_set_api()`)! This unsafe operation is not yet implemented.
