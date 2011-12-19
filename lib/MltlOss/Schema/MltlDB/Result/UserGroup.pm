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
  is_foreign_key: 1
  is_nullable: 1
  size: 11

=head2 group_id

  data_type: INT
  default_value: undef
  is_foreign_key: 1
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
  {
    data_type => "INT",
    default_value => undef,
    is_foreign_key => 1,
    is_nullable => 1,
    size => 11,
  },
  "group_id",
  {
    data_type => "INT",
    default_value => undef,
    is_foreign_key => 1,
    is_nullable => 1,
    size => 11,
  },
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

=head1 RELATIONS

=head2 group

Type: belongs_to

Related object: L<MltlOss::Schema::MltlDB::Result::Group>

=cut

__PACKAGE__->belongs_to(
  "group",
  "MltlOss::Schema::MltlDB::Result::Group",
  { group_id => "group_id" },
  { join_type => "LEFT" },
);

=head2 user

Type: belongs_to

Related object: L<MltlOss::Schema::MltlDB::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "MltlOss::Schema::MltlDB::Result::User",
  { user_id => "user_id" },
  { join_type => "LEFT" },
);


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2011-12-06 15:15:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sPcXYgdlg7ev/dETKznzcQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
