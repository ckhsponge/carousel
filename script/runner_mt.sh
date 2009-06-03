#!/bin/sh
export PATH=$PATH:/home/1727/data/rubygems/bin:/home/1727/data/rubygems/gems/bin
export RUBYLIB=/home/1727/data/rubygems/lib
export GEM_HOME=/home/1727/data/rubygems/gems

echo $1
/home/1727/containers/rails/carousel/current/script/runner -e production "$1"