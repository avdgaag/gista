# Gista -- create gists from the command line [![Build Status](https://secure.travis-ci.org/avdgaag/gista.png?branch=master)](http://travis-ci.org/avdgaag/gista)

## Introduction

Gista is a very simple command-line program and Ruby library for creating
Gists. As a stand-alone program, it can create a new gist from files listed as
arguments, or by reading from STDIN.

## Installation

Gista is distributed as a Ruby gem, which should be installed on most Macs and
Linux systems. Once you have ensured you have a working installation of Ruby
and Ruby gems, install the gem as follows from the command line:

    $ gem install gista

You can verify the gem has installed correctly by checking its version number:

    $ gista -v

If this generates an error, something has gone wrong. You should see something
along the lines of `gista 1.0.0`.

## Usage

You can list one or more filenames as an argument:

    $ gista filename1 filename2...

Or, you can read content from STDIN:

    $ echo "Hello, world!" | gista

When reading from STDIN one file will be created, by default called `untitled`.
You can override this name:

    $ echo "Hello, world!" | gista -f "my new gist"

By default, new gists are private. You can make a public gist with the `-p`
option:

    $ gista -p filename1
    $ gista --public filename1

When everything went according to plan, the program will output the URL to
the newly created gist.

If you want to use Gista as a Ruby library, take a look at the `bin/gista`
file for an example how to use it:

    authoriser = Gista::TokenRequest.new(Gista::LoginPrompt.new)
    token      = Gista::UserToken.new(authoriser).token
    options    = Gista::Options.new(ARGV).options
    puts Gista.post_and_get_url(token, options)

### Documentation

See the inline [API
docs](http://rubydoc.info/github/avdgaag/gista/master/frames) for more
information.

## Other

### Note on Patches/Pull Requests

1. Fork the project.
2. Make your feature addition or bug fix.
3. Add tests for it. This is important so I don't break it in a future version
   unintentionally.
4. Commit, do not mess with rakefile, version, or history. (if you want to have
   your own version, that is fine but bump version in a commit by itself I can
   ignore when I pull)
5. Send me a pull request. Bonus points for topic branches.

### Issues

Please report any issues, defects or suggestions in the [Github issue
tracker](https://github.com/avdgaag/gista/issues).

### What has changed?

See the [HISTORY](https://github.com/avdgaag/gista/blob/master/HISTORY.md) file
for a detailed changelog.

### Credits

Created by: Arjan van der Gaag  
URL: [http://arjanvandergaag.nl](http://arjanvandergaag.nl)  
Project homepage: [http://avdgaag.github.com/gista](http://avdgaag.github.com/gista)  
Date: april 2012  
License: [MIT-license](https://github.com/avdgaag/gista/LICENSE) (same as Ruby)
