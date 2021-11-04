# Locate Lua library
# This module defines
#  LUAU_FOUND, if false, do not try to link to Lua
#  LUA_LIBRARIES
#  LUA_INCLUDE_DIR, where to find lua.h
#
# Note that the expected include convention is
#  #include "lua.h"
# and not
#  #include <lua/lua.h>
# This is because, the lua location is not standardized and may exist
# in locations other than lua/

#=============================================================================
# Copyright 2007-2009 Kitware, Inc.
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of CMake, substitute the full
#  License text for the above reference.)

find_path(LUAH_INCLUDE_DIR lua.h
  HINTS
    ENV LUA_DIR
  PATH_SUFFIXES VM/include
)

find_path(LUAU_INCLUDE_DIR Luau/Compiler.h
  HINTS
    ENV LUA_DIR
  PATH_SUFFIXES Compiler/include
)

find_path(LUAU_AST_INCLUDE_DIR Luau/ParseOptions.h
  HINTS
    ENV LUA_DIR
  PATH_SUFFIXES Ast/include
)

find_library(LUA_COMPILER_LIBRARY
  NAMES Luau.Compiler
  HINTS
    ENV LUA_DIR
  PATH_SUFFIXES cmake
)

find_library(LUA_VM_LIBRARY
  NAMES Luau.VM
  HINTS
    ENV LUA_DIR
  PATH_SUFFIXES cmake
)

find_library(LUA_AST_LIBRARY
  NAMES Luau.Ast
  HINTS
    ENV LUA_DIR
  PATH_SUFFIXES cmake
)

if(LUA_COMPILER_LIBRARY AND LUA_VM_LIBRARY AND LUA_AST_LIBRARY)
    set( LUA_LIBRARIES "${LUA_COMPILER_LIBRARY} ${LUA_VM_LIBRARY} ${LUA_AST_LIBRARY}" CACHE STRING "Lua Libraries")
endif()

if(LUAH_INCLUDE_DIR AND LUAH_INCLUDE_DIR AND LUAU_AST_INCLUDE_DIR)
    set( LUA_INCLUDE_DIR "${LUAH_INCLUDE_DIR} ${LUAU_INCLUDE_DIR}" CACHE STRING "Lua Include dirs")
endif()

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LUA_FOUND to TRUE if
# all listed variables are TRUE
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Luau
                                  REQUIRED_VARS LUA_LIBRARIES LUA_INCLUDE_DIR)

mark_as_advanced(LUA_INCLUDE_DIR LUA_LIBRARIES)

