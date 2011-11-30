package MltlOss::Controller::customers;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

MltlOss::Controller::customers - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

# Construct Chain
sub base :Chained("/") : PathPart("customers") :CaptureArgs(0) {
}

# Display Root
sub root :Chained("base") : PathPart("") Args(0) {
	my ($self, $c, $id) = @_;
	my $log = $c->log;
        if ($c->session->{logged_in}) {
        	my $user = $c->session->{username};
		$log->info("Username = $user");
       	 	$c->stash->{username} = $user;
    		$c->stash(template => 'moss_customer.tt');
    		$c->forward('MltlOss::View::MltlOss');
	} else {
		# Redirect to Login
                $c->response->redirect('/');
        }

}

# Add Customer to DB
# Construct Add Chain
sub insert :Chained("base") : PathPart("add") Args(0) {
	my ( $self, $c ) = @_;
	my $log = $c->log;

	if ($c->session->{logged_in}) {
		# Send user details to the stash
		my $user = $c->session->{username};
                $c->stash->{username} = $user;

		# Check if form submitted
		if ($c->req->method eq 'POST') {
			# insert into DB
			my $customer = 	$c->model("MltlDB::MltlCustomer")->create({
					cust_name 	=> $c->req->param("custName"),
					email_add1 	=> $c->req->param("custEmail"),
					phone1		=> $c->req->param("custPhone"),
					address1	=> $c->req->param("address1"),	
					address2	=> $c->req->param("address2"),	
					city		=> $c->req->param("city"),	
					state		=> $c->req->param("city"),	
					account_manager => $c->req->param("accountManager")
					});
			# Serve customer added form
    			$c->stash(template => 'moss_customerAdded.tt');
    			$c->forward('MltlOss::View::MltlOss');
			
		} else {
			# serve customer add form
			$log->info("this is screwed");
    			$c->stash(template => 'moss_customerAdd.tt');
    			$c->forward('MltlOss::View::MltlOss');
		}

	} else {
		# Redirect to Login
		$c->response->redirect('/');
	}
}

# Submit search or display Search Form
# Construct /customers/search
sub search_form :Chained("base") : PathPart("search") Args(0) {
	my ($self, $c, $id) = @_;
	my $cust_id;
	my $log = $c->log;
	my $method = $c->req->method;
        if ($c->session->{logged_in}) {
        	my $user = $c->session->{username};
       	 	$c->stash->{username} = $user;

		if ($c->req->method eq 'POST') {
			# Form Submitted
			#my $searchcriteria = $c->req->param("searchOption");
                        #	if ($searchcriteria eq 'email') {
                                	$c->stash(custSearchResults => [$c->model('MltlDB::MltlCustomer')->search( {
                                                	-or => 	[ 	email_add1 =>  	$c->req->param("searchBox"), 
									email_add2 => 	$c->req->param("searchBox"),
									phone1 =>  $c->req->param("searchBox"),
									phone2 =>  $c->req->param("searchBox"),
									cust_name =>  $c->req->param("searchBox"),
									cust_id=>  $c->req->param("searchBox"),
								] })]);  

					my $rs = $c->model('MltlDB::MltlCustomer')->single( ( {
                                                        -or =>  [       email_add1 =>   $c->req->param("searchBox"),
                                                                        email_add2 =>   $c->req->param("searchBox"),
                                                                        phone1 =>  $c->req->param("searchBox"),
                                                                        phone2 =>  $c->req->param("searchBox"),
                                                                        cust_name =>  $c->req->param("searchBox"),
                                                                        cust_id=>  $c->req->param("searchBox"),
								] }));
					my $custid = $rs->cust_id;
					$log->info("Custid $custid ");
                                        $c->stash(custServiceResults => [$c->model('MltlDB::EnterpriseService')->search( {
                                                        customer_id => $custid })]);
					$c->stash(customerComments => [$c->model('MltlDB::CustomerComment')->search( {
							customer_id => $custid })]);
					

				# send results to the view
				$c->session->{cust_id} = $cust_id;
    				$c->stash(template => 'moss_customer_search_res.tt');
    				$c->forward('MltlOss::View::MltlOss');
		} else {
                		# serve customer search form
                		$c->stash->{page} = 'customer_search';
                		$c->forward('end');
        	}
	} else {
		# Redirect to Login
               	$c->response->redirect('/');
	}
}

# Search for IDs in path /customers/*

sub view :Chained('base') :PathPart('') Args(1) {
	my ($self, $c, $cust_id) = @_;
	my $log = $c->log;
        if ($c->session->{logged_in}) {
        	my $user = $c->session->{username};
       	 	$c->stash->{username} = $user;
		$c->stash(custSearchResults => [$c->model('MltlDB::MltlCustomer')->search( {
                                                        cust_id =>  $cust_id })]);
		$c->stash(custServiceResults => [$c->model('MltlDB::EnterpriseService')->search( {
							customer_id => $cust_id })]);
		$c->stash(customerComments => [$c->model('MltlDB::CustomerComment')->search( {
							customer_id => $cust_id })]);
		$c->session->{cust_id} = $cust_id;
    		$c->stash(template => 'moss_customer_search_res.tt');
    		$c->forward('MltlOss::View::MltlOss');
	} else {
		# Redirect to Login
               	$c->response->redirect('/');
	}

}

sub mod : Chained('base') :PathPart('') :CaptureArgs(1) { }

# Chain for path /customers/*/addcomment
sub addcomment : PathPart('addcomment') Chained('mod') Args(0) {
        my ($self, $c) = @_;
        my $log = $c->log;

        # Grab URI
        my $url = $c->req->uri;

        # Split URI to get the custid
        my @elements = split('/',$url);
        my $cust_id = $elements[4];


        if ($c->session->{logged_in}) {
                my $user = $c->session->{username};
                $c->stash->{username} = $user;

		# Get USERID from DB
		my $rs = $c->model('MltlDB::User')->single( ({
					username => $user }) );
		my $userid = $rs->user_id;


		if ($c->req->method eq 'POST') {
                        my $comment =  $c->model("MltlDB::CustomerComment")->create({
                                        customer_id     => $cust_id,
                                        comment_by	=> $userid,
                                        comment_detail	=> $c->req->param("commentBox")
                                        });
                        # Serve customer added form
                        #$c->stash(template => 'moss_commentAdded.tt');
                        #$c->forward('MltlOss::View::MltlOss');
			$c->response->redirect("/customers/$cust_id");

		}

	} else {
		# Redirect to Login
               	$c->response->redirect('/');

	}

}

# Chain for Path /customers/*/addservice
sub addservice : PathPart('addservice') Chained('mod') Args(0) {
	my ($self, $c) = @_;
	my $log = $c->log;

	# Grab URI
	my $url = $c->req->uri;
	
	# Split URI to get the custID
	my @elements = split('/',$url);
	my $cust_id = $elements[4];
	
	# Check if user is logged in
	if ($c->session->{logged_in}) {
		$c->stash->{username} = $c->session->{username};
		
		# Check if the form has been submitted
		if ($c->req->method eq 'POST') {
			
			# Insert Service details into the Database
			my $rs = $c->model('MltlDB::EnterpriseService')->create( {
				customer_id => $cust_id,
				service_description => $c->req->param("serviceDescription"),
				point_a => $c->req->param("pointA"),
				point_b => $c->req->param("pointB")
			});
			
			# Update the Comments
			my $pointA = $c->req->param("pointA");
			my $pointB = $c->req->param("pointB");
			my $rs = $c->model('MltlDB::CustomerComment')->create( {
				customer_id => $cust_id,
				comment_by => "2",
				comment_detail => "Service $pointA to $pointB added"
			});
			
			# Redirect to the customer view
			$c->repsonse->redirect("/customers/$cust_id");
			
		} else {
			
			# Dig out customer info from DB
			$c->stash(custSearchResults => [$c->model('MltlDB::MltlCustomer')->search( {
      	cust_id =>  $cust_id })]);
			$c->stash(custServiceResults => [$c->model('MltlDB::EnterpriseService')->search( {
				customer_id => $cust_id })]);
			$c->stash(customerComments => [$c->model('MltlDB::CustomerComment')->search( {
				customer_id => $cust_id })]);
			
			# Send customer_ID to the session
			$c->session->{cust_id} = $cust_id;
			
			# Display the customer page with the Service Add From
			$c->stash(template => 'moss_customerAddService.tt');
			$c->forward('MltlOss::View::MltlOss');
		}
	} else {
		# Redirect to Login
		$c->response->redirect('/');
	}
}

# Chain for path /customers/*/modify
sub edit : PathPart('edit') Chained('mod') Args(0) {
	my ($self, $c) = @_;
	my $log = $c->log;

	# Grab URI
	my $url = $c->req->uri;

	# Split URI to get the custid
	my @elements = split('/',$url);
	my $cust_id = $elements[4];

        if ($c->session->{logged_in}) {
                my $user = $c->session->{username};
                $c->stash->{username} = $user;
		$log->info("Customer ID is $cust_id");

		if ($c->req->method eq 'POST') {
                	my $rs = $c->model('MltlDB::MltlCustomer')->search( { cust_id => $cust_id });
                	$rs->update( {
                                cust_name       => $c->req->param("custName"),
                                email_add1      => $c->req->param("custEmail1"),
                                email_add2      => $c->req->param("custEmail2"),
                                phone1          => $c->req->param("custPhone1"),
                                phone2          => $c->req->param("custPhone2"),
                                address1        => $c->req->param("address1"),
                                address2        => $c->req->param("address2"),
                                city            => $c->req->param("city"),
                                state           => $c->req->param("state"),
                                account_manager => $c->req->param("accountManager")
                                        });
			$c->response->redirect("/customers/$cust_id");
		} else {
			# Pull out user info from the DB
			$c->stash(custSearchResults => [$c->model('MltlDB::MltlCustomer')->search( { cust_id =>  $cust_id })]);
			# Send to the view
                        $c->stash(template => 'moss_customerModify.tt');
                        $c->forward('MltlOss::View::MltlOss');
		}
	} else {
		# Redirect to Login
                $c->response->redirect('/');
	}
}


sub login :Local :Args(0) {
	my ( $self, $c ) = @_;
		# Redirect to Login
		$c->response->redirect('/');
}
	


=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
