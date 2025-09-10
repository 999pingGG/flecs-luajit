cmake_minimum_required(VERSION 3.10)
project(flecs_luajit C)

set(CMAKE_C_STANDARD 17)

add_executable(flecs_luajit src/main.c libs/flecs/flecs.c)

add_definitions(-Dflecs_EXPORTS -DFLECS_SOFT_ASSERT)

set_target_properties(flecs_luajit PROPERTIES ENABLE_EXPORTS 1)

target_include_directories(flecs_luajit PRIVATE include libs/flecs)
if(WIN32)
  target_include_directories(flecs_luajit PRIVATE libs/luajit)
  target_link_directories(flecs_luajit PRIVATE libs/luajit)
  target_link_libraries(flecs_luajit PRIVATE lua51)
else()
  target_link_libraries(flecs_luajit PRIVATE luajit-5.1)
endif()

set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT flecs_luajit)

set(PREPROCESS_DEPS
  ${CMAKE_SOURCE_DIR}/libs/flecs/flecs.h
  ${CMAKE_SOURCE_DIR}/src/ecs.lua
  ${CMAKE_SOURCE_DIR}/src/tests.lua)

if(WIN32)
  set(PREPROCESS_SCRIPT .\\utils\\preprocess.bat)
else()
  set(PREPROCESS_SCRIPT ./utils/preprocess.sh)
endif()

add_custom_command(
  COMMENT "Regenerating distr/ecs.lua"
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/preprocess.stamp
  COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_SOURCE_DIR} ${PREPROCESS_SCRIPT}
  COMMAND ${CMAKE_COMMAND} -E touch ${CMAKE_CURRENT_BINARY_DIR}/preprocess.stamp
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/distr/ecs.lua ${CMAKE_CURRENT_BINARY_DIR}
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/src/tests.lua ${CMAKE_CURRENT_BINARY_DIR}
  DEPENDS ${PREPROCESS_DEPS})

add_custom_target(regenerate_distribution_script_and_copy_scripts
  DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/preprocess.stamp
)

add_dependencies(flecs_luajit regenerate_distribution_script_and_copy_scripts)
