package MltlOss::Schema::MltlDB::Result::CustomerComment;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

MltlOss::Schema::MltlDB::Result::CustomerComment

=cut

__PACKAGE__->table("customer_comments");

=head1 ACCESSORS

=head2 comment_id

  data_type: INT
  default_value: undef
  is_auto_increment: 1
  is_nullable: 0
  size: 11

=head2 customer_id

  data_type: INT
  default_value: undef
  is_nullable: 1
  size: 10

=head2 comment_date

  data_type: TIMESTAMP
  default_value: CURRENT_TIMESTAMP
  is_nullable: 1
  size: 14

=head2 comment_by

  data_type: INT
  default_value: undef
  is_foreign_key: 1
  is_nullable: 1
  size: 11

=head2 comment_detail

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 250

=cut

__PACKAGE__->add_columns(
  "comment_id",
  {
    data_type => "INT",
    default_value => undef,
    is_auto_increment => 1,
    is_nullable => 0,
    size => 11,
  },
  "customer_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 10 },
  "comment_date",
  {
    data_type => "TIMESTAMP",
    default_value => \"CURRENT_TIMESTAMP",
    is_nullable => 1,
    size => 14,
  },
  "comment_by",
  {
    data_type => "INT",
    default_value => undef,
    is_foreign_key => 1,
    is_nullable => 1,
    size => 11,
  },
  "comment_detail",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 250,
  },
);
__PACKAGE__->set_primary_key("comment_id");

=head1 RELATIONS

=head2 comment_by

Type: belongs_to

Related object: L<MltlOss::Schema::MltlDB::Result::User>

=cut

__PACKAGE__->belongs_to(
  "comment_by",
  "MltlOss::Schema::MltlDB::Result::User",
  { user_id => "comment_by" },
  { join_type => "LEFT" },
);


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2011-11-25 09:30:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:BXJen4bz99ZEabqNrzCwJA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
