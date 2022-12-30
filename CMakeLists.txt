cmake_minimum_required(VERSION 3.15)
project(SoftBody)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if (MSVC)
  set(PROJECT_COMPILE_OPTIONS /Wall /analyze)
  string(APPEND CMAKE_CXX_FLAGS_DEBUG          " /fsanitize=address")
  string(APPEND CMAKE_CXX_FLAGS_RELWITHDEBINFO " /fsanitize=address")
else()
  set(PROJECT_COMPILE_OPTIONS -Wall -Wextra -Wpedantic -Wshadow -Wextra-semi
    -Wmissing-noreturn -Wconversion -Wsign-conversion)
  string(APPEND CMAKE_CXX_FLAGS_DEBUG          " -fsanitize=address,undefined,leak")
  string(APPEND CMAKE_CXX_FLAGS_RELWITHDEBINFO " -fsanitize=address,undefined,leak")
endif()

if (WIN32)
  # combine everthing into one binary on windows
  set(BUILD_SHARED_LIBS OFF)
  # -static removes dependencies on libgcc.dll, libstdc++.dll and winthread.dll on windows
  set(PROJECT_STATIC_OPTIONS "-static")
else()
  # on linux there is not much point being statically linked
  set(PROJECT_STATIC_OPTIONS "")
endif()

option (FORCE_COLORED_OUTPUT "Always produce ANSI-colored output (GNU/Clang only)." TRUE)
if (${FORCE_COLORED_OUTPUT})
  if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    add_compile_options (-fdiagnostics-color=always)
  elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    add_compile_options (-fcolor-diagnostics)
  endif ()
endif ()

set(SFML_BUILD_AUDIO OFF)
set(SFML_BUILD_NETWORK OFF)
add_subdirectory(ext/SFML)

add_library(sfml INTERFACE)
target_include_directories(sfml INTERFACE ext/SFML/include)
target_link_libraries(sfml INTERFACE sfml-graphics sfml-window sfml-system Threads::Threads)

# imgui doesn't do cmake and doesn't need compiling
add_library(imgui INTERFACE)
target_include_directories(imgui INTERFACE ext/imgui)

set(IMGUI_DIR ${CMAKE_CURRENT_SOURCE_DIR}/ext/imgui)
set(IMGUI_SFML_FIND_SFML OFF)
add_subdirectory(ext/imgui-sfml)

add_library(implot ext/implot/implot.cpp ext/implot/implot_items.cpp)
target_include_directories(implot INTERFACE ext/implot)
target_link_libraries(implot PRIVATE imgui)

add_library(imgui-sfml INTERFACE)
target_include_directories(imgui-sfml INTERFACE ext/imgui-sfml)
target_link_libraries(imgui-sfml INTERFACE ImGui-SFML sfml imgui implot)
target_link_libraries(imgui-sfml INTERFACE ImGui-SFML sfml imgui)


find_package(Threads REQUIRED)
add_executable(SFMLProj app/main.cpp)
target_include_directories(SFMLProj PRIVATE include)
target_link_libraries(SFMLProj PRIVATE imgui-sfml ${PROJECT_STATIC_OPTIONS})
target_compile_options(SFMLProj PRIVATE ${PROJECT_COMPILE_OPTIONS})