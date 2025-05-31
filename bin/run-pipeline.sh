#!/bin/bash

CURRENT_SCRIPT="$0"
WD="$(cd "$(dirname "$CURRENT_SCRIPT")" && pwd)"

TMP="$WD/../tmp"
SRC="$WD/../src"
LIB="$WD/../lib"

MORGANA="$WD/../lib/morgana"
# TODO is $MORGANA_LIB a hard requiremenent?
MORGANA_LIB="$WD/../lib/morgana/MorganaXProc-IIIse_lib" 
MORGANA_CONFIG="$WD/../config/config-morgana.xml"

# TODO maybe rm these
JAVA_AGENT=""
JAVA_VER=$(java -version 2>&1 | sed -n 's/.* version "\(.*\)\.\(.*\)\..*".*/\1\2/p')

if [ "$JAVA_VER" = "18" ]; then
  JAVA_AGENT="-javaagent:$MORGANA_LIB/quasar-core-0.7.9.jar"
fi

CLASSPATH="$MORGANA/MorganaXProc-IIIse.jar:$MORGANA_LIB/*"

# note that morgana switches need to be after the pipeline
java $JAVA_AGENT -cp "$CLASSPATH" com.xml_project.morganaxproc3.XProcEngine \
     -config=$MORGANA_CONFIG \
     "$SRC/xpl/main-pipeline.xpl" \
     -input:source="$TMP/example-post/example-post.txt" \
     -output:result="$TMP/publish/example-post.html" \
     -output:validation-report="$TMP/publish/report.txt" \
     -cp \
     -indent-errors \
     -no-timestamps \
     -silent \
     -xslt-message-prefix="[SAXON]: "
     
