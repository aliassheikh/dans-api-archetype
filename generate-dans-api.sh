#!/usr/bin/env bash
#
# Copyright (C) 2023 DANS - Data Archiving and Networked Services (info@dans.knaw.nl)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


DEFAULT_ARCHETYPE_VERSION=0.1.0-SNAPSHOT

read -p "dans-module-api version? (default = $DEFAULT_ARCHETYPE_VERSION): " ARCHETYPE_VERSION
read -p "API artifactId: " ARTIFACT_ID
read -p "Port number: " PORT
read -p "Description (one to four sentences): " DESCRIPTION

ARTIFACT_PHRASE=`echo $ARTIFACT_ID | tr '-' ' ' | awk '{for (i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1'`

mvn archetype:generate -DarchetypeGroupId=nl.knaw.dans \
        -DarchetypeArtifactId=dans-api-archetype \
        -DarchetypeVersion=${ARCHETYPE_VERSION:-"$DEFAULT_ARCHETYPE_VERSION"} \
        -DgroupId=nl.knaw.dans \
        -DartifactId=$ARTIFACT_ID \
        -DprojectName="$ARTIFACT_PHRASE" \
        -DportNumber=$PORT \
        -Ddescription="$DESCRIPTION" \
        -DinceptionYear=$(date +"%Y")

pushd $ARTIFACT_ID || exit 1
bash init-project.sh
rm init-project.sh
popd || exit 1
