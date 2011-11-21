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

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

	if ($c->session->{logged_in}) {
		my $user = $c->session->{username};
                $c->stash->{username} = $user;
    		$c->stash->{page} = 'customer_info';
    		$c->stash(template => 'static/header.tt');
    		$c->forward('MltlOss::View::MltlOss');
	} else {
		$c->response->redirect('/');
	}
}

# Construct Chain
sub base :Chained("/") : PathPart("customers") :CaptureArgs(0) {
}

# Display Root
sub root :Chained("base") : PathPart("") Args(0) {
	my ($self, $c, $id) = @_;
	my $log = $c->log;
        if ($c->session->{logged_in}) {
        	my $user = $c->session->{username};
       	 	$c->stash->{username} = $user;
                $c->stash->{page} = 'customer_info';
        	$c->forward('end');
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
			$c->stash->{page} = 'customer_added';
			$c->forward('end');
			
		} else {
			# serve customer add form
    			$c->stash->{page} = 'customer_add';
			$c->forward('end');
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
			my $searchcriteria = $c->req->param("searchOption");
                        $c->stash(custSearchResults => [$c->model('MltlDB::MltlCustomer')->search( { email_add1 =>  $c->req->param("email") })]);
                        	if ($searchcriteria eq 'email') {
                                	$c->stash(custSearchResults => [$c->model('MltlDB::MltlCustomer')->search( {
                                                	-or => [ email_add1 =>  $c->req->param("searchBox"), email_add2 => $c->req->param("searchBox")] })]);  
				} elsif ($searchcriteria eq 'phone') { 
					$c->stash(custSearchResults => [$c->model('MltlDB::MltlCustomer')->search( { 
							-or => [ phone1 =>  $c->req->param("searchBox"), phone2 => $c->req->param("searchBox")] })]); 
				} elsif ($searchcriteria eq 'id') { 
					$c->stash(custSearchResults => [$c->model('MltlDB::MltlCustomer')->search( { cust_id =>  $c->req->param("searchBox") })]); 
				} else { 
					$c->stash(custSearchResults => [$c->model('MltlDB::MltlCustomer')->search( { cust_name =>  $c->req->param("searchBox") })]); 
				} 
				
				# Find CustomerID

				# send results to the view
				$c->session->{cust_id} = $cust_id;
				$c->stash->{page} = 'customer_search_res'; 
				$c->forward('end'); 
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
        	$c->stash->{page} = 'customer_search_res';
		$c->session->{cust_id} = $cust_id;
        	$c->forward('end');
	} else {
		# Redirect to Login
               	$c->response->redirect('/');
	}

}

# Chain for path /customers/*/modify 
sub mod : Chained('base') :PathPart('') :CaptureArgs(1) {
	

}

sub edit : PathPart('edit') Chained('mod') Args(0) {
	my ($self, $c) = @_;
	my $log = $c->log;
	my $url = $c->req->uri;
	my @elements = split('/',$url);
	$log->info("URL - $url");
	my $cust_id = $elements[4];

        if ($c->session->{logged_in}) {
                my $user = $c->session->{username};
                $c->stash->{username} = $user;
		$log->info("Customer ID is $cust_id");

		if ($c->req->method eq 'POST') {
                	my $rs = $c->model('MltlDB::MltlCustomer')->search( { cust_id => $c->req->param("cust_id") });
                	$rs->update( {
                                cust_name       => $c->req->param("custName"),
                                email_add1      => $c->req->param("custEmail1"),
                                email_add2      => $c->req->param("custEmail2"),
                                phone1          => $c->req->param("custPhone1"),
                                phone2          => $c->req->param("custPhone2"),
                                address1        => $c->req->param("address1"),
                                address2        => $c->req->param("address2"),
                                city            => $c->req->param("state"),
                                state           => $c->req->param("city"),
                                account_manager => $c->req->param("accountManager")
                                        });
			$c->response->redirect("/customers/$cust_id");
		} else {
			# Pull out user info from the DB
			$c->stash(custSearchResults => [$c->model('MltlDB::MltlCustomer')->search( { cust_id =>  $cust_id })]);
			# Send to the view
			$c->stash->{page} = 'customer_modify';
                	$c->forward('end');
		}
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
