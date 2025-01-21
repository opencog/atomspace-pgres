AtomSpace Postgres Backend
==========================

[![CircleCI](https://circleci.com/gh/opencog/atomspace-pgres.svg?style=svg)](https://circleci.com/gh/opencog/atomspace-pgres)

Save and restore AtomSpace contents to a PostgreSQL database.
 
Status
------
This is **Version 5.0.3**

***Deprecated*** -- This repo is a copy of the ***old*** Postgres
storage implementation. It works "fine", it passes unit tests. It's
100% compatible with what it always was -- its just a copy of that old
code.  However, years of experience have revealed that the design is
not all that great. A new Postgres backend should be written, based on
the `RocksStorageNode`, in the
[atomspace-rocks](https://github.com/atomspace-rocks) git repo.

Building and Installing
-----------------------
The build and install of `atomspace-pgres` follows the same pattern as
other AtomSpace projects.

Postgres is a prerequisite. On Debian/Ubuntu,
`apt install postgresql postgresql-client libpq-dev`
Then build, install and test:
```
    cd to project dir atomspace-pgres
    git checkout master
    git pull
    rm -r build
    mkdir build
    cd build
    cmake ..
    make -j
    make -j check
    sudo make install
```

Example Usage
-------------
See the examples directory ***in the man AtomSpace repo***,
[here](https://github.com/opencog/atomspace/tree/master/examples/atomspace)
and look for examples that contain the word `Storage`. There are
half-a-dozen of these.

Design
------
Old design notes and a performance diary can be found in the source
tree.
