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

# Construct Chain
# # Match the Root /site/
sub base :Chained("/") : PathPart("site") : CaptureArgs(0) { }

# Display the /site/
sub root : Chained("base") : PathPart("") : Args(0) {
        my ($self, $c, $id) = @_;
        my $log = $c->log;
	$log->info("TEST");
        if ($c->session->{logged_in}) {
          my $user = $c->session->{username};
          
          # Get User's ROLE
          my $rs = $c->model("MltlDB::User")->single( {
          	username => $user
          });
          my $role = $rs->role;
          
          $c->stash->{username} = $user;
          $c->stash->{role} = $role;
	        $c->stash(template => 'moss_sites.tt');
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

sub search_form :Chained("base") : PathPart("search") Args(0) {
	my ($self, $c, $id) = @_;
	my $cust_id;
	my $siteID;
	my $log = $c->log;
	my $method = $c->req->method;
  	if ($c->session->{logged_in}) {
    	my $user = $c->session->{username};
       
        # Get User's ROLE
          my $rs = $c->model("MltlDB::User")->single( {
          	username => $user
          });
          my $role = $rs->role;
          
          $c->stash->{username} = $user;
          $c->stash->{role} = $role;
          
			if ($c->req->method eq 'POST') {
				# Form Submitted
				my $rs = $c->model('MltlDB::MltlSite')->single( {
      		-or => 	[ site_reference => { like => $c->req->param("searchBox") }, 
      			  site_id	 => { like => $c->req->param("searchBox") },
									] });
				
				if ($rs != '') {					
				$c->stash->{siteSearchResults} = $rs;
				
				# Pull out any siteID
				$siteID = $rs->site_id;
				}

				# Redirect to siteID result
				$c->response->redirect("/site/$siteID");
			}
	
		} else {
		}
}

# Match URL /site/*
sub view :Chained('base') :PathPart('') Args(1) {
        my ($self, $c, $site_id) = @_;
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
          
		        $c->stash(siteSearchResults => [$c->model('MltlDB::MltlSite')->search( {
            	site_id =>  $site_id })]);
            $c->stash(siteComments => [$c->model('MltlDB::SiteComment')->search( {
            	site_id => $site_id })]);

            # Search for Links Associated with the site
            $c->stash(linksearchResults => [$c->model('MltlDB::Link')->search( {
                            -or => [    pointa_siteid => $site_id,
                                        pointb_siteid => $site_id,
                                        ]
                            })]);
                # Search for Comments for the site
                $c->session->{site_id} = $site_id;
                $c->stash(template => 'moss_site_search_res.tt');
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

# Match URL /site/add
sub insert :Chained("base") :PathPart("add") Args(0) {
        my ( $self, $c ) = @_;
        my $log = $c->log;

        if ($c->session->{logged_in}) {
                # Send user details to the stash
                my $user = $c->session->{username}; 
        # Get User's ROLE
          my $rs = $c->model("MltlDB::User")->single( {
          	username => $user
          });
          my $role = $rs->role;
          
          $c->stash->{username} = $user;
          $c->stash->{role} = $role;

                # Check if form submitted 
                if ($c->req->method eq 'POST') {

		            my $site = $c->model("MltlDB::MltlSite")->create({
			        site_reference 	=> $c->req->param("siteRef"),
			        gps_coords     	=> $c->req->param("gpsCoords"),
			        site_type	=> $c->req->param("siteType"),
			        site_name	=> $c->req->param("siteName"),
			        site_owner	=> $c->req->param("siteOwner")
		            });
                    $c->stash(template => 'moss_siteAdded.tt');
                    $c->forward('MltlOss::View::MltlOss');

		        } else {
		
		            # Serve the Add Form
                    $log->info("this is screwed");
                    $c->stash(template => 'moss_siteAdd.tt');
                    $c->forward('MltlOss::View::MltlOss');
		}
	} else {
                # Redirect to Login
  		my $url = $c->req->uri	;
			$log->info("Test: Referer : $url)");
			$c->stash->{url} = $url;
			$c->stash(template => "static/moss_login.tt");
			$c->forward('MltlOss::View::MltlOss');
	}
}

#   Subroutine searches for URL
#   /site/<siteID>/addcomment
#   The inputs the form details into the
#   siteComments table

sub mod : Chained("base") :PathPart('') :CaptureArgs(1) {}

sub editsite : Chained('mod') :PathPart('edit') Args(0) {
    my ($self, $c) = @_;
    my $log = $c->log;

    if ($c->session->{logged_in}) {
        # Send user details to the stash
        my $user = $c->session->{username};
        # Get User's ROLE
          my $rs = $c->model("MltlDB::User")->single( {
          	username => $user
          });
          my $role = $rs->role;
          
          $c->stash->{username} = $user;
          $c->stash->{role} = $role;

        # Grab URI
        my $url = $c->req->uri;
        # Split the URI to get the siteID
        my @elements = split('/',$url);
        my $site_id = $elements[4];
        
        if ($c->req->method eq 'POST') {

      	my $rs = $c->model('MltlDB::MltlSite')->search( { site_id => $site_id });
      	
				$rs->update( {
					site_reference	=> $c->req->param("siteReference"),
        	gps_coords	=> $c->req->param("gpsCoords"),
        	site_dependency	=> $c->req->param("siteDependency"),
        	site_type => $c->req->param("siteType"),
        	site_owner => $c->req->param("siteOwner"),
        	site_reference => $c->req->param("siteReference"),
        	site_name => $c->req->param("siteName")
        });
       
				# Redirect to the customer view
				$c->response->redirect("/site/$site_id");        	
        	
        } else {
        	
 				# Pull out site info from the DB
				$c->stash(siteSearchResults => [$c->model('MltlDB::MltlSite')->search( { site_id =>  $site_id })]);
				
				# Search for ALL the sites.
				$c->stash(allSites => [$c->model('MltlDB::MltlSite')->search( { 
					site_id => { like => '%' } } )]);
        	
        	# Serve the Site Update Form
				
					# Send to the view
          $c->stash(template => 'moss_siteModify.tt');
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

sub addsitecomment : Chained('mod') :PathPart('addcomment') Args(0) {
    my ($self, $c) = @_;
    my $log = $c->log;

    if ($c->session->{logged_in}) {
        # Send user details to the stash
        my $user = $c->session->{username};
        # Get User's ROLE
          my $rs = $c->model("MltlDB::User")->single( {
          	username => $user
          });
          my $role = $rs->role;
          
          $c->stash->{username} = $user;
          $c->stash->{role} = $role;

        # Grab URI
        my $url = $c->req->uri;
        # Split the URI to get the siteID
        my @elements = split('/',$url);
        my $site_id = $elements[4];

        # Get USERID from DB
        my $rs = $c->model('MltlDB::User')->single( ({
             username => $user }) );
        my $userid = $rs->user_id;
        
        if ($c->req->method eq 'POST') {
            my $comment =  $c->model("MltlDB::SiteComment")->create({
                site_id     => $site_id,
                comment_by  => $userid,
                comment_detail  => $c->req->param("commentBox")
                });

            # Redirect back to site information
            $c->response->redirect("/site/$site_id");
        }
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
