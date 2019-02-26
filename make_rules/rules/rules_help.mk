help:
	@echo Base names:
	@echo "    NAME                        - Project name                     "
	@echo "    BUILDPATH                   - Path to build directory          "
	@echo "    BUILD_CONFIG                - 'execute', 'library' or          "
	@echo "                               'multibuild'"
	@echo "    BUILD_TYPE                  - 'release' or 'debug'             "
	@echo "    SOURCE_LIST                 - "
	@echo "    SOURCE_PATH_LIST            - ?"
	@echo "    INSTALL_PATH                - ?"
	@echo
	@echo Logging:
	@echo "    LOG_VARS                    - ? 'true' or 'false'              "
	@echo "    LOG_RULES                   - ? 'true' or 'false'              "
	@echo "    LOG_COMMANDS                - ? 'true' or 'false'              "
	@echo "    LOG_ALL                     - ? 'true' or 'false'              "
	@echo
	@echo Base language properties:
	@echo "    LANG                        - 'c', 'cpp'                       "
	@echo
	@echo C language properties:
	@echo "    CMP_TYPE                    - 'gcc', 'clang' or 'cl.exe'       "
	@echo "    INCLUDE_PATH_LIST           - ?"
	@echo "    CC_FLAG_LIST                - ?"
	@echo "    C_STANDART                  - ?"
	@echo "    INSTALL_HEADER_PATH         - ?"
	@echo "    INSTALL_HEADER_LIST         - ?"
	@echo
	@echo C++ language properties:
	@echo "    CMP_TYPE                    - 'gcc', 'clang' or 'cl.exe'       "
	@echo "    INCLUDE_PATH_LIST           - ?"
	@echo "    CXX_FLAG_LIST               - ?"
	@echo "    CXX_STANDART                - ?"
	@echo "    INSTALL_HEADER_PATH         - ?"
	@echo "    INSTALL_HEADER_LIST         - ?"
	@echo
	@echo Multibuild options:
	@echo "    PROJECT_LIST                - ?"
