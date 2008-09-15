# - Try to find the OPENCOG library; Once done this will define
#
# OPENCOG_FOUND        - system has the OPENCOG library
# OPENCOG_INCLUDE_DIRS - the OPENCOG include directory
# OPENCOG_LIBRARIES    - The libraries needed to use OPENCOG

# Copyright (c) 2008, OPENCOG.org (http://opencog.org)
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

# first, check opencog dependencies
IF (WIN32)
	FIND_PACKAGE(PThreads REQUIRED)
	FIND_PACKAGE(STLPort REQUIRED)
	INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/include/win32" ${PTHREADS_INCLUDE_DIR} ${STLPORT_INCLUDE_DIR})
	LINK_LIBRARIES(${PTHREADS_LIBRARY} ${STLPORT_LIBRARIES})
	ADD_DEFINITIONS(-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE)
ELSE (WIN32)
	LINK_LIBRARIES(pthread)
ENDIF (WIN32)

FIND_PACKAGE(EXPAT REQUIRED)
FIND_PACKAGE(CSockets REQUIRED)
FIND_PACKAGE(OpenSSL REQUIRED)
FIND_PACKAGE(Boost REQUIRED)

FIND_PACKAGE(IODBC QUIET)
IF (IODBC_FOUND)
	ADD_DEFINITIONS(-DHAVE_SQL_STORAGE)
	SET(ODBC_INCLUDE_DIRS ${IODBC_INCLUDE_DIRS})
	SET(ODBC_LIBRARIES ${IODBC_LIBRARIES})
ELSE (IODBC_FOUND)
	FIND_PACKAGE(UnixODBC QUIET)
	IF (UnixODBC_FOUND)
		ADD_DEFINITIONS(-DHAVE_SQL_STORAGE)
		SET(ODBC_INCLUDE_DIRS ${UnixODBC_INCLUDE_DIRS})
		SET(ODBC_LIBRARIES ${UnixODBC_LIBRARIES})
    ELSE (UnixODBC_FOUND)
        SET(ODBC_DIR_MESSAGE "Neither IODBC or UnixODBC was found. Make sure [Unix|I]ODBC_LIBRARIES and [Unix|I]ODBC_INCLUDE_DIRS are set.")
        MESSAGE(STATUS "${ODBC_DIR_MESSAGE}")
	ENDIF (UnixODBC_FOUND)
ENDIF (IODBC_FOUND)

FIND_PACKAGE(Guile)
IF (GUILE_FOUND)
	ADD_DEFINITIONS(-DHAVE_GUILE)
ENDIF (GUILE_FOUND)

# FIND_PACKAGE(LibMemCached)
# Enable the use of SQL storage, if either iodbc of unixodbc is found.
# Caution: this can also increase RAM usage significantly!

# At this time,. there is no reason to build with memcached for 
# any "normal" use, so just stub it out.
# IF (LIBMEMCACHED_FOUND)
#	ADD_DEFINITIONS(-DHAVE_LIBMEMCACHED)
# ENDIF (LIBMEMCACHED_FOUND)


# then process the opencog library itself

FIND_PATH(OPENCOG_INCLUDE_DIR opencog/atomspace/AtomSpace.h PATHS ${OPENCOG_HOME}/include $ENV{OPENCOG_HOME}/include /opt/opencog/include)
FIND_LIBRARY(OPENCOG_SERVER_LIBRARY NAMES server PATHS ${OPENCOG_HOME}/lib/opencog $ENV{OPENCOG_HOME}/lib/opencog /opt/opencog/lib /usr/local/lib/opencog /usr/lib/opencog)
FIND_LIBRARY(OPENCOG_ATOMSPACE_LIBRARY NAMES atomspace PATHS ${OPENCOG_HOME}/lib/opencog $ENV{OPENCOG_HOME}/lib/opencog /opt/opencog/lib /usr/local/lib/opencog /usr/lib/opencog)
IF (OPENCOG_INCLUDE_DIR AND OPENCOG_SERVER_LIBRARY AND OPENCOG_ATOMSPACE_LIBRARY)
	SET (OPENCOG_FOUND 1)
	SET (OPENCOG_INCLUDE_DIRS ${OPENCOG_INCLUDE_DIR})
	SET (OPENCOG_LIBRARIES
		${OPENCOG_SERVER_LIBRARY}
		${OPENCOG_ATOMSPACE_LIBRARY}
		${ODBC_LIBRARIES}
		${CSOCKETS_LIBRARIES}
		${OPENSSL_LIBRARIES}
		${EXPAT_LIBRARIES}
	)
    MARK_AS_ADVANCED(OPENCOG_HOME)
ELSE (OPENCOG_INCLUDE_DIR AND OPENCOG_SERVER_LIBRARY AND OPENCOG_ATOMSPACE_LIBRARY)
	SET (OPENCOG_FOUND 0)
    SET (OPENCOG_HOME "OPENCOG_HOME-NOTFOUND" CACHE PATH "Opencog's base dir")
    #SET (OPENCOG_INCLUDE_DIRS "OPENCOG_INCLUDE_DIRS-NOTFOUND" CACHE PATH "The directory with OpenCog's header files")
    #SET (OPENCOG_LIBRARIES "OPENCOG_LIBRARIES-NOTFOUND" CACHE FILEPATH "The list of OpenCog libraries")
ENDIF (OPENCOG_INCLUDE_DIR AND OPENCOG_SERVER_LIBRARY AND OPENCOG_ATOMSPACE_LIBRARY)

MARK_AS_ADVANCED (
	OPENCOG_INCLUDE_DIR
    OPENCOG_SERVER_LIBRARY
    OPENCOG_ATOMSPACE_LIBRARY
)

IF (NOT OPENCOG_FOUND)
	SET (OPENCOG_DIR_MESSAGE "OPENCOG was not found. Either set the \"OPENCOG_INCLUDE_DIR\" and \"OPENCOG_LIBRARIES\" cmake variables or set the \"OPENCOG_HOME\" variable to your opencog's base dir and rerun cmake.")
	IF (NOT OPENCOG_FIND_QUIETLY)
		IF (OPENCOG_FIND_REQUIRED)
			MESSAGE (FATAL_ERROR "[FATAL ERROR]: ${OPENCOG_DIR_MESSAGE}")
        ELSE (NOT OPENCOG_FIND_REQUIRED)
            MESSAGE (STATUS "[ERROR] ${OPENCOG_DIR_MESSAGE}")
		ENDIF (OPENCOG_FIND_REQUIRED)
	ENDIF (NOT OPENCOG_FIND_QUIETLY)
ENDIF (NOT OPENCOG_FOUND)
