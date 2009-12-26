package Divpost;
use common::sense;

my $stash = {
    div_content => ""
};

use Text::MicroTemplate::Extended;

my $mt = Text::MicroTemplate::Extended->new(
    include_path => [ 'views' ],
    use_cache => 0,
    tag_start => '<%',
    tag_end   => '%>',
    line_start => '%',
    extension => '.mt.html',
    template_args => $stash
);


sub render {
    $mt->render_file(@_);
}

sub main {
    my ($request) = @_;

    say $request->uri->path;

    given($request->uri->path) {
        when("/posts") {
            $stash->{div_content} = $request->param("post[content]");
        }
    }

    send_home_page($request);
}

sub send_home_page {
    my ($request) = @_;

    $request->print(render("index"))
}

1;
