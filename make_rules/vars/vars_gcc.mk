CXX_BASE_FLAGS =

ifndef CMP
  CMP = g++
#   $(warning CMP not defined)
#   $(warning CMP = $(CMP))
endif

ifndef INCLUDE_PATHS
  $(warning INCLUDE_PATHS not defined)
else
  CXX_INCLUDE = $(foreach directory,$(INCLUDE_PATHS),$(addprefix -I,$(directory)))
#   $(warning CXX_INCLUDE = $(CXX_INCLUDE))
endif

CXX_FLAGS_DEP = -MMD -MP
CXX_FLAGS_WARN = -pedantic -Wredundant-decls -Wcast-align -Wmissing-declarations -Wmissing-include-dirs -Wswitch-enum -Wswitch-default -Wextra -Wall -Winvalid-pch -Wredundant-decls -Wformat=2 -Wmissing-format-attribute -Wformat-nonliteral

ifndef CXX_FLAGS_DEBUG
  CXX_FLAGS_DEBUG = -g -O0 $(CXX_FLAGS_WARN)
#   $(warning CXX_FLAGS_DEBUG not defined)
#   $(warning CXX_FLAGS_DEBUG = $(CXX_FLAGS_DEBUG))
endif # CXX_FLAGS_DEBUG

ifndef CXX_FLAGS_RELEASE
  CXX_FLAGS_RELEASE = -O2 $(CXX_FLAGS_WARN) -Werror
#   $(warning CXX_FLAGS_RELEASE not defined)
#   $(warning CXX_FLAGS_RELEASE = $(CXX_FLAGS_RELEASE))
endif # CXX_FLAGS_RELEASE
