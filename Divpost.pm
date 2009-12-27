package Divpost;
use common::sense;
use Text::MicroTemplate::Extended;
use DateTime::Tiny;
use utf8;
use encoding 'utf8';

use PadWalker;
sub request {
    my $level = 1;
    while(1) {
        my $vars = PadWalker::peek_my($level);
        if ($vars->{'$request'}) {
            return ${$vars->{'$request'}}
        }
        $level++;
    }
}


my $stash = {
    posts => []
};

my $mt = Text::MicroTemplate::Extended->new(
    include_path => [ 'views' ],
    use_cache => 0,
    tag_start => '<%',
    tag_end   => '%>',
    line_start => '%',
    extension => '.mt.html',
);


sub main {
    my ($request) = @_;

    while(1) {
        if ($request->param("action") eq "post.update") {
            unshift @{$stash->{posts}}, {
                created_at => DateTime::Tiny->now,
                content => $request->param("post[content]")
            };
        }

        render("index", $stash);
    }
}

sub render {
    my ($template, $args) = @_;

    $mt->template_args($args);

    request->print($mt->render_file($template));
    request->next;
}

1;
