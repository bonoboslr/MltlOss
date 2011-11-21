package MltlOss::Schema::MltlDB::Result::MltlCustomer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

MltlOss::Schema::MltlDB::Result::MltlCustomer

=cut

__PACKAGE__->table("mltl_customers");

=head1 ACCESSORS

=head2 cust_id

  data_type: INT
  default_value: undef
  is_auto_increment: 1
  is_nullable: 0
  size: 10

=head2 cust_name

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 20

=head2 address1

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 50

=head2 address2

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 50

=head2 city

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 15

=head2 state

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 15

=head2 country

  data_type: VARCHAR
  default_value: Nigeria
  is_nullable: 1
  size: 15

=head2 phone1

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 20

=head2 phone2

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 20

=head2 email_add1

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 70

=head2 email_add2

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 70

=head2 account_manager

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 6

=cut

__PACKAGE__->add_columns(
  "cust_id",
  {
    data_type => "INT",
    default_value => undef,
    is_auto_increment => 1,
    is_nullable => 0,
    size => 10,
  },
  "cust_name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 20,
  },
  "address1",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 50,
  },
  "address2",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 50,
  },
  "city",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 15,
  },
  "state",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 15,
  },
  "country",
  {
    data_type => "VARCHAR",
    default_value => "Nigeria",
    is_nullable => 1,
    size => 15,
  },
  "phone1",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 20,
  },
  "phone2",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 20,
  },
  "email_add1",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 70,
  },
  "email_add2",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 70,
  },
  "account_manager",
  { data_type => "VARCHAR", default_value => undef, is_nullable => 1, size => 6 },
);
__PACKAGE__->set_primary_key("cust_id");

=head1 RELATIONS

=head2 enterprise_services

Type: has_many

Related object: L<MltlOss::Schema::MltlDB::Result::EnterpriseService>

=cut

__PACKAGE__->has_many(
  "enterprise_services",
  "MltlOss::Schema::MltlDB::Result::EnterpriseService",
  { "foreign.customer_id" => "self.cust_id" },
);

=head2 services_interms

Type: has_many

Related object: L<MltlOss::Schema::MltlDB::Result::ServicesInterm>

=cut

__PACKAGE__->has_many(
  "services_interms",
  "MltlOss::Schema::MltlDB::Result::ServicesInterm",
  { "foreign.customer_id" => "self.cust_id" },
);


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2011-11-21 21:25:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:P89zxRCzA7cEqkY4YqYZfw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
