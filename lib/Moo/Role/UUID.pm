package Moo::Role::UUID;

# ABSTRACT : hold a persistent UUID and create them as a method for whatever
use Moo::Role;
use Data::UUID;
our $VERSION = 'v1.0.2';

##~ DIGEST : 52aa4ff0091dc28cdb8dea1d83e9e422

ACCESSORS: {
	has uuid => (
		is      => 'rw',
		lazy    => 1,
		default => sub { $_[0]->getuuid() }
	);
}

sub getuuid {
	my $ug = Data::UUID->new;
	return lc( $ug->create_str() );

}

1;
