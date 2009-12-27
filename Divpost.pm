package Divpost;
use common::sense;
use Text::MicroTemplate::Extended;

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

sub main {
    my ($request) = @_;

    my $stash = {
        div_content => ""
    };

    while(1) {
        if ($request->param("action") eq "post.update") {
            $stash->{div_content} = $request->param("post[content]");
        }

        render("index", $stash);
    }
}

sub render {
    my ($template, $args) = @_;

    my $mt = Text::MicroTemplate::Extended->new(
        include_path => [ 'views' ],
        use_cache => 0,
        tag_start => '<%',
        tag_end   => '%>',
        line_start => '%',
        extension => '.mt.html',
        template_args => $args
    );

    request->print($mt->render_file($template));
    request->next;
}

1;
