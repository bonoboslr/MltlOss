package MltlOss::Schema::MltlDB::Result::UserGroup;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

MltlOss::Schema::MltlDB::Result::UserGroup

=cut

__PACKAGE__->table("user_groups");

=head1 ACCESSORS

=head2 user_id

  data_type: INT
  default_value: undef
  is_nullable: 1
  size: 11

=head2 group_id

  data_type: INT
  default_value: undef
  is_nullable: 1
  size: 11

=head2 ref_id

  data_type: INT
  default_value: undef
  is_auto_increment: 1
  is_nullable: 0
  size: 11

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "group_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "ref_id",
  {
    data_type => "INT",
    default_value => undef,
    is_auto_increment => 1,
    is_nullable => 0,
    size => 11,
  },
);
__PACKAGE__->set_primary_key("ref_id");
__PACKAGE__->add_unique_constraint("group_user_uniq", ["user_id", "group_id"]);


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2011-11-25 09:30:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iGZPTvkh9M36Fzo1Jt6zWA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
