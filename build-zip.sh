#!/bin/bash
set -euo pipefail

if (( $# != 4 ))
then
  echo "Invalid arguments parsed."
  exit 1
fi

source functions.sh

application=""
modules=""

while getopts ":a:m:" opt
do
  case ${opt} in
    a )
      application=$OPTARG
      ;;
    m )
      modules=$OPTARG
      ;;
  esac
done

title "Update Manifest Files With Last Commit Date As Module Version"

for module in $modules
do
  cd "../$module"
  python3 ../constellation-applications/git_version.py -u y
done

title "Update Dependencies & Clean Build"

for module in $modules
do
  cd "../$module"
  ant \
    -Dnbplatform.active.dir="${NETBEANS_HOME}" \
    -Dnbplatform.default.netbeans.dest.dir="${NETBEANS_HOME}" \
    -Dnbplatform.default.harness.dir="${NETBEANS_HOME}"/harness \
    -Dbuild.compiler.debug=true update-dependencies-clean-build
done

cd "../constellation-applications/$application"

for target in build-zip-with-windows-jre build-zip-with-linux-jre build-zip-with-macosx-jre
do
  title "Build $target"
  ant \
    -Dnbplatform.active.dir="${NETBEANS_HOME}" \
    -Dnbplatform.default.netbeans.dest.dir="${NETBEANS_HOME}" \
    -Dnbplatform.default.harness.dir="${NETBEANS_HOME}"/harness \
    -Dbuild.compiler.debug=true $target
done

#title "Build Portable Zip"
#
#ant \
#  -Dnbplatform.active.dir="${NETBEANS_HOME}" \
#  -Dnbplatform.default.netbeans.dest.dir="${NETBEANS_HOME}" \
#  -Dnbplatform.default.harness.dir="${NETBEANS_HOME}"/harness \
#  -Dbuild.compiler.debug=true download-dependencies build-zip
