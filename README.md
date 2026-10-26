# flecs-luajit
[![License: WTFPL](https://img.shields.io/badge/License-WTFPL-brightgreen.svg)](http://www.wtfpl.net/about/)
![WIP](https://img.shields.io/badge/WIP-red)

**WIP** single-file and pure Lua bindings for [Flecs](https://github.com/SanderMertens/flecs/) using the LuaJIT FFI. The
aim is to implement at least all the basic Flecs' features that allow making a game. Unsafer operations are not
implemented yet. Based on [https://github.com/flecs-hub/flecs-lua/]()

## How to build and run the tests

- Do a standard CMake build. This will automagically run `tools/preprocess.sh or tools/preprocess.ps1` having the project root as the
current working directory every time the Lua source or the Flecs header change. The script generates the FFI cdefs for
Flecs from `vendor/flecs/flecs.h`, appends `src/ecs.lua` and generates the final Lua file, ready to use, in
`distr/ecs.lua`. In W\*ndows, you need PowerShell and `cl.exe` available in your `PATH`, for example by executing it in
a "Command Prompt for VS 20xx," available from the start menu.
- Download, compile and install LuaJIT following the directions in the [official webpage](https://luajit.org/), or just
install it from your distro's package repositories, but I haven't tried this.
- **For W\*ndows only**: after compiling LuaJIT, copy or symlink `lua51.dll`, `lua51.exp`, `lua51.lib` and `lua51.pdb`
found at `luajit/src` after the build to this project's directory `vendor/luajit/lib`. Copy `lua.h`, `luaconf.h`,
`lualib.h` and `lauxlib.h` to `vendor/luajit/include/luajit-2.1`. Blame W*ndows for not having a standard way to
install development libraries.
- When running the test program, make sure the `distr/ecs.lua` and `src/tests.lua` files are available in the current
working directory. CMake takes care of this automatically (copies the files to the binary directory).

## Embedding into another app

On the Lua side, you only need `distr/ecs.lua`, the standard Lua libraries, and the FFI, BitOp and string buffer
LuaJIT libraries, all included with the latest LuaJIT commits. On the C side, your app needs to export Flecs' symbols,
which *nix compilers do by default. For W\*ndows, you need to comment out the second line `#define flecs_STATIC` in
`flecs.h` and define `flecs_EXPORTS`, probably unless you use Flecs as a DLL, but I haven't tested this. Also, it's
important to define `FLECS_SOFT_ASSERT` to make Flecs do some checks and allow for recoverable errors, specially if you
run third-party code, like game mods! Finally, just run `ecs.lua` however you want. It returns the entire module as a
table.

## Configuration

When running `tools/preprocess.sh`, any arguments you pass will be forwarded to `cc`. Therefore, you are able to
customize Flecs' macros. Notably, you can customize `ecs_float_t` and `ecs_ftime_t` to use double precision, for
example with `./tools/preprocess.sh -Decs_ftime_t=double -Decs_float_t=double`. You MUST make sure to preprocess and
compile `flecs.c` with the same definitions, otherwise chaos will ensue!

## Caveats

This library uses `ffi.C.free()` to release the memory allocated and returned by Flecs, so don't pass custom memory
management functions to Flecs (for example, by using `ecs_os_set_api()`)! This unsafe operation is not yet implemented.

## TODO
- Ensure the library is more or less safe to expose to third-party code, like mods.
- Allow for custom `ecs_os_api_t`.
