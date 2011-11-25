package MltlOss::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

MltlOss::Controller::Root - Root Controller for MltlOss

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	my $log = $c->log;

	if ($c->session->{logged_in}) {
		my $user = $c->session->{username};
		$c->stash->{username} = $user;
		$c->stash->{logged_in} = 1;
		$c->stash->{page} = 'start';
                $log->info("Connect to Database and get userid");
		$c->stash(template => 'moss_index.tt');
                $c->forward('MltlOss::View::MltlOss');
	} else {
	        $c->stash(template => 'static/moss_login.tt');
                $c->forward('MltlOss::View::MltlOss');
	}
}

sub logout :Local :Args(0) {
        my ( $self, $c ) = @_;
        my $log = $c->log;

                $c->delete_session;
                $c->stash->{logged_in} = 0;
		$c->response->redirect('/');
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
