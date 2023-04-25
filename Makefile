SHELL := /bin/bash
.PHONY: all
all:
	$(MAKE) rink.pdf

rink.7: .MANPAGEMETA.md Synopsis.md Rink-Manual.md make_manpage.bash
	./make_manpage.bash <(cat .MANPAGEMETA.md Synopsis.md Rink-Manual.md) $@

rink.ps: rink.7
	groff -Tps -Kutf8 -man -c $< > $@

rink.pdf: rink.ps
	ps2pdf $<
