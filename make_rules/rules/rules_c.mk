# common

c_make_dirs: make_dirs
	@echo '-> RULE' $@
ifneq ($(SRC_DEPPATHS),)
	$(MKDIR) $(SRC_DEPPATHS)
endif
ifneq ($(SRC_OBJPATHS),)
	$(MKDIR) $(SRC_OBJPATHS)
endif

c_rm_dirs:
	@echo '-> RULE' $@
ifneq ($(SRC_DEPPATHS),)
	rmdir $(SRC_DEPPATHS)
endif
ifneq ($(SRC_OBJPATHS),)
	rmdir $(SRC_OBJPATHS)
endif


# build

c_build: $(LANG_BUILD_RULE)
	@echo '-> RULE' $@ : $?

c_build_obj : $(OBJ_FILES)
	@echo '-> RULE' $@ : $?

c_build_lib : c_build_obj $(LANG_TARGET)
	@echo '-> RULE' $@ : $?

c_build_bin : c_build_obj $(LANG_TARGET)
	@echo '-> RULE' $@ : $?


# include dep files

CC_EXIT_DEPS = $(call rwildcard,$(BUILDPATH_DEP)/,*.d)
ifneq ($(CC_EXIT_DEPS),)
#   $(warning $(call rwildcard,$(BUILDPATH_DEP)/,*.d))
  include $(CC_EXIT_DEPS)
endif


# build object files

$(BUILDPATH_OBJ)/%.o : $(SOURCE_PATH)/%.c
	@echo '----> OBJ_DEP' $@ : $?
ifeq ($(CMP_TYPE),gcc)
	@$(CMP) $(CC_INCLUDE) $(CC_FLAGS) $(CC_FLAGS_DEP) -MF $(BUILDPATH_DEP)/$*.d -c $< -o $@
endif
ifeq ($(CMP_TYPE),clang)
endif


# build libraries

$(BUILDPATH_LIB)/lib$(NAME).a : $(OBJ_FILES)
	@echo '----> STATIC_LIB' $@ : $?
ifeq ($(CMP_TYPE),gcc)
	@$(AR) rcs $@ $?
endif
ifeq ($(CMP_TYPE),clang)
endif

$(BUILDPATH_LIB)/lib$(NAME).so : $(OBJ_FILES)
	@echo '----> SHARED_LIB' $@ : $?
ifeq ($(CMP_TYPE),gcc)
	@$(CMP) $(CC_INCLUDE) $(CC_FLAGS) $(CC_FLAGS_DEP) $(CC_FLAGS_LIB) $? -o $@
endif
ifeq ($(CMP_TYPE),clang)
endif

$(BUILDPATH_BIN)/$(NAME) : $(OBJ_FILES)
	@echo '----> BINARY' $@ : $?
ifeq ($(CMP_TYPE),gcc)
	@$(CMP) $(CC_INCLUDE) $(CC_FLAGS) $(CC_FLAGS_DEP) $? -o $@
endif
ifeq ($(CMP_TYPE),clang)
endif


# clean

c_clean : c_clean_deps c_clean_obj $(LANG_CLEAN_RULE)
	@echo '-> RULE' $@

c_clean_deps :
	@echo '-> RULE' $@
	rm -f $(DEP_FILES)

c_clean_obj :
	@echo '-> RULE' $@
	rm -f $(OBJ_FILES)

c_clean_lib :
	@echo '-> RULE' $@
	rm -f $(LANG_TARGET)

c_clean_bin :
	@echo '-> RULE' $@
	rm -f $(LANG_TARGET)
