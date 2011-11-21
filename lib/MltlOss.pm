package MltlOss;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    -Debug
    Authentication
    ConfigLoader
    Static::Simple
    Session
    Session::State::Cookie
    Session::Store::FastMmap
/;

extends 'Catalyst';

our $VERSION = '0.01';
$VERSION = eval $VERSION;

# Configure the application.
#
# Note that settings in mltloss.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'MltlOss',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
);

 __PACKAGE__->config(
      'authentication' => {
         default_realm => "ldap",
         realms => {
           ldap => {
             credential => {
               class => "Password",
               password_field => "password",
               password_type => "self_check",
             },
             store => {
               binddn              => "anonymous",
               bindpw              => "dontcarehow",
               class               => "LDAP",
               ldap_server         => "192.168.190.11",
               ldap_server_options => { timeout => 30 },
               role_basedn         => "ou=groups,ou=OxObjects,dc=yourcompany,dc=com",
               role_field          => "uid",
               role_filter         => "(&(objectClass=posixGroup)(memberUid=%s))",
               role_scope          => "one",
               role_search_options => { deref => "always" },
               role_value          => "dn",
               role_search_as_user => 0,
               start_tls           => 0,
               start_tls_options   => { verify => "none" },
               entry_class         => "MLTL::LDAP::Entry",
               use_roles           => 0,
               user_basedn         => "ou=people,dc=multilinks,dc=com",
               user_field          => "uid",
               user_filter         => "(&(objectClass=posixAccount)(uid=%s))",
               user_scope          => "one", # or "sub" for Active Directory
               user_search_options => { deref => "always" },
               user_results_filter => sub { return shift->pop_entry },
             },
           },
         },
       },
    );

# Start the application
__PACKAGE__->setup();


=head1 NAME

MltlOss - Catalyst based application

=head1 SYNOPSIS

    script/mltloss_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<MltlOss::Controller::Root>, L<Catalyst>

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
