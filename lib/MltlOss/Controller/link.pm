package MltlOss::Controller::link;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

MltlOss::Controller::link - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

# # Match the Root /link/
sub linkbase :Chained("/") : PathPart("link") : CaptureArgs(0) { }

# Match the URL /link/*
sub view :	Chained("linkbase") : PathPart("") Args(1) {
	my ($self, $c, $linkid) = @_;
	my @serviceset;
	my $log = $c->log;
	
	if ($c->session->{logged_in}) {
	
		# Search for links in the DB
		my $rs = $c->model("MltlDB::Link")->search( {
			link_id => $linkid
		});
	
		# Send to the stash
		@{$c->stash->{linkSearchResults}} = $rs->next;
	
		# LInk the links to serviceset
		$rs = $c->model('MltlDB::ServicesInterm')->search( {
			link_id => $linkid
		});
	
		while(my $u = $rs->next) {
			push(@serviceset, $u->service);
		}
	
		# Derference and Send to the Stash
		@{$c->stash->{services}} = @serviceset;
	
		# Get all the comments for the link
		$c->stash(linkComments => [$c->model('MltlDB::LinkComment')->search( {
			link_id => $linkid
		})]);
	
		# Forward all to the view
		$c->session->{link_id} = $linkid;
		$c->stash(template => 'moss_link_search_res.tt');
		$c->forward('MltlOss::View::MltlOss');
	} else {
		
		# Redirect to Login Page
		my $url = $c->req->uri	;
		$log->info("Test: Referer : $url)");
		$c->stash->{url} = $url;
		$c->stash(template => "static/moss_login.tt");
		$c->forward('MltlOss::View::MltlOss');
	}
	
}

sub mod :	Chained("linkbase") : PathPart("") : CaptureArgs(1) {}
sub edit : Chained("mod") :PathPart("edit") Args(0) {
	my ($self, $c) = @_;
	my $log = $c->log;

	# Grab URI
	my $url = $c->req->uri;
	
	# Split URI to get the custID
	my @elements = split('/',$url);
	my $link_id = $elements[4];
	
	# Check if user is logged in
	if ($c->session->{logged_in}) {
		$c->stash->{username} = $c->session->{username};
		
		# Check if the form has been submitted
		if ($c->req->method eq 'POST') {
			
      	my $rs = $c->model('MltlDB::Link')->search( { link_id => $link_id });
      	
				$rs->update( {
					pointa_siteid	=> $c->req->param("siteA"),
        	pointb_siteid	=> $c->req->param("siteB"),
        	owner	=> $c->req->param("owner"),
        	speed => $c->req->param("speed"),
        	link_type => $c->req->param("linkType"),
        	link_description => $c->req->param("linkDescription"),
        	contact => $c->req->param("contact"),
        	contact_phone => $c->req->param("contactPhone")
        });
       
				# Redirect to the customer view
				$c->response->redirect("/link/$link_id");
			
			} else {
				# Display the FORM
				
				# Pull out link info from the DB
				$c->stash(linkSearchResults => [$c->model('MltlDB::Link')->search( { link_id =>  $link_id })]);
				
				# Search for ALL the sites.
				$c->stash(siteSearchResults => [$c->model('MltlDB::MltlSite')->search( { 
					site_id => { like => '%' } } )
				]);
				
				# Send to the view
                        $c->stash(template => 'moss_linkModify.tt');
                        $c->forward('MltlOss::View::MltlOss');
				
			}
		} else {
			my $url = $c->req->uri	;
			$log->info("Test: Referer : $url)");
			$c->stash->{url} = $url;
			$c->stash(template => "static/moss_login.tt");
			$c->forward('MltlOss::View::MltlOss');
			# Redirect to Login Page
			$c->response->redirect('/');
	
		}
}

# Match /link/add
sub insert :Chained("linkbase") :PathPart("add") Args(0) {
	my ($self, $c) = @_;
	my $log = $c->log;

	if ($c->session->{logged_in}) {
		# Send User details to the stashh
		$c->stash->{username} = $c->session->{username};
		
		# Check if form has been submitted
		if ($c->req->method eq "POST") {
			
			# Insert Record into the Database
				#$c->model("MltlDB::Link")->create( {
				my $link_entry = $c->model("MltlDB::Link")->create( {
				contact => $c->req->param("linkContact"),
				contact_phone => $c->req->param("contactPhone"),
				link_description => $c->req->param("linkName"),
				speed => $c->req->param("linkSpeed"),
				owner => $c->req->param("linkOwner"),
				link_type => $c->req->param("linkType"),
				pointa_siteid => $c->req->param("siteA"),
				pointb_siteid => $c->req->param("siteB")
			});
			
			# Send to the stash 
			$c->stash(template => "moss_linkAdded.tt");
			$c->forward('MltlOss::View::MltlOss');

		} else {
		
			# Search for ALL the sites.
			$c->stash(siteSearchResults => [$c->model('MltlDB::MltlSite')->search( { 
				site_id => { like => '%' } } )
			]);
			
			# Display the Link ADD Form
			$c->stash(template => "moss_linkAdd.tt");
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
=head1 AUTHOR

Scott

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
