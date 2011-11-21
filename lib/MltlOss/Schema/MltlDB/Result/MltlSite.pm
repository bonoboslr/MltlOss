package MltlOss::Schema::MltlDB::Result::MltlSite;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

MltlOss::Schema::MltlDB::Result::MltlSite

=cut

__PACKAGE__->table("mltl_sites");

=head1 ACCESSORS

=head2 site_id

  data_type: INT
  default_value: undef
  is_auto_increment: 1
  is_nullable: 0
  size: 11

=head2 site_reference

  data_type: VARCHAR
  default_value: undef
  is_nullable: 0
  size: 45

=head2 gps_coords

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 45

=head2 site_dependency

  data_type: INT
  default_value: undef
  is_nullable: 1
  size: 11

=head2 site_type

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 45

=head2 site_name

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 100

=cut

__PACKAGE__->add_columns(
  "site_id",
  {
    data_type => "INT",
    default_value => undef,
    is_auto_increment => 1,
    is_nullable => 0,
    size => 11,
  },
  "site_reference",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 45,
  },
  "gps_coords",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 45,
  },
  "site_dependency",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "site_type",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 45,
  },
  "site_name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
);
__PACKAGE__->set_primary_key("site_id");
__PACKAGE__->add_unique_constraint("site_reference_UNIQUE", ["site_reference"]);

=head1 RELATIONS

=head2 services_interms

Type: has_many

Related object: L<MltlOss::Schema::MltlDB::Result::ServicesInterm>

=cut

__PACKAGE__->has_many(
  "services_interms",
  "MltlOss::Schema::MltlDB::Result::ServicesInterm",
  { "foreign.site_id" => "self.site_id" },
);


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2011-11-21 21:25:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:VCwThx5B2BxKEtoa/iTGpQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;