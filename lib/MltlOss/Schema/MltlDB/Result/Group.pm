package MltlOss::Schema::MltlDB::Result::Group;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

MltlOss::Schema::MltlDB::Result::Group

=cut

__PACKAGE__->table("groups");

=head1 ACCESSORS

=head2 group_id

  data_type: INT
  default_value: undef
  is_auto_increment: 1
  is_nullable: 0
  size: 11

=head2 group_name

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 45

=head2 group_description

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 150

=cut

__PACKAGE__->add_columns(
  "group_id",
  {
    data_type => "INT",
    default_value => undef,
    is_auto_increment => 1,
    is_nullable => 0,
    size => 11,
  },
  "group_name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 45,
  },
  "group_description",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 150,
  },
);
__PACKAGE__->set_primary_key("group_id");


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2011-11-25 09:30:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mXB6zgmjJsP6WiXIYXasxQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
