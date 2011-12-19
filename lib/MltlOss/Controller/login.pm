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

                        # Check if user is in Users Table - if not add them.
												my $rs = $c->model("MltlDB::User")->single( {
													username => $c->req->param("username")
												});
												
												my $username = $c->req->param("username");
    										$c->stash->{username} = $username;
												
											if ($rs == '') {
											# user is not in DB - add them.
											# First find all details from LDAP
											my $mesg = $c->model('People')->search("(uid=$username)");
    											my @entries = $mesg->entries;
    											my $fullname = $entries[0]->get_value('displayName');
    											my ($firstname,$surname) = split(/ /,$fullname);
    											my $email = $entries[0]->get_value('mail');
    											$rs = $c->model("MltlDB::User")->create( {
    												username => $username,
    												first_name => $firstname,
    												surname => $surname,
    												email => $email,
    												role => 'user'
    											});
    											$log->info("$fullname : $email - entered into the DB");
    											
    										} else { 
    											# update the DB (WORK AROUND FOR MYSQL BUG!!!)
    											my $rs = $c->model("MltlDB::User")->single( {
    												username => $username
    											});
    											$rs->update( {
    												username => "test$username",
    											});
    											my $rs = $c->model("MltlDB::User")->single( {
    												username => "test$username",
    											});
    											$rs->update( {
    												username => $username,
    											});

    											my $role = $rs->role;
    											$c->stash->{role} = $role;
    										}
													

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
