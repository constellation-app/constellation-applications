#!/bin/bash
set -euo pipefail

source functions.sh

title "Update Dependencies & Clean Build"

cd ../constellation
ant \
  -Dnbplatform.active.dir="${NETBEANS_HOME}" \
  -Dnbplatform.default.netbeans.dest.dir="${NETBEANS_HOME}" \
  -Dnbplatform.default.harness.dir="${NETBEANS_HOME}"/harness \
  -Dbuild.compiler.debug=true update-dependencies-clean-build

cd ../constellation-adaptors
ant \
  -Dnbplatform.active.dir="${NETBEANS_HOME}" \
  -Dnbplatform.default.netbeans.dest.dir="${NETBEANS_HOME}" \
  -Dnbplatform.default.harness.dir="${NETBEANS_HOME}"/harness \
  -Dbuild.compiler.debug=true update-dependencies-clean-build

title "Update Manifest Files with new versions"

cd ../constellation
python3 ../constellation-applications/git_version.py -u y
cd ../constellation-adaptors
python3 ../constellation-applications/git_version.py -u y

cd ../constellation-applications/constellation

title "Build Windows Zip"

ant \
  -Dnbplatform.active.dir="${NETBEANS_HOME}" \
  -Dnbplatform.default.netbeans.dest.dir="${NETBEANS_HOME}" \
  -Dnbplatform.default.harness.dir="${NETBEANS_HOME}"/harness \
  -Dbuild.compiler.debug=true build-zip-with-windows-jre

title "Build Linux Zip"

ant \
  -Dnbplatform.active.dir="${NETBEANS_HOME}" \
  -Dnbplatform.default.netbeans.dest.dir="${NETBEANS_HOME}" \
  -Dnbplatform.default.harness.dir="${NETBEANS_HOME}"/harness \
  -Dbuild.compiler.debug=true build-zip-with-linux-jre

title "Build MacOSX Zip"

ant \
  -Dnbplatform.active.dir="${NETBEANS_HOME}" \
  -Dnbplatform.default.netbeans.dest.dir="${NETBEANS_HOME}" \
  -Dnbplatform.default.harness.dir="${NETBEANS_HOME}"/harness \
  -Dbuild.compiler.debug=true build-zip-with-macosx-jre

#title "Build Portable Zip"
#
#ant \
#  -Dnbplatform.active.dir="${NETBEANS_HOME}" \
#  -Dnbplatform.default.netbeans.dest.dir="${NETBEANS_HOME}" \
#  -Dnbplatform.default.harness.dir="${NETBEANS_HOME}"/harness \
#  -Dbuild.compiler.debug=true download-dependencies build-zip
