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
  extra: HASH(0x986db18)
  is_auto_increment: 1
  is_nullable: 0
  size: 10

=head2 customer_id

  data_type: INT
  default_value: undef
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

=cut

__PACKAGE__->add_columns(
  "service_id",
  {
    data_type => "INT",
    default_value => undef,
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
    size => 10,
  },
  "customer_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
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
);
__PACKAGE__->set_primary_key("service_id");


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2011-11-21 09:19:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:d/jRXdRHQjGtrJUD8XM6hw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
