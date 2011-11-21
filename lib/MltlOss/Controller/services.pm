package MltlOss::Controller::services;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

MltlOss::Controller::services - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched MltlOss::Controller::services in services.');
}

# Construct Chain
# Match the Root and display /services/
sub base :Chained("/") : PathPart("service") : CaptureArgs(0) { }

sub root : Chained("base") : PathPart("") : Args(0) {
        my ($self, $c, $id) = @_;
        my $log = $c->log;
        if ($c->session->{logged_in}) {
                my $user = $c->session->{username};
                $c->stash->{username} = $user;
                $c->stash->{page} = 'services';
                $c->forward('end');
        } else {
                # Redirect to Login
                $c->response->redirect('/');
        }
}

sub view : Chained('base') : PathPart('') Args(1) {
        my ($self, $c, $serviceid) = @_;
        my $log = $c->log;
        if ($c->session->{logged_in}) {
                my $user = $c->session->{username};
                $c->stash->{username} = $user;
                $c->stash(custServiceResults => [$c->model('MltlDB::EnterpriseService')->search( {
                                                        service_id => $serviceid })]);

                $c->stash->{page} = 'services_search_res';
                $c->session->{service_id} = $serviceid;
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
