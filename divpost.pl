#!/usr/bin/env perl
# -*- cperl -*-

use 5.010;
use common::sense;

use lib '.';
require Divpost;

use Continuity;

my $server = Continuity->new(port => $ENV{APP_PORT});
$server->loop;

sub main {
    &Divpost::main
}
