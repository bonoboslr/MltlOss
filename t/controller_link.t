use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'MltlOss' }
BEGIN { use_ok 'MltlOss::Controller::link' }

ok( request('/link')->is_success, 'Request should succeed' );
done_testing();
