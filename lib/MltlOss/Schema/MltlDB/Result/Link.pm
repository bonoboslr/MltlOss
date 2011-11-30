package MltlOss::Schema::MltlDB::Result::Link;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

MltlOss::Schema::MltlDB::Result::Link

=cut

__PACKAGE__->table("links");

=head1 ACCESSORS

=head2 link_id

  data_type: INT
  default_value: undef
  is_auto_increment: 1
  is_nullable: 0
  size: 11

=head2 pointa_siteid

  data_type: INT
  default_value: undef
  is_foreign_key: 1
  is_nullable: 1
  size: 11

=head2 pointb_siteid

  data_type: INT
  default_value: undef
  is_foreign_key: 1
  is_nullable: 1
  size: 11

=head2 owner

  data_type: VARCHAR
  default_value: mltl
  is_nullable: 1
  size: 45

=head2 speed

  data_type: DECIMAL
  default_value: 0
  is_nullable: 1
  size: 15

=head2 status

  data_type: VARCHAR
  default_value: ACTIVE
  is_nullable: 1
  size: 45

=head2 contact

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 45

=head2 contact_phone

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 15

=head2 link_description

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 150

=head2 link_type

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "link_id",
  {
    data_type => "INT",
    default_value => undef,
    is_auto_increment => 1,
    is_nullable => 0,
    size => 11,
  },
  "pointa_siteid",
  {
    data_type => "INT",
    default_value => undef,
    is_foreign_key => 1,
    is_nullable => 1,
    size => 11,
  },
  "pointb_siteid",
  {
    data_type => "INT",
    default_value => undef,
    is_foreign_key => 1,
    is_nullable => 1,
    size => 11,
  },
  "owner",
  {
    data_type => "VARCHAR",
    default_value => "mltl",
    is_nullable => 1,
    size => 45,
  },
  "speed",
  { data_type => "DECIMAL", default_value => 0, is_nullable => 1, size => 15 },
  "status",
  {
    data_type => "VARCHAR",
    default_value => "ACTIVE",
    is_nullable => 1,
    size => 45,
  },
  "contact",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 45,
  },
  "contact_phone",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 15,
  },
  "link_description",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 150,
  },
  "link_type",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 45,
  },
);
__PACKAGE__->set_primary_key("link_id");

=head1 RELATIONS

=head2 pointa_siteid

Type: belongs_to

Related object: L<MltlOss::Schema::MltlDB::Result::MltlSite>

=cut

__PACKAGE__->belongs_to(
  "pointa_siteid",
  "MltlOss::Schema::MltlDB::Result::MltlSite",
  { site_id => "pointa_siteid" },
  { join_type => "LEFT" },
);

=head2 pointb_siteid

Type: belongs_to

Related object: L<MltlOss::Schema::MltlDB::Result::MltlSite>

=cut

__PACKAGE__->belongs_to(
  "pointb_siteid",
  "MltlOss::Schema::MltlDB::Result::MltlSite",
  { site_id => "pointb_siteid" },
  { join_type => "LEFT" },
);

=head2 services_interms

Type: has_many

Related object: L<MltlOss::Schema::MltlDB::Result::ServicesInterm>

=cut

__PACKAGE__->has_many(
  "services_interms",
  "MltlOss::Schema::MltlDB::Result::ServicesInterm",
  { "foreign.link_id" => "self.link_id" },
);


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2011-11-30 11:55:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4zdJOv4Q1/3i+8MYIMv+cw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
