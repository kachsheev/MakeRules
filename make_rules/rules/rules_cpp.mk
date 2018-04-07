# common
cpp_make_dirs: make_dirs
	@echo '---> RULE' $@
ifneq ($(SRC_DEPPATHS),)
	$(MKDIR) $(SRC_DEPPATHS)
endif
ifneq ($(SRC_OBJPATHS),)
	$(MKDIR) $(SRC_OBJPATHS)
endif


cpp_rm_dirs:
	@echo '---> RULE' $@
ifneq ($(SRC_DEPPATHS),)
	rmdir $(SRC_DEPPATHS)
endif
ifneq ($(SRC_OBJPATHS),)
	rmdir $(SRC_OBJPATHS)
endif

# build
cpp_build: $(LANG_BUILD_RULE)
	@echo '---> RULE' $@
	
cpp_build_deps : $(DEP_FILES)
	@echo '---> RULE' $@ -- $?

cpp_build_obj : cpp_build_deps $(OBJ_FILES)
	@echo '---> RULE' $@ -- $?

cpp_build_lib : cpp_build_obj
	@echo '---> RULE' $@

cpp_build_shared_lib : cpp_build_obj
	@echo '---> RULE' $@

cpp_build_static_lib : cpp_build_obj
	@echo '---> RULE' $@

cpp_build_bin : cpp_build_obj
	@echo '---> RULE' $@
	$(CMP) $(OBJ_FILES) -o $(BUILDPATH_BIN)/$(NAME)
	
$(BUILDPATH_DEP)/%.d : make_dirs $(SOURCE_PATH)/%.cpp
	@echo '---> RULE' $? : $@
ifeq ($(CMP_TYPE),gcc)
	$(CMP) $(CXX_FLAGS_DEP) $(CXX_INCLUDE) $(CXX_FLAGS) $(SOURCE_PATH)/$*.cpp > $(BUILDPATH_DEP)/$*.d
endif
ifeq ($(CMP_TYPE),clang)
endif
ifeq ($(CMP_TYPE),cl.exe)
endif

$(BUILDPATH_DEP)/%.d : make_dirs $(SOURCE_PATH)/%.cxx
	@echo '---> RULE' $< : $@
ifeq ($(CMP_TYPE),gcc)
	$(CMP) $(CXX_FLAGS_DEP) $(CXX_INCLUDE) $(CXX_FLAGS) $(SOURCE_PATH)/$*.cpp > $(BUILDPATH_DEP)/$*.d
endif
ifeq ($(CMP_TYPE),clang)
endif
ifeq ($(CMP_TYPE),cl.exe)
endif

$(BUILDPATH_DEP)/%.d : make_dirs $(SOURCE_PATH)/%.cc 
	@echo '---> RULE' $< : $@
ifeq ($(CMP_TYPE),gcc)
	$(CMP) $(CXX_FLAGS_DEP) $(CXX_INCLUDE) $(CXX_FLAGS) $(SOURCE_PATH)/$*.cpp > $(BUILDPATH_DEP)/$*.d
endif
ifeq ($(CMP_TYPE),clang)
endif
ifeq ($(CMP_TYPE),cl.exe)
endif

$(BUILDPATH_OBJ)/%.o : $(SOURCE_PATH)/%.cpp $(BUILDPATH_DEP)/%.d
	@echo '---> RULE' $< : 
ifeq ($(CMP_TYPE),gcc)
	$(CMP) $(CXX_INCLUDE) $(CXX_FLAGS) -c $< -o $@
endif
ifeq ($(CMP_TYPE),clang)
endif
ifeq ($(CMP_TYPE),cl.exe)
endif

$(BUILDPATH_OBJ)/%.o : $(SOURCE_PATH)/%.cxx $(BUILDPATH_DEP)/%.d
	@echo '---> RULE' $< : $@
ifeq ($(CMP_TYPE),gcc)
	$(CMP) $(CXX_INCLUDE) $(CXX_FLAGS) -c $< -o $@
endif
ifeq ($(CMP_TYPE),clang)
endif
ifeq ($(CMP_TYPE),cl.exe)
endif

$(BUILDPATH_OBJ)/%.o : $(SOURCE_PATH)/%.cc $(BUILDPATH_DEP)/%.d
	@echo '---> RULE' $< : $@
ifeq ($(CMP_TYPE),gcc)
	$(CMP) $(CXX_INCLUDE) $(CXX_FLAGS) -c $< -o $@
endif
ifeq ($(CMP_TYPE),clang)
endif
ifeq ($(CMP_TYPE),cl.exe)
endif

$(BUILDPATH_LIB)/lib$(NAME).a : 
	@echo '---> RULE' $< : $?

$(BUILDPATH_LIB)/lib$(NAME).so : 
	@echo '---> RULE' $< : $?

$(BUILDPATH_BIN)/$(NAME) : $(OBJ_FILES)
	@echo '---> RULE' $< : $?
ifeq ($(CMP_TYPE),gcc)
	$(CMP) $(CXX_INCLUDE) $(CXX_FLAGS) $(CXX_FLAGS_DEP) $? -o $@
endif
ifeq ($(CMP_TYPE),clang)
endif
ifeq ($(CMP_TYPE),cl.exe)
endif

# clean
cpp_clean : cpp_clean_deps cpp_clean_obj $(LANG_CLEAN_RULE)
	@echo '---> RULE' $@

cpp_clean_deps :
	@echo '---> RULE' $@
	rm -f $(DEP_FILES)

cpp_clean_obj :
	@echo '---> RULE' $@
	rm -f $(OBJ_FILES)

cpp_clean_lib :
	@echo '---> RULE' $@

cpp_clean_bin :
	@echo '---> RULE' $@

ifneq ($(call rwildcard,$(BUILDPATH_DEP)/,*.d),)
  include $(DEP_FILES)
endif
