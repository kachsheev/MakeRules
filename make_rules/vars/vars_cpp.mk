# -------------------- 
# C++ standarts

CPP_STANDART_98 = std98
CPP_STANDART_03 = std03
CPP_STANDART_11 = std11
CPP_STANDART_14 = std14
CPP_STANDART_17 = std17

CPP_STANDARTS += \
	$(CPP_STANDART_98) \
	$(CPP_STANDART_03) \
	$(CPP_STANDART_11) \
	$(CPP_STANDART_14) \
	$(CPP_STANDART_17)

# -------------------- 
# Check defining CXX

ifndef CXX
  $(error define 'CXX' variable (g++, clang or cl.exe))
endif # CXX

ifeq ($(CXX),)
  $(error CXX variable can be 'g++', 'clang' or 'cl.exe')
endif # CXX

# -------------------- 
# Defining CMP_TYPE == compiler
ifndef CMP_TYPE

# GCC
  ifeq ($(CXX),g++)
#     $(warning CMP_TYPE = gcc)
    CMP_TYPE = gcc
  endif # ($(CXX),g++)

  # Clang
  ifeq ($(CXX),clang)
    $(warning CMP_TYPE = clang)
    CMP_TYPE = clang++
    $(error $(CMP_TYPE) cannot support now.)
  endif # ($(CXX),clang)

  # MSVC
  ifeq ($(CXX),cl.exe)
    $(warning CMP_TYPE = cl.exe)
    CMP_TYPE = cl.exe
    $(error $(CMP_TYPE) cannot support now.)
  endif # ($(CXX),clang)

endif # CMP_TYPE

# -------------------- 
# Compiler flags
CXX_FLAGS =

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

ifeq ($(BUILD_TYPE),release)
  CXX_FLAGS +=$(CXX_FLAGS_RELEASE)
else
  CXX_FLAGS +=$(CXX_FLAGS_DEBUG)
endif

# $(warning CXX_FLAGS = $(CXX_FLAGS))

# -------------------- 
# Defining SOURCE_PATH_LIST
ifdef SOURCE_LIST
  SOURCE_PATH_LIST = $(sort $(dir $(SOURCE_LIST)))
endif

ifdef SOURCE_PATH
SOURCE_LIST =\
  $(call rwildcard,$(SOURCE_PATH)/, *.cpp) \
  $(call rwildcard,$(SOURCE_PATH)/, *.cxx) \
  $(call rwildcard,$(SOURCE_PATH)/, *.cc)
SOURCE_PATH_LIST = $(sort $(dir $(SOURCE_LIST)))
endif

DEP_FILES = $(subst $(SOURCE_PATH)/,$(BUILDPATH_DEP)/,$(filter %.d, $(SOURCE_LIST:.cpp=.d) $(SOURCE_LIST:.cxx=.d) $(SOURCE_LIST:.cc=.d)))
OBJ_FILES = $(subst $(SOURCE_PATH)/,$(BUILDPATH_OBJ)/,$(filter %.o, $(SOURCE_LIST:.cpp=.o) $(SOURCE_LIST:.cxx=.o) $(SOURCE_LIST:.cc=.o)))

DEP_PATHS = $(dir $(DEP_FILES))
OBJ_PATHS = $(dir $(OBJ_FILES))

CONCREATE_PATHS = $(sort $(DEP_PATHS) $(OBJ_PATHS))
# $(warning CONCREATE_PATHS = $(CONCREATE_PATHS))

LANG_MAKE_DIRS = cpp_make_dirs
LANG_RM_DIRS = cpp_rm_dirs

LANG_BUILD = cpp_build
LANG_BUILD_DEPS = cpp_build_deps
LANG_BUILD_OBJ = cpp_build_obj
LANG_BUILD_LIB = cpp_build_lib
LANG_BUILD_BIN = cpp_build_bin

LANG_CLEAN = cpp_clean
LANG_CLEAN_DEPS = cpp_clean_deps
LANG_CLEAN_OBJ = cpp_clean_obj

ifdef BUILDPATH_LIB
  LANG_BUILD_RULE = cpp_build_lib
  LANG_CLEAN_RULE = cpp_clean_lib
  ifeq ($(LIBRARY_TYPE),static)
    ifeq ($(CMP_TYPE),gcc)
      LANG_TARGET := \
        $(BUILDPATH_LIB)/lib$(NAME).a
     endif
    ifeq ($(CMP_TYPE),clang)
      $(error)
    endif
    ifeq ($(CMP_TYPE),cl.exe)
      $(error)
    endif
  endif
  ifeq ($(LIBRARY_TYPE),shared)
    ifeq ($(CMP_TYPE),gcc)
      LANG_TARGET = \
        $(BUILDPATH_LIB)/lib$(NAME).so
     endif
    ifeq ($(CMP_TYPE),clang)
      $(error)
    endif
    ifeq ($(CMP_TYPE),cl.exe)
      $(error)
    endif
  endif
  ifeq ($(LIBRARY_TYPE),both)
    ifeq ($(CMP_TYPE),gcc)
      LANG_TARGET = \
        $(BUILDPATH_LIB)/lib$(NAME).a \
        $(BUILDPATH_LIB)/lib$(NAME).so
     endif
    ifeq ($(CMP_TYPE),clang)
      $(error)
    endif
    ifeq ($(CMP_TYPE),cl.exe)
      $(error)
    endif
  endif
endif

ifdef BUILDPATH_BIN
  LANG_BUILD_RULE = cpp_build_bin
  LANG_CLEAN_RULE = cpp_clean_bin
  LANG_TARGET = $(BUILDPATH_BIN)/$(NAME)
endif

# $(warning SOURCE_LIST = $(SOURCE_LIST))
# $(warning DEP_FILES = $(DEP_FILES))
# $(warning OBJ_FILES = $(OBJ_FILES))
