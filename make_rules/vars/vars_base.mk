rwildcard = $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))


# Check defining NAME

ifndef NAME
  $(error define NAME variable)
endif # NAME

ifeq ($(NAME),)
  $(error NAME variable cannot be empty)
endif # ($(NAME),)


# Check defining BUILDPATH

ifndef BUILDPATH
  $(error define BUILDPATH variable)
endif # BUILDPATH

ifeq ($(BUILDPATH),)
  $(error BUILDPATH variable cannot be empty)
endif # ($(BUILDPATH),)

BUILDPATH_DEP := $(BUILDPATH)/dep
BUILDPATH_OBJ := $(BUILDPATH)/obj
BUILDPATH_LIST := $(BUILDPATH_DEP) $(BUILDPATH_OBJ)


# Check defining BUILD_CONFIG

ifndef BUILD_CONFIG
  $(error define BUILD_CONFIG variable)
endif # BUILD_CONFIG

ifeq ($(BUILD_CONFIG),)
  $(error BUILD_CONFIG variable cannot be empty)
endif # ($(BUILD_CONFIG),)

ifneq ($(BUILD_CONFIG),multibuild)
  ifneq ($(BUILD_CONFIG),library)
    ifneq ($(BUILD_CONFIG),execute)
      $(error BUILD_CONFIG variable can be 'multibuild' or 'library' or 'execute')
    endif # $(BUILD_CONFIG),execute
  endif # $(BUILD_CONFIG),library
endif # $(BUILD_CONFIG),multibuild

ifeq ($(BUILD_CONFIG),execute)
  BUILDPATH_BIN := $(BUILDPATH)/bin
  BUILDPATH_LIST += $(BUILDPATH_BIN)
  LINK_RULE := build_bin
  CLEAN_RULE := clean_bin
endif # ($(BUILD_CONFIG),execute)

ifeq ($(BUILD_CONFIG),library)
  BUILDPATH_LIB := $(BUILDPATH)/lib
  BUILDPATH_LIST += $(BUILDPATH_LIB)
  LINK_RULE := build_lib
  CLEAN_RULE := clean_lib
endif # ($(BUILD_CONFIG),library)

ifeq ($(BUILD_CONFIG),multibuild)
  BUILDPATH_LIB := $(BUILDPATH)/lib
  BUILDPATH_BIN := $(BUILDPATH)/bin
  BUILDPATH_LIST += $(BUILDPATH_BIN) $(BUILDPATH_LIB)
  $(error 'multibuild' cannot support now)
endif # $(BUILD_CONFIG),multibuild


# Check defining BUILD_TYPE

ifndef BUILD_TYPE
  BUILD_TYPE := release
endif # BUILD_TYPE

ifneq ($(BUILD_TYPE),debug)
  ifneq ($(BUILD_TYPE),release)
    BUILD_TYPE := release
  endif # $(BUILD_TYPE),release
endif # $(BUILD_TYPE),debug


# Check defining SOURCE_LIST or SOURCE_PATH

ifndef SOURCE_LIST
  ifndef SOURCE_PATH
    $(error define SOURCE_LIST and SOURCE_PATH variables)
  endif # SOURCE_PATH
endif # SOURCE_LIST


# Check defining LANG

ifndef LANG
  $(error define LANG variable)
endif # LANG

ifneq ($(LANG),cpp)
  ifneq ($(LANG),c)
    $(error LANG variable can be 'cpp' or 'c')
  endif # $(LANG),c
endif # $(LANG),cpp

LANG_VARS := vars_$(LANG).mk
LANG_RULES := rules_$(LANG).mk


# lang specific variables

include $(MKRULES_VARS_DIR)/$(LANG_VARS)
