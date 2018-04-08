MKDIR=mkdir -p

# all
all : build
	@echo '---> RULE' $@ : $?

# lang specific rules
include $(MKRULES_RULES_DIR)/$(LANG_RULES)

# common
make_dirs :
	@echo '---> RULE' $@
	$(MKDIR) $(BUILDPATH)
	$(MKDIR) $(BUILDPATH_DEP)
	$(MKDIR) $(BUILDPATH_OBJ)
ifdef BUILDPATH_LIB
	$(MKDIR) $(BUILDPATH_LIB)
endif
ifdef BUILDPATH_BIN
	$(MKDIR) $(BUILDPATH_BIN)
endif

rm_dirs : $(LANG_RM_DIRS)
	@echo '---> RULE' $@ : $?
	rm -fr $(BUILDPATH_DEP)
	rm -fr $(BUILDPATH_OBJ)
ifdef BUILDPATH_LIB
	rm -fr $(BUILDPATH_LIB)
endif
ifdef BUILDPATH_BIN
	rm -fr $(BUILDPATH_BIN)
endif
	rm -fr $(BUILDPATH)

# build
build : $(LANG_MAKE_DIRS) build_obj $(LINK_RULE)
	@echo '---> RULE' $@ : $?

build_obj : $(LANG_BUILD_OBJ)
	@echo '---> RULE' $@ : $?

build_lib : build_obj $(LANG_BUILD_LIB)
	@echo '---> RULE' $@ : $?

build_bin : build_obj $(LANG_BUILD_BIN)
	@echo '---> RULE' $@ : $?

# clean rules
clean : rm_dirs
	@echo '---> RULE' $@ : $?

# clean_deps : $(LANG_CLEAN_DEPS)
# 	@echo '---> RULE' $@
# 
# clean_obj : $(LANG_CLEAN_OBJ)
# 	@echo '---> RULE' $@
# 
# clean_lib :
# 	@echo '---> RULE' $@
# 
# clean_bin :
# 	@echo '---> RULE' $@
