# flecs-luajit
[![License: WTFPL](https://img.shields.io/badge/License-WTFPL-brightgreen.svg)](http://www.wtfpl.net/about/)
![WIP](https://img.shields.io/badge/WIP-red)

**WIP** single-file and pure Lua bindings for [Flecs](https://github.com/SanderMertens/flecs/) using the LuaJIT FFI. The
aim is to implement at least all the basic Flecs' features that allow making a game. Unsafer operations are not
implemented yet. Based on [https://github.com/flecs-hub/flecs-lua/]()

## How to build and run the tests

- Run `utils/preprocess.sh` from the project root. This will generate the FFI cdefs for Flecs from `libs/flecs/flecs.h`,
append `src/ecs.lua` and generate the final Lua file, ready to use, in `distr/ecs.lua`.
- Do a standard CMake build. 
- Download, compile and install LuaJIT following the directions in the [official webpage](https://luajit.org/), or just
install it from your distro's package repositories, but I don't personally use those.
- When running the test program, pass the full path to the file originally placed in `distr/ecs.lua` as the first
argument and the path to `src/tests.lua` as the second argument. You can set those in your IDE.
- For Windows, after compiling LuaJIT, copy or symlink `lua51.lib` found at `luajit/src` after the build to a new
directory under this project's root `libs/luajit`. Copy `lua.h`, `luaconf.h`, `lualib.h` and `lauxlib.h` to a new
directory `libs/lua/luajit-2.1`. Blame Windows for not having a standard way to install development libraries.

## Embedding into another app

On the Lua side, you only need `distr/ecs.lua`, the standard Lua libraries and the standard FFI, BitOp and string buffer
LuaJIT libraries. On the C side, your app needs to export Flecs' symbols, which Linux does by default. For Windows, you
need to comment out the second line `#define flecs_STATIC` in `flecs.h` and define `flecs_EXPORTS`, probably unless you
use Flecs as a DLL, but I haven't tested this. Also, it's important to define `FLECS_SOFT_ASSERT` to make Flecs do some
checks and allow it to recover from recoverable errors, specially if you run third-party code! Finally, just run
`distr/ecs.lua` however you want. It returns the entire module as a table.

## Configuration

When running `utils/preprocess.sh`, any arguments you pass will be forwarded to `cc`. Therefore, you are able to
customize Flecs' macros. Notably, you can customize `ecs_float_t` and `ecs_ftime_t` to use double precision, for
example with `./utils/preprocess.sh -Decs_ftime_t=double -Decs_float_t=double`. You MUST make sure to preprocess and
compile `flecs.c` with the same definitions, otherwise chaos will ensure!

## Caveats

This library uses `ffi.C.free()` to release the memory allocated and returned by Flecs, so don't pass custom memory
management functions to Flecs (for example, by using `ecs_os_set_api()`)! This unsafe operation is not yet implemented.
