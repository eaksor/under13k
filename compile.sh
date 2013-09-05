#!/bin/bash
build="build"
name="${build}/underthecrypt"
files="src/spirit.js src/level.js src/spawner.js src/tower.js src/ui.js src/game.js src/journal.js"
time=`date +%s`
if [ -d $name ]; then
    rm -f $name/*
else
    mkdir -p $name
fi
if [ -f $name.zip ]; then
    rm $name.zip
fi
echo "copying"
cp src/tiles.png src/ghost.png $name/
cp src/index.c.html $name/index.html
cp src/journal.c.html $name/journal.html
cp src/under.c.manifest $name/under.manifest
echo -e "\n$time" >> $name/under.manifest
touch $name/$time

echo "compiling"
#java -jar compiler.jar --warning_level VERBOSE --compilation_level ADVANCED_OPTIMIZATIONS --externs src/extern.js --js ${files} --js_output_file $name/utc.js
java -jar compiler.jar --jscomp_warning checkTypes --compilation_level ADVANCED_OPTIMIZATIONS --use_types_for_optimization --externs src/extern.js --js ${files} --js_output_file $name/utc.js
echo "zipping"
zip $name.zip -r $name/
ls -l $name.zip