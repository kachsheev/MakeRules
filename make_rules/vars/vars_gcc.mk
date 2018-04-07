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

CXX_FLAGS_DEP = -MD -MP

ifndef CXX_FLAGS_DEBUG
  CXX_FLAGS_WARN_DEBUG = -Wall -pedantic
  CXX_FLAGS_DEBUG = -g -O0 $(CXX_FLAGS_WARN_DEBUG)
#   $(warning CXX_FLAGS_DEBUG not defined)
#   $(warning CXX_FLAGS_DEBUG = $(CXX_FLAGS_DEBUG))
endif # CXX_FLAGS_DEBUG

ifndef CXX_FLAGS_RELEASE
  CXX_FLAGS_WARN_RELEASE = -Wall -pedantic
  CXX_FLAGS_RELEASE = -O2 $(CXX_FLAGS_WARN_RELEASE)
#   $(warning CXX_FLAGS_RELEASE not defined)
#   $(warning CXX_FLAGS_RELEASE = $(CXX_FLAGS_RELEASE))
endif # CXX_FLAGS_RELEASE
