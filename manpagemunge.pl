#!/usr/bin/perl
$_=~s/(?<=\.S[SH] )(.*)/\U$1/g;
#$_=~s/^\. ftr V B$//;
#$_=~s/\\f\[V\]/\\f\[B\]/g;
#$_=~s/(\.hy\n)/$1\n\.ll 10i/m; # Forces to be ≈80 cols.
