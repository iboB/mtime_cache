Gem::Specification.new do |s|
  s.name        = 'mtime_cache'
  s.version     = '1.0.0'
  s.date        = '2016-10-08'
  s.summary     = 'Cache file mtimes. Helps caching build artifacts on a CIS'
  s.executables = ['mtime_cache']
  s.description = <<-DESC
mtime_cache creates a cache of file modification times, based on a glob pattern.
If a cache exists it updates unchanged files (unchanged based on MD5 hash) with
the time from the cache.
This is useful if you cache your build artifacts for a build process which
detects changes based on source modification time (such as most C or C++ build
systems) on a continuous integration service (such as Travis CI), which clones
the repo for every build.
When the repo is cloned, all source files have a modification time equal to the
current time, making the cached build artifacts (for example .o files) obsolete.
mtime_cache allows you to cache the modification times of the files, enabling a
minimal rebuild for each clone.
  DESC
  s.authors     = ['Borislav Stanimirov']
  s.email       = 'b.stanimirov@abv.bg'
  s.files       = ['bin/mtime_cache']
  s.homepage    = 'https://github.com/iboB/mtime_cache'
  s.license     = 'MIT'
end
