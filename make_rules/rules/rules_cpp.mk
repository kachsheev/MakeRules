# common

cpp_make_dirs: make_dirs
	@echo '-> RULE' $@ : $?
ifneq ($(SRC_DEPPATHS),)
	$(MKDIR) $(SRC_DEPPATHS)
endif
ifneq ($(SRC_OBJPATHS),)
	$(MKDIR) $(SRC_OBJPATHS)
endif

cpp_rm_dirs:
	@echo '-> RULE' $@ : $?
ifneq ($(SRC_DEPPATHS),)
	rmdir $(SRC_DEPPATHS)
endif
ifneq ($(SRC_OBJPATHS),)
	rmdir $(SRC_OBJPATHS)
endif


# build

cpp_build: $(LANG_BUILD_RULE)
	@echo '-> RULE' $@ : $?

cpp_build_obj : $(OBJ_FILES)
	@echo '-> RULE' $@ : $?

cpp_build_lib : cpp_build_obj $(LANG_TARGET)
	@echo '-> RULE' $@ : $?

cpp_build_bin : cpp_build_obj $(LANG_TARGET)
	@echo '-> RULE' $@ : $?


# include dep files

ifneq ($(call rwildcard,$(BUILDPATH_DEP)/,*.d),)
#   $(warning including $(DEP_FILES))
  include $(DEP_FILES)
endif


# build object files

$(BUILDPATH_OBJ)/%.o : $(SOURCE_PATH)/%.cpp
	@echo '----> OBJ_DEP' $@ : $?
ifeq ($(CMP_TYPE),gcc)
	@$(CMP) $(CXX_INCLUDE) $(CXX_FLAGS) $(CXX_FLAGS_DEP) -MF $(BUILDPATH_DEP)/$*.d -c $< -o $@
endif
ifeq ($(CMP_TYPE),clang)
endif
ifeq ($(CMP_TYPE),cl.exe)
endif

$(BUILDPATH_OBJ)/%.o : $(SOURCE_PATH)/%.cxx
	@echo '----> OBJ_DEP' $@ : $?
ifeq ($(CMP_TYPE),gcc)
	@$(CMP) $(CXX_INCLUDE) $(CXX_FLAGS) $(CXX_FLAGS_DEP) -MF $(BUILDPATH_DEP)/$*.d -c $< -o $@
endif
ifeq ($(CMP_TYPE),clang)
endif
ifeq ($(CMP_TYPE),cl.exe)
endif

$(BUILDPATH_OBJ)/%.o : $(SOURCE_PATH)/%.cc
	@echo '----> OBJ_DEP' $@ : $?
ifeq ($(CMP_TYPE),gcc)
	@$(CMP) $(CXX_INCLUDE) $(CXX_FLAGS) $(CXX_FLAGS_DEP) -MF $(BUILDPATH_DEP)/$*.d -c $< -o $@
endif
ifeq ($(CMP_TYPE),clang)
endif
ifeq ($(CMP_TYPE),cl.exe)
endif


# build libraries

$(BUILDPATH_LIB)/lib$(NAME).a : $(OBJ_FILES)
	@echo '----> STATIC_LIB' $@ : $?
ifeq ($(CMP_TYPE),gcc)
	@$(AR) rcs $@ $?
endif
ifeq ($(CMP_TYPE),clang)
endif
ifeq ($(CMP_TYPE),cl.exe)
endif

$(BUILDPATH_LIB)/lib$(NAME).so : $(OBJ_FILES)
	@echo '----> SHARED_LIB' $@ : $?
ifeq ($(CMP_TYPE),gcc)
	@$(CMP) $(CXX_INCLUDE) $(CXX_FLAGS) $(CXX_FLAGS_DEP) $(CXX_FLAGS_LIB) $? -o $@
endif
ifeq ($(CMP_TYPE),clang)
endif
ifeq ($(CMP_TYPE),cl.exe)
endif

$(BUILDPATH_BIN)/$(NAME) : $(OBJ_FILES)
	@echo '----> BINARY' $@ : $?
ifeq ($(CMP_TYPE),gcc)
	@$(CMP) $(CXX_INCLUDE) $(CXX_FLAGS) $(CXX_FLAGS_DEP) $? -o $@
endif
ifeq ($(CMP_TYPE),clang)
endif
ifeq ($(CMP_TYPE),cl.exe)
endif


# clean

cpp_clean : cpp_clean_deps cpp_clean_obj $(LANG_CLEAN_RULE)
	@echo '-> RULE' $@ : $?

cpp_clean_deps :
	@echo '-> RULE' $@
	rm -f $(DEP_FILES)

cpp_clean_obj :
	@echo '-> RULE' $@
	rm -f $(OBJ_FILES)

cpp_clean_lib :
	@echo '-> RULE' $@
	rm -f $(LANG_TARGET)

cpp_clean_bin :
	@echo '-> RULE' $@
	rm -f $(LANG_TARGET)
