# Generate the atom types
OPENCOG_GEN_CXX_ATOMTYPES(atom_types.script
	atom_types.h
	atom_types.definitions
	atom_types.inheritance)

OPENCOG_GEN_SCM_ATOMTYPES(atom_types.script persist_sql_types.scm)
OPENCOG_GEN_PYTHON_ATOMTYPES(atom_types.script persist_sql_types.pyx)

ADD_CUSTOM_TARGET(persist_sql_atom_types
	DEPENDS atom_types.h persist_sql_types.scm persist_sql_types.pyx)

# Build the shared library
ADD_LIBRARY (persist-sql-types SHARED
	atom_types_init.cc
)

# The atom_types.h file is written to the build directory
TARGET_INCLUDE_DIRECTORIES(persist-sql-types PRIVATE ${CMAKE_BINARY_DIR})

TARGET_LINK_LIBRARIES(persist-sql-types
	${ATOMSPACE_STORAGE_LIBRARIES}
	${ATOMSPACE_LIBRARIES}
)

ADD_DEPENDENCIES(persist-sql-types persist_sql_atom_types)

# Install targets
INSTALL (TARGETS persist-sql-types EXPORT AtomSpacePgresTargets
	DESTINATION "lib${LIB_DIR_SUFFIX}/opencog"
)

INSTALL (FILES
	${CMAKE_CURRENT_BINARY_DIR}/atom_types.h
	DESTINATION "include/opencog/persist/sql/types"
)

ADD_GUILE_MODULE (FILES
	${CMAKE_CURRENT_BINARY_DIR}/persist_sql_types.scm
	MODULE_DESTINATION "${GUILE_SITE_DIR}/opencog/persist/sql/types"
	DEPENDS persist_sql_atom_types
)

ADD_GUILE_EXTENSION(SCM_CONFIG persist-sql-types "opencog-ext-path-persist-sql-types")