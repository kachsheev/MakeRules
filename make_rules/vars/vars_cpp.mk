# C++ standarts

CXX_STANDART_98 := c++98
CXX_STANDART_03 := c++03
CXX_STANDART_0x := c++0x
CXX_STANDART_11 := c++11
CXX_STANDART_1y := c++1y
CXX_STANDART_14 := c++14
CXX_STANDART_1z := c++1z
CXX_STANDART_17 := c++17
CXX_STANDART_2a := c++2a
CXX_STANDART_20 := c++20

CXX_STANDART_LIST += \
  $(CXX_STANDART_98) \
  $(CXX_STANDART_03) \
  $(CXX_STANDART_0x) \
  $(CXX_STANDART_11) \
  $(CXX_STANDART_1y) \
  $(CXX_STANDART_14) \
  $(CXX_STANDART_1z) \
  $(CXX_STANDART_17) \
  $(CXX_STANDART_2a) \
  $(CXX_STANDART_20)

# Check defining CXX

ifndef CXX
  $(error define 'CXX' variable (g++, clang or cl.exe))
endif # CXX

ifeq ($(CXX),)
  $(error CXX variable can be 'g++', 'clang' or 'cl.exe')
endif # ($(CXX),)


# Defining CMP_TYPE == compiler

ifndef CMP_TYPE

  # GCC
  ifeq ($(CXX),g++)
  #  $(warning CMP_TYPE := gcc)
    CMP_TYPE := gcc
  endif # ($(CXX),g++)

  # Clang
  ifeq ($(CXX),clang)
    $(warning CMP_TYPE := clang)
    CMP_TYPE := clang++
    $(error $(CMP_TYPE) cannot support now.)
  endif # ($(CXX),clang)

  # MSVC
  ifeq ($(CXX),cl.exe)
    $(warning CMP_TYPE := cl.exe)
    CMP_TYPE := cl.exe
    $(error $(CMP_TYPE) cannot support now.)
  endif # ($(CXX),clang)

endif # CMP_TYPE


# Compiler flags

ifndef CXX_FLAGS

  CXX_FLAGS :=

  # gcc
  ifeq ($(CMP_TYPE),gcc)
    include $(MKRULES_VARS_DIR)/vars_$(CMP_TYPE)_cpp.mk
    CXX_FLAGS += $(CXX_FLAGS_BASE)
  endif # ($(CMP_TYPE),gcc)

  # clang
  ifeq ($(CMP_TYPE),clang)
  endif # ($(CMP_TYPE),clang)

  # cl.exe
  ifeq ($(CMP_TYPE),cl.exe)
  endif # ($(CMP_TYPE),cl.exe)

  # debug / release
  ifeq ($(BUILD_TYPE),release)
    CXX_FLAGS += $(CXX_FLAGS_RELEASE)
  else
    CXX_FLAGS += $(CXX_FLAGS_DEBUG)
  endif

endif


# Defining SOURCE_PATH_LIST

ifdef SOURCE_LIST
  SOURCE_PATH_LIST := $(sort $(dir $(SOURCE_LIST)))
endif

ifdef SOURCE_PATH
SOURCE_LIST =\
  $(call rwildcard,$(SOURCE_PATH)/, *.cpp) \
  $(call rwildcard,$(SOURCE_PATH)/, *.cxx) \
  $(call rwildcard,$(SOURCE_PATH)/, *.cc)
SOURCE_PATH_LIST := $(sort $(dir $(SOURCE_LIST)))
endif

DEP_FILES := $(subst $(SOURCE_PATH)/,$(BUILDPATH_DEP)/,$(filter %.d, $(SOURCE_LIST:.cpp=.d) $(SOURCE_LIST:.cxx=.d) $(SOURCE_LIST:.cc=.d)))
OBJ_FILES := $(subst $(SOURCE_PATH)/,$(BUILDPATH_OBJ)/,$(filter %.o, $(SOURCE_LIST:.cpp=.o) $(SOURCE_LIST:.cxx=.o) $(SOURCE_LIST:.cc=.o)))

DEP_PATHS := $(sort $(dir $(DEP_FILES)))
OBJ_PATHS := $(sort $(dir $(OBJ_FILES)))

LANG_MAKE_DIRS := cpp_make_dirs
LANG_RM_DIRS := cpp_rm_dirs

LANG_BUILD := cpp_build
LANG_BUILD_DEPS := cpp_build_deps
LANG_BUILD_OBJ := cpp_build_obj

LANG_CLEAN := cpp_clean
LANG_CLEAN_DEPS := cpp_clean_deps
LANG_CLEAN_OBJ := cpp_clean_obj

ifdef BUILDPATH_BIN
  BIN_PATH := $(BUILDPATH_BIN)/
  LANG_BUILD_RULE := cpp_build_bin
  LANG_CLEAN_RULE := cpp_clean_bin
  LANG_TARGET := $(BIN_PATH)$(NAME)
endif

ifdef BUILDPATH_LIB
  LIB_PATH := $(BUILDPATH_LIB)/
  LANG_BUILD_RULE := cpp_build_lib
  LANG_CLEAN_RULE := cpp_clean_lib

  # check static
  ifeq ($(LIBRARY_TYPE),static)
    ifeq ($(CMP_TYPE),gcc)
      LANG_TARGET := \
        $(LIB_PATH)lib$(NAME).a
    endif # $(CMP_TYPE),gcc
    ifeq ($(CMP_TYPE),clang)
      $(error)
    endif # $(CMP_TYPE),clang
    ifeq ($(CMP_TYPE),cl.exe)
      $(error)
    endif # $(CMP_TYPE),cl.exe
  endif # $(LIBRARY_TYPE),static

  # check shared
  ifeq ($(LIBRARY_TYPE),shared)
    ifeq ($(CMP_TYPE),gcc)
      LANG_TARGET := \
        $(LIB_PATH)lib$(NAME).so
    endif # $(CMP_TYPE),gcc
    ifeq ($(CMP_TYPE),clang)
      $(error)
    endif # $(CMP_TYPE),clang
    ifeq ($(CMP_TYPE),cl.exe)
      $(error)
    endif # $(CMP_TYPE),cl.exe
  endif # $(LIBRARY_TYPE),shared

  # check both
  ifeq ($(LIBRARY_TYPE),both)
    ifeq ($(CMP_TYPE),gcc)
      LANG_TARGET := \
        $(LIB_PATH)lib$(NAME).a \
        $(LIB_PATH)lib$(NAME).so
    endif # $(CMP_TYPE),gcc
    ifeq ($(CMP_TYPE),clang)
      $(error)
    endif # $(CMP_TYPE),clang
    ifeq ($(CMP_TYPE),cl.exe)
      $(error)
    endif # $(CMP_TYPE),cl.exe
  endif # $(LIBRARY_TYPE),both
endif # BUILDPATH_LIB

CONCREATE_PATHS := $(sort $(DEP_PATHS) $(OBJ_PATHS) $(BIN_PATH) $(LIB_PATH))
