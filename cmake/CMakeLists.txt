
# CMake boilerplate that allows users to do
#    find_package(AtomspacePgres REQUIRED 5.1.0)
# and have it work.

include(CMakePackageConfigHelpers)

set(ConfigPackageLocation lib/cmake/AtomSpacePgres)

install(EXPORT AtomSpacePgresTargets
	FILE AtomSpacePgresTargets.cmake
	DESTINATION ${ConfigPackageLocation}
)

SET(SEMANTIC_VERSION 5.1.0)

configure_package_config_file(AtomSpacePgresConfig.cmake.in
	${CMAKE_CURRENT_BINARY_DIR}/AtomSpacePgresConfig.cmake
	INSTALL_DESTINATION ${ConfigPackageLocation}
	PATH_VARS CMAKE_INSTALL_PREFIX
)

write_basic_package_version_file(
	"${CMAKE_CURRENT_BINARY_DIR}/AtomSpacePgresConfigVersion.cmake"
	VERSION ${SEMANTIC_VERSION}
	COMPATIBILITY SameMajorVersion
)

INSTALL(FILES
	${CMAKE_CURRENT_BINARY_DIR}/AtomSpacePgresConfigVersion.cmake
	${CMAKE_CURRENT_BINARY_DIR}/AtomSpacePgresConfig.cmake
	DESTINATION ${ConfigPackageLocation}
)

# -----------------------------------------------------------
