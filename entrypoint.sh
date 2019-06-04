#!/bin/bash
for file in $(find . -name "*.java") ; do
    file="$(basename $file)"
    echo "Processing $file"
    javac -classpath $JAVA_LIB_PATH "$file"
    if [ $? -ne 0 ] ; then
        echo "Failed to compile, skipping."
        break
    fi
    java -classpath $JAVA_LIB_PATH "${file/.java/}"
done
