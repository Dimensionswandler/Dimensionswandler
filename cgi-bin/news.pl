#!/usr/bin/perl5 -w

# CGI Verzeichnis:	dimensionswandler.de/cgi-bin
# Aufruf als URL:	http://www.dimensionswandler.de/cgi-bin/CGI-Script
# absolute Pfade:	/home/strato/www/di/www.dimensionswandler.de/htdocs/


#-----------------------------------------------------------------------------
# Stellt den Inhalt einer Datei dar, die news.txt heißt, und sich im
# Verzeichnis ../homeDB befindet.
#
# Der Inhalt wird als DefinitionList dargestellt, analog zum SCoT-Verhalten.
# Zeilen, die weder mit '?' noch mit '.' beginnen, werden als ungültig
# eingestuft und mit deutlich kleinerer Schrift (6pt) als Ganzes angezeigt.
# Auf diese Art wird der Inhalt zwar transportiert, aber es ist ersichtlich,
# dass es ein Problem damit gibt.
#
# Im Falle einer fehlenden oder leeren Datei wird ein alternativer Text
# angezeigt.
#-----------------------------------------------------------------------------

use strict;
use CGI::Carp qw(fatalsToBrowser);

my $file = "../homeDB/news.txt";
my $line = undef;

print "Content-type: text/html\n\n";

if (-e $file && -s $file) {
	print "<div><dl>";

	open(NEWS, "<$file");
	while ($line = <NEWS>) {
		chop $line;
		my $meaning = substr $line, 0, 1;
		my $content = substr $line, 1, ((length $line) - 1);

		if ($meaning eq "?") {
			print "<dt>" . $content . "</dt>";
		} elsif ($meaning eq ".") {
			print "<dd>" . $content . "</dd>";
		} else {
			print "<dd style=\'font-size:6pt;\'>" . $line . "</dd>";
		}
	}
	close(NEWS);

	print "</dl></div>";
} else {
	print "Leider sind derzeit keine News vorhanden!";
}

