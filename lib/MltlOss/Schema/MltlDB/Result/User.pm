package MltlOss::Schema::MltlDB::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

MltlOss::Schema::MltlDB::Result::User

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 user_id

  data_type: INT
  default_value: undef
  is_auto_increment: 1
  is_nullable: 0
  size: 11

=head2 username

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 45

=head2 first_name

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 45

=head2 surname

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 45

=head2 phone

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 20

=head2 email

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 45

=head2 role

  data_type: VARCHAR
  default_value: undef
  is_nullable: 1
  size: 45

=head2 last_login

  data_type: TIMESTAMP
  default_value: CURRENT_TIMESTAMP
  is_nullable: 1
  size: 14

=cut

__PACKAGE__->add_columns(
  "user_id",
  {
    data_type => "INT",
    default_value => undef,
    is_auto_increment => 1,
    is_nullable => 0,
    size => 11,
  },
  "username",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 45,
  },
  "first_name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 45,
  },
  "surname",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 45,
  },
  "phone",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 20,
  },
  "email",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 45,
  },
  "role",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 45,
  },
  "last_login",
  {
    data_type => "TIMESTAMP",
    default_value => \"CURRENT_TIMESTAMP",
    is_nullable => 1,
    size => 14,
  },
);
__PACKAGE__->set_primary_key("user_id");
__PACKAGE__->add_unique_constraint("email_UNIQUE", ["email"]);
__PACKAGE__->add_unique_constraint("phone_UNIQUE", ["phone"]);

=head1 RELATIONS

=head2 customer_comments

Type: has_many

Related object: L<MltlOss::Schema::MltlDB::Result::CustomerComment>

=cut

__PACKAGE__->has_many(
  "customer_comments",
  "MltlOss::Schema::MltlDB::Result::CustomerComment",
  { "foreign.comment_by" => "self.user_id" },
);

=head2 link_comments

Type: has_many

Related object: L<MltlOss::Schema::MltlDB::Result::LinkComment>

=cut

__PACKAGE__->has_many(
  "link_comments",
  "MltlOss::Schema::MltlDB::Result::LinkComment",
  { "foreign.comment_by" => "self.user_id" },
);

=head2 service_comments

Type: has_many

Related object: L<MltlOss::Schema::MltlDB::Result::ServiceComment>

=cut

__PACKAGE__->has_many(
  "service_comments",
  "MltlOss::Schema::MltlDB::Result::ServiceComment",
  { "foreign.comment_by" => "self.user_id" },
);

=head2 site_comments

Type: has_many

Related object: L<MltlOss::Schema::MltlDB::Result::SiteComment>

=cut

__PACKAGE__->has_many(
  "site_comments",
  "MltlOss::Schema::MltlDB::Result::SiteComment",
  { "foreign.comment_by" => "self.user_id" },
);

=head2 tickets_creators

Type: has_many

Related object: L<MltlOss::Schema::MltlDB::Result::Ticket>

=cut

__PACKAGE__->has_many(
  "tickets_creators",
  "MltlOss::Schema::MltlDB::Result::Ticket",
  { "foreign.creator" => "self.user_id" },
);

=head2 tickets_owners

Type: has_many

Related object: L<MltlOss::Schema::MltlDB::Result::Ticket>

=cut

__PACKAGE__->has_many(
  "tickets_owners",
  "MltlOss::Schema::MltlDB::Result::Ticket",
  { "foreign.owner" => "self.user_id" },
);

=head2 user_groups

Type: has_many

Related object: L<MltlOss::Schema::MltlDB::Result::UserGroup>

=cut

__PACKAGE__->has_many(
  "user_groups",
  "MltlOss::Schema::MltlDB::Result::UserGroup",
  { "foreign.user_id" => "self.user_id" },
);


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2011-12-06 15:15:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:poerBCqvYzO2IwNjpZxrow


# You can replace this text with custom content, and it will be preserved on regeneration
1;
