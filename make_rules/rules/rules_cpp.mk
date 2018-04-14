# common

cpp_make_dirs: $(CONCREATE_PATHS)
	@echo '-> RULE' $@ : $?


# make dirs

ifneq ($(DEP_PATHS),)
$(DEP_PATHS):
	@echo '-> MKDIR' $@ : $?
	@$(MKDIR) $(DEP_PATHS)
endif

ifneq ($(OBJ_PATHS),)
$(OBJ_PATHS):
	@echo '-> MKDIR' $@ : $?
	@$(MKDIR) $(OBJ_PATHS)
endif

ifneq ($(BIN_PATH),)
$(BIN_PATH):
	@echo '-> MKDIR' $@ : $?
	@$(MKDIR) $(BIN_PATH)
endif

ifneq ($(LIB_PATH),)
$(LIB_PATH):
	@echo '-> MKDIR' $@ : $?
	@$(MKDIR) $(LIB_PATH)
endif


# remove dirs

cpp_rm_dirs: cpp_clean
	@echo '-> RULE' $@ : $?
ifneq ($(DEP_PATHS),)
	@$(RM) $(DEP_PATHS)
endif
ifneq ($(OBJ_PATHS),)
	@$(RM) $(OBJ_PATHS)
endif
ifneq ($(BIN_PATH),)
	@$(RM) $(BIN_PATH)
endif
ifneq ($(LIB_PATH),)
	@$(RM) $(LIB_PATH)
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

EXIST_DEPS = $(call rwildcard,$(BUILDPATH_DEP)/,*.d)
ifneq ($(EXIST_DEPS),)
  include $(EXIST_DEPS)
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
	@$(RM) $(DEP_FILES)

cpp_clean_obj :
	@echo '-> RULE' $@
	@$(RM) $(OBJ_FILES)

cpp_clean_lib :
	@echo '-> RULE' $@
	@$(RM) $(LANG_TARGET)

cpp_clean_bin :
	@echo '-> RULE' $@
	@$(RM) $(LANG_TARGET)
