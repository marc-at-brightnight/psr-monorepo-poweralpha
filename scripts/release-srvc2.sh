#!/bin/bash

set -e

PROJECT_ROOT="$(dirname "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")")"
VIRTUAL_ENV="$PROJECT_ROOT/.venv"

SERVICE_NAME="srvc2"

cd "$PROJECT_ROOT" || exit

# Setup documentation template
pushd "documentation/templates" >/dev/null || exit

rm -rf documentation/
mkdir -p "documentation/docs/"
cp -r .base_changelog_template/ "documentation/docs/$SERVICE_NAME"

popd >/dev/null || exit

# Release the service
pushd "poweralpha/services/$SERVICE_NAME" >/dev/null || exit

printf '%s\n' "Releasing $SERVICE_NAME..."
"$VIRTUAL_ENV/bin/semantic-release" -v version --no-push

# printf '%s\n' "Writing changelog for $SERVICE_NAME..."
# "$VIRTUAL_ENV/bin/semantic-release" -v changelog

popd >/dev/null || exit
