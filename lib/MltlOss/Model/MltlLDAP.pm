package MltlOss::Model::MltlLDAP;

use strict;
use warnings;
use base qw/Catalyst::Model::LDAP/;

__PACKAGE__->config(
    host              => '192.168.190.11',
    base              => 'dc=multilinks,dc=com',
    dn                => 'cn=manager,dc=multilinks,dc=com',
    password          => 'k1ckst4rt',
    start_tls         => 0,
    start_tls_options => { verify => 'require' },
    options           => {},  # Options passed to search
);

=head1 NAME

MltlOss::Model::MltlLDAP - LDAP Catalyst model component

=head1 SYNOPSIS

See L<MltlOss>.

=head1 DESCRIPTION

LDAP Catalyst model component.

=head1 AUTHOR

root

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
