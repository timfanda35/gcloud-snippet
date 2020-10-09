#! /bin/bash

#set -ux

if [ $# == 0 ];then
  printf 'Usage:\n'
  printf '    %s gs://BUCKET_NAME\n' "$0"
  exit 1
fi

BUCKET="$1"
DIRS="$(gsutil ls ${BUCKET})"

OLDIFS="$IFS"
IFS=$'\n' # bash specific
for DIR in $DIRS
do
  result="$(gsutil ls -lR ${DIR} | tail -n 1 | awk '{printf "%10s\t%10s %s", $2, $6, $7}' | sed 's/[()]//g')"
  printf '%s\t%s\n' "${result}" "${DIR}"
done
IFS="$OLDIFS"
