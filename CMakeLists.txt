cmake_minimum_required(VERSION 3.1)
project(flecs_luajit C)

set(CMAKE_C_STANDARD 17)

add_executable(flecs_luajit src/main.c libs/flecs/flecs.c)

target_include_directories(flecs_luajit PRIVATE include libs/flecs)

target_link_libraries(flecs_luajit PRIVATE luajit-5.1)
