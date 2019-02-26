MKDIR := mkdir -p
RM := rm -rf

# all
all : build
	@echo '-> RULE' $@ : $?

include $(MKRULES_RULES_DIR)/rules_help.mk

# lang specific rules

include $(MKRULES_RULES_DIR)/$(LANG_RULES)


# common

make_dirs :
	@echo '-> RULE' $@
	@$(MKDIR) $(BUILDPATH)

rm_dirs : $(LANG_RM_DIRS)
	@echo '-> RULE' $@ : $?
	@$(RM) $(BUILDPATH)


# build

build : $(LANG_MAKE_DIRS) build_obj $(LINK_RULE)
	@echo '-> RULE' $@ : $?

build_obj : $(LANG_MAKE_DIRS) $(LANG_BUILD_OBJ)
	@echo '-> RULE' $@ : $?

build_lib : build_obj $(LANG_BUILD_RULE)
	@echo '-> RULE' $@ : $?

build_bin : build_obj $(LANG_BUILD_RULE)
	@echo '-> RULE' $@ : $?


# clean rules

clean : $(LANG_CLEAN_RULE) rm_dirs
	@echo '-> RULE' $@ : $?

.DEFAULT: all
.PHONY: all build  clean
