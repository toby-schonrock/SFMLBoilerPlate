# Generated by CMake

if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" LESS 2.6)
   message(FATAL_ERROR "CMake >= 2.6.0 required")
endif()
cmake_policy(PUSH)
cmake_policy(VERSION 2.6...3.20)
#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

if(CMAKE_VERSION VERSION_LESS 3.0.0)
  message(FATAL_ERROR "This file relies on consumers using CMake 3.0.0 or greater.")
endif()

# Protect against multiple inclusion, which would fail when already imported targets are added once more.
set(_targetsDefined)
set(_targetsNotDefined)
set(_expectedTargets)
foreach(_expectedTarget sfml-system sfml-main sfml-window OpenGL sfml-graphics Freetype)
  list(APPEND _expectedTargets ${_expectedTarget})
  if(NOT TARGET ${_expectedTarget})
    list(APPEND _targetsNotDefined ${_expectedTarget})
  endif()
  if(TARGET ${_expectedTarget})
    list(APPEND _targetsDefined ${_expectedTarget})
  endif()
endforeach()
if("${_targetsDefined}" STREQUAL "${_expectedTargets}")
  unset(_targetsDefined)
  unset(_targetsNotDefined)
  unset(_expectedTargets)
  set(CMAKE_IMPORT_FILE_VERSION)
  cmake_policy(POP)
  return()
endif()
if(NOT "${_targetsDefined}" STREQUAL "")
  message(FATAL_ERROR "Some (but not all) targets in this export set were already defined.\nTargets Defined: ${_targetsDefined}\nTargets not yet defined: ${_targetsNotDefined}\n")
endif()
unset(_targetsDefined)
unset(_targetsNotDefined)
unset(_expectedTargets)


# Create imported target sfml-system
add_library(sfml-system STATIC IMPORTED)

set_target_properties(sfml-system PROPERTIES
  INTERFACE_COMPILE_DEFINITIONS "SFML_STATIC"
  INTERFACE_INCLUDE_DIRECTORIES "C:/msys64/home/tobia/dev/physicssim/ext/SFML/include"
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:winmm>"
)

# Create imported target sfml-main
add_library(sfml-main STATIC IMPORTED)

set_target_properties(sfml-main PROPERTIES
  INTERFACE_COMPILE_DEFINITIONS "SFML_STATIC"
  INTERFACE_INCLUDE_DIRECTORIES "C:/msys64/home/tobia/dev/physicssim/ext/SFML/include"
)

# Create imported target sfml-window
add_library(sfml-window STATIC IMPORTED)

set_target_properties(sfml-window PROPERTIES
  INTERFACE_COMPILE_DEFINITIONS "SFML_STATIC"
  INTERFACE_INCLUDE_DIRECTORIES "C:/msys64/home/tobia/dev/physicssim/ext/SFML/include"
  INTERFACE_LINK_LIBRARIES "sfml-system;\$<LINK_ONLY:OpenGL>;\$<LINK_ONLY:winmm>;\$<LINK_ONLY:gdi32>"
)

# Create imported target OpenGL
add_library(OpenGL INTERFACE IMPORTED)

set_target_properties(OpenGL PROPERTIES
  INTERFACE_LINK_LIBRARIES "opengl32;glu32"
)

# Create imported target sfml-graphics
add_library(sfml-graphics STATIC IMPORTED)

set_target_properties(sfml-graphics PROPERTIES
  INTERFACE_COMPILE_DEFINITIONS "SFML_STATIC"
  INTERFACE_INCLUDE_DIRECTORIES "C:/msys64/home/tobia/dev/physicssim/ext/SFML/include"
  INTERFACE_LINK_LIBRARIES "sfml-window;\$<LINK_ONLY:OpenGL>;\$<LINK_ONLY:Freetype>"
)

# Create imported target Freetype
add_library(Freetype INTERFACE IMPORTED)

set_target_properties(Freetype PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "C:/msys64/home/tobia/dev/physicssim/ext/SFML/extlibs/headers/freetype2"
  INTERFACE_LINK_LIBRARIES "C:/msys64/home/tobia/dev/physicssim/ext/SFML/extlibs/libs-mingw/x64/libfreetype.a"
)

# Import target "sfml-system" for configuration ""
set_property(TARGET sfml-system APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(sfml-system PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "CXX"
  IMPORTED_LOCATION_NOCONFIG "C:/msys64/home/tobia/dev/physicssim/ext/SFML/lib/libsfml-system.a"
  )

# Import target "sfml-main" for configuration ""
set_property(TARGET sfml-main APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(sfml-main PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "CXX"
  IMPORTED_LOCATION_NOCONFIG "C:/msys64/home/tobia/dev/physicssim/ext/SFML/lib/libsfml-main.a"
  )

# Import target "sfml-window" for configuration ""
set_property(TARGET sfml-window APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(sfml-window PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "CXX"
  IMPORTED_LOCATION_NOCONFIG "C:/msys64/home/tobia/dev/physicssim/ext/SFML/lib/libsfml-window.a"
  )

# Import target "sfml-graphics" for configuration ""
set_property(TARGET sfml-graphics APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(sfml-graphics PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "CXX"
  IMPORTED_LOCATION_NOCONFIG "C:/msys64/home/tobia/dev/physicssim/ext/SFML/lib/libsfml-graphics.a"
  )

# This file does not depend on other imported targets which have
# been exported from the same project but in a separate export set.

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
cmake_policy(POP)
