package MltlOss::Schema::MltlDB::Result::EnterpriseService;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

MltlOss::Schema::MltlDB::Result::EnterpriseService

=cut

__PACKAGE__->table("enterprise_services");

=head1 ACCESSORS

=head2 service_id

  data_type: INT
  default_value: undef
  is_auto_increment: 1
  is_nullable: 0
  size: 11

=head2 customer_id

  data_type: INT
  default_value: undef
  is_foreign_key: 1
  is_nullable: 0
  size: 11

=head2 request_date

  data_type: DATETIME
  default_value: undef
  is_nullable: 1
  size: 19

=head2 activation_date

  data_type: DATETIME
  default_value: undef
  is_nullable: 1
  size: 19

=head2 modification_date

  data_type: DATETIME
  default_value: undef
  is_nullable: 1
  size: 19

=head2 service_description

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 120

=head2 point_a

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 100

=head2 point_b

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 100

=head2 point_a_coords

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 45

=head2 point_b_coords

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 45

=head2 service_status

  data_type: VARCHAR
  default_value: ACTIVE
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "service_id",
  {
    data_type => "INT",
    default_value => undef,
    is_auto_increment => 1,
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
  "request_date",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "activation_date",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "modification_date",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "service_description",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 120,
  },
  "point_a",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "point_b",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "point_a_coords",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 45,
  },
  "point_b_coords",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 45,
  },
  "service_status",
  {
    data_type => "VARCHAR",
    default_value => "ACTIVE",
    is_nullable => 1,
    size => 45,
  },
);
__PACKAGE__->set_primary_key("service_id");

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

=head2 services_interms

Type: has_many

Related object: L<MltlOss::Schema::MltlDB::Result::ServicesInterm>

=cut

__PACKAGE__->has_many(
  "services_interms",
  "MltlOss::Schema::MltlDB::Result::ServicesInterm",
  { "foreign.service_id" => "self.service_id" },
);


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2011-11-21 21:25:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5xmXqTxjdmaZE5bCr9wWKw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
