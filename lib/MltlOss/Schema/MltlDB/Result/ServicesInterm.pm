package MltlOss::Schema::MltlDB::Result::ServicesInterm;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

MltlOss::Schema::MltlDB::Result::ServicesInterm

=cut

__PACKAGE__->table("services_interm");

=head1 ACCESSORS

=head2 interm_id

  data_type: INT
  default_value: undef
  is_auto_increment: 1
  is_nullable: 0
  size: 11

=head2 service_id

  data_type: INT
  default_value: undef
  is_foreign_key: 1
  is_nullable: 0
  size: 11

=head2 customer_id

  data_type: INT
  default_value: undef
  is_foreign_key: 1
  is_nullable: 0
  size: 11

=head2 site_id

  data_type: INT
  default_value: undef
  is_foreign_key: 1
  is_nullable: 0
  size: 11

=cut

__PACKAGE__->add_columns(
  "interm_id",
  {
    data_type => "INT",
    default_value => undef,
    is_auto_increment => 1,
    is_nullable => 0,
    size => 11,
  },
  "service_id",
  {
    data_type => "INT",
    default_value => undef,
    is_foreign_key => 1,
    is_nullable => 0,
    size => 11,
  },
  "customer_id",
  {
    data_type => "INT",
    default_value => undef,
    is_foreign_key => 1,
    is_nullable => 0,
    size => 11,
  },
  "site_id",
  {
    data_type => "INT",
    default_value => undef,
    is_foreign_key => 1,
    is_nullable => 0,
    size => 11,
  },
);
__PACKAGE__->set_primary_key("interm_id");

=head1 RELATIONS

=head2 customer

Type: belongs_to

Related object: L<MltlOss::Schema::MltlDB::Result::MltlCustomer>

=cut

__PACKAGE__->belongs_to(
  "customer",
  "MltlOss::Schema::MltlDB::Result::MltlCustomer",
  { cust_id => "customer_id" },
  {},
);

=head2 service

Type: belongs_to

Related object: L<MltlOss::Schema::MltlDB::Result::EnterpriseService>

=cut

__PACKAGE__->belongs_to(
  "service",
  "MltlOss::Schema::MltlDB::Result::EnterpriseService",
  { service_id => "service_id" },
  {},
);

=head2 site

Type: belongs_to

Related object: L<MltlOss::Schema::MltlDB::Result::MltlSite>

=cut

__PACKAGE__->belongs_to(
  "site",
  "MltlOss::Schema::MltlDB::Result::MltlSite",
  { site_id => "site_id" },
  {},
);


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2011-11-21 21:25:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:eAyuuJYIawUb3VfnhhvRDQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;