#!/bin/bash

CURRENT_SCRIPT=$0
MORGANA_SH=$(dirname $CURRENT_SCRIPT)
MORGANA_LIB=$MORGANA_SH/../lib/jar/*
JAVA_AGENT=""
JAVA_VER=$(java -version 2>&1 | sed -n ';s/.* version "\(.*\)\.\(.*\)\..*".*/\1\2/p;')

if [ $JAVA_VER = "18" ]
  then
    JAVA_AGENT=-javaagent:$MORGANA_LIB/quasar-core-0.7.9.jar
  fi

CLASSPATH=$MORGANA_LIB/MorganaXProc-IIIse.jar:$MORGANA_LIB

java $JAVA_AGENT -cp $CLASSPATH com.xml_project.morganaxproc3.XProcEngine "$@"
