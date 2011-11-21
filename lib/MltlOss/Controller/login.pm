package MltlOss::Controller::login;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

MltlOss::Controller::login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	my $log = $c->log;

	if ($c->req->param("logout")) {
                $c->delete_session;
                $c->stash->{logged_in} = 0;
                $c->response->redirect('/');
        }

        else {

                if ($c->authenticate({ id => $c->req->param("username"), password => $c->req->param("password") }))
                {
			$log->info("User Logged In");
                        $c->stash->{username} = $c->req->param("username");
                        $c->session->{username} = $c->req->param("username");
                        $c->stash->{logged_in} = 1;
                        $c->session->{logged_in} = 1;
                        $c->response->redirect('/');
                        $c->stash(template => 'index.tt');
                        $c->forward('MltlOss::View::MltlOss');
                      
                } else {
                    
                        $c->stash->{logged_in} = 0;
                        $c->stash(template => 'index.tt');
                        $c->forward('MltlOss::View::MltlOss');
                }
      	}

}


=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
