CC_FLAGS_BASE =

ifndef CMP
  CMP = gcc
#   $(warning CMP not defined)
#   $(warning CMP = $(CMP))
endif

ifndef INCLUDE_PATHS
  $(warning INCLUDE_PATHS not defined)
else
  CC_INCLUDE = $(foreach directory,$(INCLUDE_PATHS),$(addprefix -I,$(directory)))
#   $(warning CC_INCLUDE = $(CC_INCLUDE))
endif

CC_FLAGS_DEP = -MMD -MP
CC_FLAGS_WARN = -pedantic -Wredundant-decls -Wcast-align \
	-Wmissing-declarations -Wmissing-include-dirs -Wswitch-enum \
	-Wswitch-default -Wextra -Wall -Winvalid-pch -Wredundant-decls \
	-Wformat=2 -Wmissing-format-attribute -Wformat-nonliteral

ifndef CC_FLAGS_DEBUG
  CC_FLAGS_DEBUG = -g -O0 $(CC_FLAGS_WARN)
#   $(warning CC_FLAGS_DEBUG not defined)
#   $(warning CC_FLAGS_DEBUG = $(CC_FLAGS_DEBUG))
endif # CC_FLAGS_DEBUG

ifndef CC_FLAGS_RELEASE
  CC_FLAGS_RELEASE = -O2 $(CC_FLAGS_WARN) -Werror
#   $(warning CC_FLAGS_RELEASE not defined)
#   $(warning CC_FLAGS_RELEASE = $(CC_FLAGS_RELEASE))
endif # CC_FLAGS_RELEASE

ifeq ($(BUILD_CONFIG),library)
  ifeq ($(LIBRARY_TYPE),shared)
    CC_FLAGS_BASE += -fPIC
    CC_FLAGS_LIB = -shared
  else
    ifeq ($(LIBRARY_TYPE),both)
      CC_FLAGS_BASE += -fPIC
      CC_FLAGS_LIB = -shared
    endif
  endif
endif
