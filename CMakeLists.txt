cmake_minimum_required(VERSION 3.10)
project(flecs_luajit C)

set(CMAKE_C_STANDARD 17)

add_executable(flecs_luajit src/main.c vendor/flecs/flecs.c)

add_definitions(-Dflecs_EXPORTS -DFLECS_SOFT_ASSERT)

set_target_properties(flecs_luajit PROPERTIES ENABLE_EXPORTS 1)

target_include_directories(flecs_luajit PRIVATE include vendor/flecs)
if(WIN32)
  target_include_directories(flecs_luajit PRIVATE vendor/luajit/include)
  target_link_directories(flecs_luajit PRIVATE vendor/luajit/lib)
  target_link_libraries(flecs_luajit PRIVATE lua51.lib)
else()
  target_link_libraries(flecs_luajit PRIVATE luajit-5.1)
endif()

set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT flecs_luajit)

set(PREPROCESS_DEPS
  ${CMAKE_SOURCE_DIR}/tools/preprocess.ps1
  ${CMAKE_SOURCE_DIR}/tools/preprocess.sh
  ${CMAKE_SOURCE_DIR}/vendor/flecs/flecs.h
  ${CMAKE_SOURCE_DIR}/src/ecs.lua
  ${CMAKE_SOURCE_DIR}/src/tests.lua)

if(WIN32)
  set(PREPROCESS_COMMAND powershell -NoProfile -ExecutionPolicy Bypass -File .\\tools\\preprocess.ps1)
else()
  set(PREPROCESS_COMMAND ./tools/preprocess.sh)
endif()

add_custom_command(
  COMMENT "Regenerating distr/ecs.lua"
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/preprocess.stamp
  COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_SOURCE_DIR} ${PREPROCESS_COMMAND}
  COMMAND ${CMAKE_COMMAND} -E touch ${CMAKE_CURRENT_BINARY_DIR}/preprocess.stamp
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/distr/ecs.lua ${CMAKE_CURRENT_BINARY_DIR}
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/src/tests.lua ${CMAKE_CURRENT_BINARY_DIR}
  DEPENDS ${PREPROCESS_DEPS})

add_custom_target(regenerate_distribution_script_and_copy_scripts
  DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/preprocess.stamp
)

add_dependencies(flecs_luajit regenerate_distribution_script_and_copy_scripts)

add_custom_command(TARGET flecs_luajit POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            "${CMAKE_CURRENT_SOURCE_DIR}/vendor/luajit/lib/lua51.dll"
            "$<TARGET_FILE_DIR:flecs_luajit>"
        VERBATIM)
