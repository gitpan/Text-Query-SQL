use strict;

package main;

use Test;
use Data::Dumper;

use Text::Query;

plan test => 2;

$Data::Dumper::Terse = 1;
$Data::Dumper::Indent = 0;

{
    my($question);
    my($query) = Text::Query->new('blurk',
				  -build => 'Text::Query::BuildSQLMifluz',
				  -fields_searched => 'field1',
				  );
    $question = "10";
    $query->prepare($question);
    ok(Dumper($query->{'matchexp'}), "['literal','field1','10']", "prepare $question");

    $question = "+10 -20 30";
    $query->prepare($question);
    ok(Dumper($query->{'matchexp'}), "['or','field1',['mandatory','field1',['literal','field1','10']],['forbiden','field1',['literal','field1','20']],['literal','field1','30']]", "prepare $question");
    
}

# Local Variables: ***
# mode: perl ***
# End: ***
