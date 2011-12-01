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

sub base :Chained("/") : PathPart("login") : CaptureArgs(0) { }

sub root :Chained("base") : PathPart("") Args(0) {
    	my ( $self, $c ) = @_;
	my $log = $c->log;

               	if ($c->authenticate({ id => $c->req->param("username"), password => $c->req->param("password") }))
                {
												$log->info("User Logged In");
												my $url = $c->req->param("url");
												$log->info("$url");
                        $c->stash->{username} = $c->req->param("username");
                        $c->session->{username} = $c->req->param("username");
                        $c->stash->{logged_in} = 1;
                        $c->session->{logged_in} = 1;
                        if ($url eq '') {
                        	$c->response->redirect('/');
                        } else {
                        	$c->response->redirect("$url");
                        }
                      
                } else {
                        $c->stash->{logged_in} = 0;
                        $c->stash(template => 'static/moss_loginfail.tt');
                        $c->forward('MltlOss::View::MltlOss');
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
