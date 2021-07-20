#!/bin/bash


g=src/main/groovy/
O=outputs/
o=settings.modules.gradle
o2=settings.root.gradle

cat "${g}/settings.lib.gradle" > "$O/$o"
cat "${g}/settings.common.gradle" >> "$O/$o"
cat "${g}/settings.modules.gradle" >> "$O/$o"

cat "${g}/settings.lib.gradle" > "$O/$o2"
cat "${g}/settings.common.gradle" >> "$O/$o2"
cat "${g}/settings.root.gradle" >> "$O/$o2"
