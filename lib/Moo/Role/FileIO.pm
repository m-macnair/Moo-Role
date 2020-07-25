package Moo::Role::FileIO;

# ABSTRACT: persistent file IO
use Toolbox::FileIO;
use Moo::Role;
our $VERSION = 'v1.0.2';

##~ DIGEST : 585f08aa3104174c1e8072519d409829

ACCESSORS: {
	has filehandles => (
		is      => 'rw',
		lazy    => 1,
		default => sub {
			return {};
		}
	);

}

# Almost but not quite cargo cultin'
sub ofh {
	my ( $self, $path, $c ) = @_;
	$c ||= {};
	unless ( exists( $self->filehandles->{$path} ) ) {
		if ( $c->{fh} ) {
			$self->filehandles->{$path} = $c->{fh};
		} else {
			unless ( open( $self->filehandles->{$path}, $c->{openparams} || ">:encoding(UTF-8)", $path ) ) {
				confess( "Failed to open write file [$path] : $!" );
			}
		}
	}
	return $self->filehandles->{$path};
}

sub closefhs {
	my ( $self, $paths ) = @_;

	#close all unless specific
	$paths ||= [ keys( %{$self->filehandles} ) ];
	use Data::Dumper;

	for ( @{$paths} ) {
		close( $self->filehandles->{$_} ) or confess( "Failed to close file handle for [$_] : $!" );
		undef( $self->filehandles->{$_} );
	}

}

1;
