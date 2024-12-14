cmake_minimum_required(VERSION 3.1)
project(flecs_luajit C)

set(CMAKE_C_STANDARD 17)

add_executable(flecs_luajit src/main.c libs/flecs/flecs.c)

add_definitions(-Dflecs_EXPORTS -DFLECS_SOFT_ASSERT)

target_include_directories(flecs_luajit PRIVATE include libs/flecs)
if (WIN32)
  target_include_directories(flecs_luajit PRIVATE libs/luajit)
  target_link_directories(flecs_luajit PRIVATE libs/luajit)
  target_link_libraries(flecs_luajit PRIVATE lua51)
else()
  target_link_libraries(flecs_luajit PRIVATE luajit-5.1)
endif ()

set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT flecs_luajit)
