MKRULES_CURRENT_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
MKRULES_VARS_DIR := $(MKRULES_CURRENT_DIR)/vars
MKRULES_RULES_DIR := $(MKRULES_CURRENT_DIR)/rules

$(warning include vars_base.mk)
include $(MKRULES_VARS_DIR)/vars_base.mk
$(warning include rules_base.mk)
include $(MKRULES_RULES_DIR)/rules_base.mk
