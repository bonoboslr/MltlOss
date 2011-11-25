package MltlOss::Controller::site;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

MltlOss::Controller::site - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

#sub index :Path :Args(0) {
    #my ( $self, $c ) = @_;

    #$c->response->body('Matched MltlOss::Controller::services in services.');

#}

# Construct Chain
# # Match the Root and display /services/
sub base :Chained("/") : PathPart("site") : CaptureArgs(0) { }

sub root : Chained("base") : PathPart("") : Args(0) {
        my ($self, $c, $id) = @_;
        my $log = $c->log;
	$log->info("TEST");
        if ($c->session->{logged_in}) {
                my $user = $c->session->{username};
                $c->stash->{username} = $user;
                $c->stash->{page} = 'sites';
                $c->forward('end');
        } else {
                # Redirect to Login
                $c->response->redirect('/');
        }
}

sub end :Local :Args(0) {
        my ( $self, $c ) = @_;
                $c->stash(template => 'static/header.tt');
                $c->forward('MltlOss::View::MltlOss');
}


=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
