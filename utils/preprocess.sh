#!/bin/bash
flecs_header='./vendor/flecs/flecs.h'
lua_source='./src/ecs.lua'
output_directory='./distr'

for f in $flecs_header $lua_source $output_directory; do
  [ -e "$f" ] || {
    echo "Missing $f, make sure to execute this script from the project root.";
    exit 1;
  }
done

{
  echo 'require('"'ffi'"').cdef[['
  # HACK: LuaJIT doesn't recognize the `FILE` C type, used in the OS API. So just turn `FILE*` into `void*`.
  sed '/#include/d' "$flecs_header" | cc -E -P "$@" - | sed '/#pragma/d; /^$/d; /typedef char bool/d; s/\<FILE\>/void/g'
  echo $']]\n'
  cat $lua_source
} > $output_directory/ecs.lua
