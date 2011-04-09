#!perl -w

use strict;
use Test;
plan tests => 3;

require LWP::Protocol::http10;
LWP::Protocol::implementor('http', 'LWP::Protocol::http10');

use LWP::UserAgent;
my $ua = LWP::UserAgent->new;
my $res = $ua->get("http://www.apache.org");

ok($res->is_success);
ok($res->title, qr/\bApache\b/);

$res->dump(prefix => "# ");
print "\n";

require HTTP::Request;
$res = $ua->simple_request(HTTP::Request->new(TRACE => "http://www.apache.org/"));
ok($res->content, qr/HTTP\/1.0/);

$res->dump(prefix => "# ");
