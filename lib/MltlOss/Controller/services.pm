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

# Construct Chain
# Match the Root and display /services/
sub base :Chained("/") : PathPart("service") : CaptureArgs(0) { }

sub root : Chained("base") : PathPart("") : Args(0) {
        my ($self, $c, $id) = @_;
        my $log = $c->log;
        if ($c->session->{logged_in}) {
                my $user = $c->session->{username};
                $c->stash->{username} = $user;
                $c->stash(template => 'moss_service.tt');
                $c->forward('MltlOss::View::MltlOss');
        } else {
                # Redirect to Login
                $c->response->redirect('/');
        }
}

sub view : Chained('base') : PathPart('') Args(1) {
        my ($self, $c, $serviceid) = @_;
        my $log = $c->log;
	my @siteset;
	my @linkset;

        if ($c->session->{logged_in}) {
		# Send Username to the stash
                my $user = $c->session->{username};
                $c->stash->{username} = $user;
		
		# Search for Services
		my $rs = $c->model('MltlDB::EnterpriseService')->search( {
                                                        service_id => $serviceid });
                #$c->stash(custServiceResults => [$c->model('MltlDB::EnterpriseService')->search( {
               	                                    #service_id => $serviceid })]);
		@{$c->stash->{custServiceResults}} = $rs->next;

		# link services to links
		my $rs = $c->model('MltlDB::ServicesInterm')->search( {
                                         service_id => $serviceid, });
		while (my $u = $rs->next) {
			#push(@siteset, $u->site);
			push(@linkset, $u->link);
		
		}
		
		# get the comments for this service
		#$c->stash->(serviceComments = [$c->model('MltlDB::ServiceCommnets')->search( {
		#				service_id => $serviceid})]);

		# Send link info to the stash
		# @{$c->stash->{sites}} = @siteset;
		$log->info("@linkset");
		@{$c->stash->{links}} = @linkset;

		# Send page name and send to the template
                $c->session->{service_id} = $serviceid;
                $c->stash(template => 'moss_service_search_res.tt');
                $c->forward('MltlOss::View::MltlOss');
	} else {
		# Redirect to Login
                $c->response->redirect('/');
        }
}

sub mod : Chained('base') : PathPart('') CaptureArgs(1) { }

sub editservice : Chained('mod') :PathPart('edit') Args(0) {
	my ($self, $c) = @_;
	my $log = $c->log;
	
	# Grab URI
	my $url = $c->req->uri;
	
	# Split URI to get the custID
	my @elements = split('/',$url);
	my $service_id = $elements[4];
	
	# Check if user is logged in
	if ($c->session->{logged_in}) {
		$c->stash->{username} = $c->session->{username};
		
		# Check if form is submitted
		if ($c->req->method eq "POST") {
			
			# Find Row in table.
			my $rs = $c->model('MltlDB::EnterpriseService')->search( { service_id => $service_id } );
			
			# Update the table with the form elements
			$rs->update( {
				customer_id => $c->req->param("custID"),
				service_description => $c->req->param("serviceDescription"),
				point_a => $c->req->param("pointA"),
				point_b => $c->req->param("pointB")
			} );
				
				# Redirect to the service view
				$c->response->redirect("/service/$service_id");		
		
		} else {
		
		# Get all customers from DB - 
				$c->stash(customerResults => [$c->model('MltlDB::MltlCustomer')->search( { 
					cust_id => { like => '%' } } )
				]);
				
		# Get all the services from DB
		$c->stash(serviceResults => [$c->model('MltlDB::EnterpriseService')->search( { service_id => $service_id } )]);
				
		# Display the edit form.
		$c->stash(template => 'moss_serviceModify.tt');
		$c->forward('MltlOss::View::MltlOss');		
		
		}
		
	} else {
		my $url = $c->req->uri	;
		$log->info("Test: Referer : $url)");
		$c->stash->{url} = $url;
		$c->stash(template => "static/moss_login.tt");
		$c->forward('MltlOss::View::MltlOss');	
	}
}

sub addlink : Chained('mod') :PathPart('addlink') Args(0) {
	my ($self, $c, $serviceid) = @_;
	my $log = $c->log;
		
		# Grab URI
		my $url = $c->req->uri;
	
		# Split URI to get the custID
		my @elements = split('/',$url);
		my $service_id = $elements[4];
	
		# Check if user is logged in
		if ($c->session->{logged_in}) {
			$c->stash->{username} = $c->session->{username};
			
				if ($c->req->method eq "POST") {
					
					# Form Submitted
					# The details submitted here need to be entered into the 
					# intermediary table
					
					$c->model('MltlDB::ServicesInterm')->create( {
						service_id => $service_id,
						link_id => $c->req->param("link")
					});
					
					$c->response->redirect("/service/$service_id");
		
				} else {
		
					# Search for Existing Service Details
					# in the Enterprise Services table
					my $rs = $c->model('MltlDB::EnterpriseService')->search( {
   				service_id => $service_id });

					@{$c->stash->{custServiceResults}} = $rs->next;
		
					# Pull out all the links - Hacky, but will improve with Location awareness on next release
					$c->stash(linkSearchResults => [$c->model('MltlDB::Link')->search( { 
					link_id => { like => '%' } } )
				]);
		
					# Send to Stash
					# Send to View
					$c->stash(template => 'moss_serviceAddLink.tt');
					$c->forward('MltlOss::View::MltlOss');
				}
		}  else {
		# Redirect to Login
  	$c->response->redirect('/');
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
