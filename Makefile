.PHONY: all
.DEFAULT_GOAL := all

all:
	$(MAKE) -C $(CURDIR)/output

%:
	$(MAKE) -C $(CURDIR)/output $@

%_defconfig:
ifneq ($(O),)
	@./setup.sh $@ O=../$(O)
else
	@./setup.sh $@ O=../output
endif
