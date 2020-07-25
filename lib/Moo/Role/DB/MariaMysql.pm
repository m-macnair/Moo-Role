package Moo::Role::DB::MariaMysql;

#ABSTRACT: overwrites/extensions to DB for maria/mysql
use Moo::Role;

around "last_insert_id" => sub {
	my $orig = shift;
	my $self = shift;
	return $self->dbh->{mysql_insertid};
};

1;
