#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m'

projectName=$(basename `pwd`)
file="name.xcworkspace"
userFile="username.xcuserdatad"

newFirName="ios/${file/name/$projectName}"

if [ -d $newFirName ]; then
  echo -e "${BOLD}${RED}File $newFirName already exists${NC}"
else
  tar -xvzf template.tar.gz &&
  cd ./ios &&
  mv $file ${file//name/$projectName} &&

  (cd "$(find . -name '*.xcworkspace')/xcuserdata/" &&
  mv $userFile ${userFile//username/$(printenv USER)}) &&
  grep -rli "name" * | xargs -I@ sed -i '' "s/name/$projectName/g" @

  cd .. &&
  echo -e "${GREEN}Successfully created $newFirName${NC}"
fi
