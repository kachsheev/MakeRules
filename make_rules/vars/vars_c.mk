# -------------------- 
# C standarts

C_STANDART_89 = std89
C_STANDART_90 = std90
C_STANDART_99 = std99
C_STANDART_11 = std11
C_STANDART_17 = std17

C_STANDARTS += \
	$(C_STANDART_89) \
	$(C_STANDART_90) \
	$(C_STANDART_99) \
	$(C_STANDART_11) \
	$(C_STANDART_17)

# -------------------- 
# Check defining CC

ifeq ($(CMP_TYPE),cl.exe)
  $(error cl.exe cannot suppert *.c files.)
endif

ifndef CC
  $(error define 'CC' variable (gсс, clang))
endif # CC

ifeq ($(CC),)
  $(error CC variable can be 'gcc', 'clang')
endif # CC

# -------------------- 
# Defining CMP_TYPE == compiler
ifndef CMP_TYPE

# GCC
  ifeq ($(CC),cc)
#     $(warning CMP_TYPE = gcc)
    CMP_TYPE = gcc
  endif # ($(CC),gcc)

  # Clang
  ifeq ($(CC),clang)
    $(warning CMP_TYPE = clang)
    CMP_TYPE = clang
    $(error $(CMP_TYPE) cannot support now.)
  endif # ($(CC),clang)

endif # CMP_TYPE

# -------------------- 
# Compiler flags
CC_FLAGS =

# gcc
ifeq ($(CMP_TYPE),gcc)
  include $(MKRULES_VARS_DIR)/vars_$(CMP_TYPE)_$(LANG).mk
  CC_FLAGS += $(CC_FLAGS_BASE)
endif # ($(CMP_TYPE),gcc)

# clang
ifeq ($(CMP_TYPE),clang)
endif # ($(CMP_TYPE),clang)


ifeq ($(BUILD_TYPE),release)
  CC_FLAGS +=$(CC_FLAGS_RELEASE)
else
  CC_FLAGS +=$(CC_FLAGS_DEBUG)
endif

# $(warning CC_FLAGS = $(CC_FLAGS))

# -------------------- 
# Defining SOURCE_PATH_LIST
ifdef SOURCE_LIST
  SOURCE_PATH_LIST = $(sort $(dir $(SOURCE_LIST)))
endif

ifdef SOURCE_PATH
SOURCE_LIST = $(call rwildcard,$(SOURCE_PATH)/, *.c)
SOURCE_PATH_LIST = $(sort $(dir $(SOURCE_LIST)))
endif

DEP_FILES = $(subst $(SOURCE_PATH)/,$(BUILDPATH_DEP)/,$(filter %.d, $(SOURCE_LIST:.c=.d)))
OBJ_FILES = $(subst $(SOURCE_PATH)/,$(BUILDPATH_OBJ)/,$(filter %.o, $(SOURCE_LIST:.c=.o)))

DEP_PATHS = $(dir $(DEP_FILES))
OBJ_PATHS = $(dir $(OBJ_FILES))

CONCREATE_PATHS = $(sort $(DEP_PATHS) $(OBJ_PATHS))
# $(warning CONCREATE_PATHS = $(CONCREATE_PATHS))

LANG_MAKE_DIRS = c_make_dirs
LANG_RM_DIRS = c_rm_dirs

LANG_BUILD = c_build
LANG_BUILD_DEPS = c_build_deps
LANG_BUILD_OBJ = c_build_obj
LANG_BUILD_LIB = c_build_lib
LANG_BUILD_BIN = c_build_bin

LANG_CLEAN = c_clean
LANG_CLEAN_DEPS = c_clean_deps
LANG_CLEAN_OBJ = c_clean_obj

ifdef BUILDPATH_LIB
  LANG_BUILD_RULE = c_build_lib
  LANG_CLEAN_RULE = c_clean_lib
  
  ifeq ($(LIBRARY_TYPE),static)
    ifeq ($(CMP_TYPE),gcc)
      LANG_TARGET := \
        $(BUILDPATH_LIB)/lib$(NAME).a
     endif
    ifeq ($(CMP_TYPE),clang)
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
  endif
endif

ifdef BUILDPATH_BIN
  LANG_BUILD_RULE = c_build_bin
  LANG_CLEAN_RULE = c_clean_bin
  LANG_TARGET = $(BUILDPATH_BIN)/$(NAME)
endif

# $(warning SOURCE_LIST = $(SOURCE_LIST))
# $(warning DEP_FILES = $(DEP_FILES))
# $(warning OBJ_FILES = $(OBJ_FILES))
