#!/bin/sh
export PATH=$PATH:/home/44693/data/rubygems/bin:/home/44693/data/rubygems/gems/bin
export RUBYLIB=/home/44693/data/rubygems/lib
export GEM_HOME=/home/44693/data/rubygems/gems

echo $1
/home/1727/containers/rails/carousel/current/script/runner -e production $1