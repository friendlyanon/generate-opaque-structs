cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    generate-opaque-structs
    VERSION 0.0.0
    DESCRIPTION "Short description"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES C
)

include(cmake/project-is-top-level.cmake)
include(cmake/functions.cmake)

# ---- Declare library ----

set(os_Windows nt)
set(os_Linux posix)
set(os_Darwin macos)
set(os "${os_${CMAKE_SYSTEM_NAME}}")

add_library(
    generate-opaque-structs_lib OBJECT
    "source/${os}.c"
)

if(WIN32)
  target_compile_definitions(
      generate-opaque-structs_lib PRIVATE
      WIN32_LEAN_AND_MEAN
  )
  set(CMAKE_REQUIRED_DEFINITIONS -DWIN32_LEAN_AND_MEAN)
endif()

generate_opaque_structs(
    INPUT "source/structs/${os}.h"
    STRUCTS example
    TEMPLATE source/structs.h.in
    OUTPUT opaque/structs.h
)

target_include_directories(
    generate-opaque-structs_lib
    PUBLIC "${PROJECT_BINARY_DIR}/opaque"
    PRIVATE source/structs
)

target_compile_features(generate-opaque-structs_lib PUBLIC c_std_11)

# ---- Declare executable ----

add_executable(generate-opaque-structs_exe source/main.c)
add_executable(generate-opaque-structs::exe ALIAS generate-opaque-structs_exe)

set_target_properties(
    generate-opaque-structs_exe PROPERTIES
    OUTPUT_NAME generate-opaque-structs
    EXPORT_NAME exe
)

target_compile_features(generate-opaque-structs_exe PRIVATE c_std_11)

target_link_libraries(generate-opaque-structs_exe PRIVATE generate-opaque-structs_lib)

# ---- Run exe ----

add_custom_target(
    run-exe
    COMMAND generate-opaque-structs_exe
    VERBATIM
)
add_dependencies(run-exe generate-opaque-structs_exe)
