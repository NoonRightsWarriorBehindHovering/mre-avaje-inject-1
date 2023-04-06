#!/bin/bash

set -e

LIB_AVAJE_INJECT=$(realpath ~/.m2/repository/io/avaje/avaje-inject/9.0/avaje-inject-9.0.jar)
LIB_AVAJE_APPLOG=$(realpath ~/.m2/repository/io/avaje/avaje-applog/1.0/avaje-applog-1.0.jar)
LIB_AVAJE_LANG=$(realpath ~/.m2/repository/io/avaje/avaje-lang/1.1/avaje-lang-1.1.jar)
LIB_JAKARTA_INJECT=$(realpath ~/.m2/repository/jakarta/inject/jakarta.inject-api/2.0.1/jakarta.inject-api-2.0.1.jar)
LIB_AVAJE_INJECT_GENERATOR=$(realpath ~/.m2/repository/io/avaje/avaje-inject-generator/9.0/avaje-inject-generator-9.0.jar)
MODULE_PATH="${LIB_AVAJE_INJECT}:${LIB_AVAJE_APPLOG}:${LIB_AVAJE_LANG}:${LIB_JAKARTA_INJECT}"
MODULE_PATH_PROCESSORS="${LIB_AVAJE_INJECT}:${LIB_AVAJE_LANG}:${LIB_AVAJE_APPLOG}:${LIB_JAKARTA_INJECT}:${LIB_AVAJE_INJECT_GENERATOR}"

rm -rf target_manual

if [ -z ${JAVA_HOME+x} ]; then
    BIN_JAVAC=javac
    BIN_JAVA=java
else
    BIN_JAVA=${JAVA_HOME}/bin/java
    BIN_JAVAC=${JAVA_HOME}/bin/javac
    if ! type "${BIN_JAVA}" &> /dev/null; then
        echo "JAVA NOT FOUND: '$BIN_JAVA'";
        exit 1
    fi

    if ! type "${BIN_JAVAC}" &> /dev/null; then
        echo "JAVA NOT FOUND: '$BIN_JAVA'";
        exit 1
    fi
fi

${BIN_JAVA} -version || exit 0
${BIN_JAVAC} -version || exit 0

${BIN_JAVAC} \
    -p ${MODULE_PATH} \
    --processor-module-path ${MODULE_PATH_PROCESSORS} \
    -d target_manual \
    src/main/java/*.java src/main/java/org/example/bug/*.java

EXECUTABLE=$(realpath ./target_manual)
MODULE_PATH="${MODULE_PATH}:${EXECUTABLE}"

${BIN_JAVA} --module-path "$MODULE_PATH" --list-modules
${BIN_JAVA} --module-path "$MODULE_PATH" --module bug/org.example.bug.Launcher
