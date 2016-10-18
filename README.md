mtime_cache
===========

[![Build Status](https://travis-ci.org/iboB/mtime_cache.svg?branch=master)](https://travis-ci.org/iboB/mtime_cache)

**mtime_cache** helps you cache build artifacts in a CI system (like [Travis CI](https://travis-ci.org/), [AppVeyor](https://www.appveyor.com/) or [Codeship](https://codeship.com/)) for a language whose build typically depends of the files source file modification time rather than their contents (like most C or C++ build systems).

## Problem

You have a C/C++ project with many, many files and you're using Travis CI to build and test it. The thing is that Travis CI makes a fresh clone of your project for every build. This leads to builds of 10, or 20, or 40 minutes, or more, even if what's changed is a single source file (or none at all).

Frustrated you discover that Travis CI supports caching of build artifacts. And you cache your intermediate (`.o` or `.obj`) file directory. The thing is that this seems to do nothing and a full build is triggered every time. This is because [git doesn't store meta information such as mtime for the files](http://stackoverflow.com/questions/2179722/checking-out-old-file-with-original-create-modified-timestamps/2179825#2179825). So the source files from your fresh clone at Travis CI have modification times newer than the cached files. So the C/C++ build system "thinks" that they should be rebuilt.

## Solution

**mtime_cache**

Run the command line tool before you build and it will store the modification time of each source file in a json cache (which you need to cache along with your build artifacts). It will generate a md5 hash for each source file and if it remains the same, it will restore the cached mtime for it. So changed files will be re-compiled, but unchanged ones won't be.

## Usage

### Installation

You can either install mtime_cache as a gem (with `$ gem install mtime_cache`) or make a copy of the script in your repo.

### Running mtime_cache

The most basic usage is `$ mtime_cache <globs>`

This will generate a file `.mtime_cache.json` in the current directory with cached mtimes for the files matching the globs.

You must provide globs to make a cache.

#### Globs:

Globs are one or more ruby-style glob patters that must match the source files for which you need an mtime cache.

Additionally the tool supports built in extension patterns. You can add an extension pattern in a `%{}` block.

Valid globs are:
* `src/*.cpp` - all `.cpp` files in src
* `my/src/**/*.{cpp,hpp}` - all `.cpp` and `.hpp` files in my/src and all its subdirectories
* `some/dir/**/*.{%{cpp}}` - all files typical for C/C++ in some/dir and all its subdirectories

The supported extension patterns are:
* `%{cpp}` - common C/C++ extensions: `c,cc,cpp,cxx,h,hpp,hxx,inl,ipp,inc,ixx`

#### Additional configuration:

* `--cache` or `-c`: Lets you provide a custom cache file instead of using the default `./.mtime_cache.json`. Sample usage: `$ mtime_cache src/*.{c,h} -c .my_cache/mtime_cache.json`
* `--globfile` or `-g`: Lets you provide a text file where each non-empty line is a glob instead of add all globs as command-line arguments. Sample usage: `mtime_cache -g myglobs.txt`
* `--quiet` or `-q`: Prevents any logging to the standard output whatsoever.
* `--verbose` or `-V`: Shows extra logging. For each file matching a glob a log line will be displayed showing whether its mtime was restored or not changed (if it doesn't match the cached md5 hash).
* `--dryrun` or `-d`: Doesn't write to the filesystem. Only logs and reads files, and cache file if it exists.
* `--version` or `-v`: Only displays version and exits.
* `--help` or `-h` or `-?`: Displays help screen and exits.

### Using mtime_cache with Travis CI

* Choose a directory name the json cache (for example `.mtime_cache`) and add it to your `.gitignore`. Then add it to your Travis CI cache. Then your cache section in `.travis.yml` might look like this

```yaml
cache:
    directories:
    - my/build/dir
    - .mtime_cache
```

* Run mtime cache in your script before you trigger the actual build. Then you script section might look like this:

```yaml
script:
  - ./configure
  - ./mtime_cache src/**/*.{%{cpp}} -c .mtime_cache/cache.json
  - make
  - ./test
```

You can also take a look at `.travis.yml` in this repo to see how the demo project is being built.

## Demo

There is a demo project in this repo which is build by the Travis CI integration. It has three `.cpp` files and a `.hpp` file. You can see that commits that don't change one of those, don't trigger a build of the C++ code (or that commits that only change one or two `.cpp` files trigger a recompilation of only those).

## License

This software is distributed under the MIT Software License.

See accompanying file LICENSE.txt or copy [here](https://opensource.org/licenses/MIT).

Copyright &copy; 2016 [Borislav Stanimirov](http://github.com/iboB)
