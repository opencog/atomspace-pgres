# - Find LUABIND includes and library
#
# This module defines
#  LUABIND_INCLUDE_DIR
#  LUABIND_LIBRARIES, the libraries to link against to use LUABIND.
#  LUABIND_LIB_DIR, the location of the libraries
#  LUABIND_FOUND, If false, do not try to use LUABIND
#
# Copyright © 2007, Matt Williams
# Changes for LUABIND detection by Garvek, 2008
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

IF (LUABIND_LIBRARIES AND LUABIND_INCLUDE_DIR)
   SET(LUABIND_FIND_QUIETLY TRUE) # Already in cache, be silent
ENDIF (LUABIND_LIBRARIES AND LUABIND_INCLUDE_DIR)


FIND_PATH(LUABIND_INCLUDE_DIR luabind/luabind.hpp)

FIND_LIBRARY(LUABIND_LIBRARIES NAMES luabind)

IF( LUABIND_INCLUDE_DIR AND LUABIND_LIBRARIES)
   SET(LUABIND_FOUND TRUE)
   INCLUDE(CheckLibraryExists)
   CHECK_LIBRARY_EXISTS(${LUABIND_LIBRARIES} open "" LUABIND_NEED_PREFIX)
ELSE(LUABIND_INCLUDE_DIR AND LUABIND_LIBRARIES)
   SET(LUABIND_FOUND FALSE)
ENDIF( LUABIND_INCLUDE_DIR AND LUABIND_LIBRARIES)

IF(LUABIND_FOUND)
  IF (NOT LUABIND_FIND_QUIETLY)
    MESSAGE(STATUS "Found LUABIND library: ${LUABIND_LIBRARIES}")
    MESSAGE(STATUS "Found LUABIND headers: ${LUABIND_INCLUDE_DIR}")
  ENDIF (NOT LUABIND_FIND_QUIETLY)
ELSE(LUABIND_FOUND)
  IF(LUABIND_FIND_REQUIRED)
    MESSAGE(FATAL_ERROR "Could NOT find LUABIND")
  ENDIF(LUABIND_FIND_REQUIRED)
ENDIF(LUABIND_FOUND)

MARK_AS_ADVANCED(LUABIND_INCLUDE_DIR LUABIND_LIBRARIES)
