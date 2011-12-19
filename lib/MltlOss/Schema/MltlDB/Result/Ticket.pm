package MltlOss::Schema::MltlDB::Result::Ticket;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

MltlOss::Schema::MltlDB::Result::Ticket

=cut

__PACKAGE__->table("tickets");

=head1 ACCESSORS

=head2 ticket_id

  data_type: INT
  default_value: undef
  is_auto_increment: 1
  is_nullable: 0
  size: 11

=head2 owner

  data_type: INT
  default_value: undef
  is_foreign_key: 1
  is_nullable: 1
  size: 11

=head2 creator

  data_type: INT
  default_value: undef
  is_foreign_key: 1
  is_nullable: 1
  size: 11

=head2 title

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 200

=head2 status

  data_type: INT
  default_value: undef
  is_foreign_key: 1
  is_nullable: 1
  size: 11

=head2 created

  data_type: DATETIME
  default_value: undef
  is_nullable: 1
  size: 19

=head2 lastupdated

  data_type: DATETIME
  default_value: undef
  is_nullable: 1
  size: 19

=head2 priority

  data_type: INT
  default_value: undef
  is_nullable: 1
  size: 11

=head2 due

  data_type: DATETIME
  default_value: undef
  is_nullable: 1
  size: 19

=head2 resolved

  data_type: DATETIME
  default_value: undef
  is_nullable: 1
  size: 19

=head2 group

  data_type: INT
  default_value: undef
  is_foreign_key: 1
  is_nullable: 1
  size: 11

=cut

__PACKAGE__->add_columns(
  "ticket_id",
  {
    data_type => "INT",
    default_value => undef,
    is_auto_increment => 1,
    is_nullable => 0,
    size => 11,
  },
  "owner",
  {
    data_type => "INT",
    default_value => undef,
    is_foreign_key => 1,
    is_nullable => 1,
    size => 11,
  },
  "creator",
  {
    data_type => "INT",
    default_value => undef,
    is_foreign_key => 1,
    is_nullable => 1,
    size => 11,
  },
  "title",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 200,
  },
  "status",
  {
    data_type => "INT",
    default_value => undef,
    is_foreign_key => 1,
    is_nullable => 1,
    size => 11,
  },
  "created",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "lastupdated",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "priority",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "due",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "resolved",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "group",
  {
    data_type => "INT",
    default_value => undef,
    is_foreign_key => 1,
    is_nullable => 1,
    size => 11,
  },
);
__PACKAGE__->set_primary_key("ticket_id");

=head1 RELATIONS

=head2 status

Type: belongs_to

Related object: L<MltlOss::Schema::MltlDB::Result::TicketStatus>

=cut

__PACKAGE__->belongs_to(
  "status",
  "MltlOss::Schema::MltlDB::Result::TicketStatus",
  { ticketstatus_id => "status" },
  { join_type => "LEFT" },
);

=head2 creator

Type: belongs_to

Related object: L<MltlOss::Schema::MltlDB::Result::User>

=cut

__PACKAGE__->belongs_to(
  "creator",
  "MltlOss::Schema::MltlDB::Result::User",
  { user_id => "creator" },
  { join_type => "LEFT" },
);

=head2 group

Type: belongs_to

Related object: L<MltlOss::Schema::MltlDB::Result::Group>

=cut

__PACKAGE__->belongs_to(
  "group",
  "MltlOss::Schema::MltlDB::Result::Group",
  { group_id => "group" },
  { join_type => "LEFT" },
);

=head2 owner

Type: belongs_to

Related object: L<MltlOss::Schema::MltlDB::Result::User>

=cut

__PACKAGE__->belongs_to(
  "owner",
  "MltlOss::Schema::MltlDB::Result::User",
  { user_id => "owner" },
  { join_type => "LEFT" },
);


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2011-12-06 15:15:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:AxPyjd1ecQj/Yo3btT2piw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
