
# This declaration must happen before subdirectory traversal.
DECLARE_GUILE_CONFIG_TARGET(SCM_CONFIG "opencog pgres-config" "OPENCOG_TEST")

ADD_SUBDIRECTORY (persist)

WRITE_GUILE_CONFIG(${GUILE_BIN_DIR}/opencog/pgres-config.scm SCM_CONFIG TRUE)
WRITE_GUILE_CONFIG(${GUILE_BIN_DIR}/opencog/pgres-config-installable.scm SCM_CONFIG FALSE)

INSTALL(FILES ${GUILE_BIN_DIR}/opencog/pgres-config-installable.scm DESTINATION ${GUILE_SITE_DIR}/opencog RENAME pgres-config.scm)

