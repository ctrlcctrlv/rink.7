#!/bin/bash
set -x
set -- $@
# Markdown to manpage, the right™ way!
[ -z "$1" ] && exit 1 || \
LANG=en_US.UTF-8
(pandoc --from=gfm --to=man -s -i - | perl -pi -0777 manpagemunge.pl) < "$1" > "$2"
#
#
#
	#groff -mandoc -Tutf8 -Kutf8

# Author: Fredrick R. Brennan <copypaste@kittens.ph>
# vim: noet sw=4 ts=4
