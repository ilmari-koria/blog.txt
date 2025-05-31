#!/bin/bash

CURRENT_SCRIPT=$0

WD=$(dirname $CURRENT_SCRIPT)

TMP=$WD/../tmp
SRC=$WD/../src
LIB=$WD/../lib/jar/*

MORGANA_CONFIG=$WD/../config/config-morgana.xml

JAVA_AGENT=""
JAVA_VER=$(java -version 2>&1 | sed -n ';s/.* version "\(.*\)\.\(.*\)\..*".*/\1\2/p;')

if [ $JAVA_VER = "18" ]
  then
    JAVA_AGENT=-javaagent:$LIB/quasar-core-0.7.9.jar
  fi

CLASSPATH=$LIB/MorganaXProc-IIIse.jar:$LIB

java $JAVA_AGENT -cp $CLASSPATH com.xml_project.morganaxproc3.XProcEngine \
    -config=$MORGANA_CONFIG \
    $SRC/xpl/main-pipeline.xpl
    -input:source=$TMP/example-post/example-post.txt \
    -output:result=$TMP/publish/example-post.html
