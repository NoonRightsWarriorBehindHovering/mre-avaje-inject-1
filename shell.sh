#!/bin/bash

LIB_AVAJE_INJECT=$(realpath ~/.m2/repository/io/avaje/avaje-inject/9.0/avaje-inject-9.0.jar)
LIB_AVAJE_APPLOG=$(realpath ~/.m2/repository/io/avaje/avaje-applog/1.0/avaje-applog-1.0.jar)
LIB_AVAJE_LANG=$(realpath ~/.m2/repository/io/avaje/avaje-lang/1.1/avaje-lang-1.1.jar)
LIB_JAKARTA_INJECT=$(realpath ~/.m2/repository/jakarta/inject/jakarta.inject-api/2.0.1/jakarta.inject-api-2.0.1.jar)
EXECUTABLE=$(realpath ./target/classes)
MODULE_PATH="${LIB_AVAJE_INJECT}:${LIB_AVAJE_APPLOG}:${LIB_AVAJE_LANG}:${LIB_JAKARTA_INJECT}:${EXECUTABLE}"

cd target/classes

java --module-path "$MODULE_PATH" --list-modules
java --module-path "$MODULE_PATH" --module bug/org.example.bug.Launcher