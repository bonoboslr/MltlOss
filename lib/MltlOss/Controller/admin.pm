package MltlOss::Controller::admin;
use Moose;
use namespace::autoclean;
use Digest::SHA1;
use MIME::Base64;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

MltlOss::Controller::admin - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

# Match /admin/users
sub base :Chained("/adminbase") :PathPart("users") :CaptureArgs(0) { }

# match /admin/users (end of chain)
sub list :Chained("base") : PathPart("") Args(0) {
	my ( $self, $c ) = @_;
	my $log = $c->log;
	if ($c->session->{logged_in}) {
  	my $user = $c->session->{username};
          
    # Get User's ROLE
    my $rs = $c->model("MltlDB::User")->single( {
    	username => $user
    });
    my $role = $rs->role;
          
    $c->stash->{username} = $user;
    $c->stash->{role} = $role;
    
    $c->stash(userResults => [$c->model('MltlDB::User')->search( { 
		user_id => { like => '%' } } )
		]);
    
    $c->stash(template => 'moss_adminUsers.tt');
    $c->forward('MltlOss::View::MltlOss');
    
 	} else {
		# Redirect to Login
  	my $url = $c->req->uri	;
		$log->info("Test: Referer : $url)");
		$c->stash->{url} = $url;
		$c->stash(template => "static/moss_login.tt");
		$c->forward('MltlOss::View::MltlOss');
	}
	
}

# Match /admin/users/*
sub id :Chained("base") :PathPart("") :CaptureArgs(1) {}

# Match /admin/users/* (End of Chain)
sub view :Chained("id") :PathPart("") Args(0) { }

# Match /admin/users/*/edit
sub edit :Chained("id") :PathPart("edit") Args(0) {

	my ( $self, $c ) = @_;
	my $log = $c->log;
	if ($c->session->{logged_in}) {
  	my $user = $c->session->{username};
          
    # Get User's ROLE
    my $rs = $c->model("MltlDB::User")->single( {
    	username => $user
    });
    my $role = $rs->role;
          
    $c->stash->{username} = $user;
    $c->stash->{role} = $role;
    
    # get userID from URL
    # Grab URI
    my $url = $c->req->uri;

    # Split URI to get the custid
    my @elements = split('/',$url);
    my $user_id = $elements[5];
    
    # Search for User In DB
    $c->stash(userResults => [$c->model('MltlDB::User')->search( { 
		user_id => { like => $user_id } } )
		]);
		
		# Change Userpassword
		if ($c->req->param("changePasswordSubmit")) {
			
			my $ctx = Digest::SHA1->new();
    	$ctx->add($c->req->param("userPassword"));
    	#$ctx->add('salt');
    	my $hashedSHAPasswd = '{SHA}' . encode_base64($ctx->digest ,'');
    	$log->info("Password : $hashedSHAPasswd");
    
    	my $msg = $c->model('People')->search("(uid=$user)");
    	my $entry = $msg->shift_entry;
    	$entry->userPassword("$hashedSHAPasswd");
    	$entry->update;
  	}
  	
  	# Change UserDetails
  	if ($c->req->param("updateDetailsSubmit")) {
  		
  		my $rs = $c->model('MltlDB::User')->search( {
  			user_id => $user_id
  		});
  	
  		$rs->update( {
  			first_name => $c->req->param("firstName"),
  			surname => $c->req->param("surname"),
  			email => $c->req->param("email"),
  			phone => $c->req->param("phone"),
  			role => $c->req->param("userRole")
  		});
  		$c->response->redirect("/admin/users");
  	}
		
		$c->stash(template => 'moss_adminUsersEdit.tt');
    $c->forward('MltlOss::View::MltlOss');
    
	} else {
		# Redirect to Login
  	my $url = $c->req->uri	;
		$log->info("Test: Referer : $url)");
		$c->stash->{url} = $url;
		$c->stash(template => "static/moss_login.tt");
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
