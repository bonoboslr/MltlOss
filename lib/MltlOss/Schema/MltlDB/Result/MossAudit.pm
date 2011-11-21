package MltlOss::Schema::MltlDB::Result::MossAudit;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

MltlOss::Schema::MltlDB::Result::MossAudit

=cut

__PACKAGE__->table("moss_audit");

=head1 ACCESSORS

=head2 action_id

  data_type: INT
  default_value: undef
  is_auto_increment: 1
  is_nullable: 0
  size: 10

=head2 action_by

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 45

=head2 action_date

  data_type: TIMESTAMP
  default_value: CURRENT_TIMESTAMP
  is_nullable: 0
  size: 14

=head2 action_type

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 45

=head2 previous_value

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 120

=head2 new_value

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 120

=cut

__PACKAGE__->add_columns(
  "action_id",
  {
    data_type => "INT",
    default_value => undef,
    is_auto_increment => 1,
    is_nullable => 0,
    size => 10,
  },
  "action_by",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 45,
  },
  "action_date",
  {
    data_type => "TIMESTAMP",
    default_value => \"CURRENT_TIMESTAMP",
    is_nullable => 0,
    size => 14,
  },
  "action_type",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 45,
  },
  "previous_value",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 120,
  },
  "new_value",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 120,
  },
);
__PACKAGE__->set_primary_key("action_id");


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2011-11-21 09:19:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:l+jOvKBxfYilrbDJtvO4Nw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
