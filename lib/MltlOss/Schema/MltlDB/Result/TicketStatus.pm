package MltlOss::Schema::MltlDB::Result::TicketStatus;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

MltlOss::Schema::MltlDB::Result::TicketStatus

=cut

__PACKAGE__->table("ticket_status");

=head1 ACCESSORS

=head2 ticketstatus_id

  data_type: INT
  default_value: undef
  is_auto_increment: 1
  is_nullable: 0
  size: 11

=head2 name

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 50

=head2 description

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 150

=cut

__PACKAGE__->add_columns(
  "ticketstatus_id",
  {
    data_type => "INT",
    default_value => undef,
    is_auto_increment => 1,
    is_nullable => 0,
    size => 11,
  },
  "name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 50,
  },
  "description",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 150,
  },
);
__PACKAGE__->set_primary_key("ticketstatus_id");

=head1 RELATIONS

=head2 tickets

Type: has_many

Related object: L<MltlOss::Schema::MltlDB::Result::Ticket>

=cut

__PACKAGE__->has_many(
  "tickets",
  "MltlOss::Schema::MltlDB::Result::Ticket",
  { "foreign.status" => "self.ticketstatus_id" },
);


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2011-12-06 15:15:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9qYuKNhFMFhl1O8T1JTCUA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
