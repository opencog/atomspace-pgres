#  CXXTEST_FOUND   - system has cxxtest
#  CXXTEST_GEN - the binary used to generate the tests

# Copyright (c) 2008, OpenCog.org (http://opencog.org)
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

# Find path to the cxxtestgen.py script (NB: this stuff should move to FindCXXTEST.cmake)
# CXXTEST_BIN_DIR enviroment variable must have been defined already

FIND_PACKAGE(PythonInterp REQUIRED)
FIND_PATH(CXXTEST_BIN_DIR cxxtestgen.py
    $ENV{CXXTEST_BIN_DIR}
    /usr/bin
    /usr/local/bin
    DOC "Where is cxxtest located?"
)
IF(CXXTEST_BIN_DIR)
	SET(CXXTEST_FOUND 1)
	SET(CXXTEST_GEN "${CXXTEST_BIN_DIR}/cxxtestgen.py")
ELSE(CXXTEST_BIN_DIR)
	SET(CXXTEST_FOUND 0)
ENDIF(CXXTEST_BIN_DIR)

# abort if required the results.
IF(NOT CXXTEST_FOUND)
	SET(CXXTEST_BIN_DIR_MESSAGE "Cxxtest was not found. Make sure CXXTEST_BIN_DIR is set.")
	IF(NOT Cxxtest_FIND_QUIETLY)
		MESSAGE(STATUS "${CXXTEST_BIN_DIR_MESSAGE}")
	ELSE(NOT Cxxtest_FIND_QUIETLY)
		IF(Cxxtest_FIND_REQUIRED)
			MESSAGE(FATAL_ERROR "${CXXTEST_BIN_DIR_MESSAGE}")
		ENDIF(Cxxtest_FIND_REQUIRED)
	ENDIF(NOT Cxxtest_FIND_QUIETLY)
ENDIF(NOT CXXTEST_FOUND)
