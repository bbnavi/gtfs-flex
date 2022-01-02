#!/bin/bash

set -e
set -o pipefail
set -x

sudo apt install -y curl jq unzip

releases_url='https://api.github.com/repos/jqnatividad/qsv/releases/latest'
assets_url="$(
	curl "$releases_url" -H 'Accept: application/json' -L -s \
	| jq -r '.assets_url'
)"
qsv_x64_url="$(
	curl "$assets_url" -H 'Accept: application/json' -L -s \
	| jq -r '.[] | select(.name | test("qsv-[0-9.]+-x86_64-unknown-linux-gnu.zip")) | .browser_download_url'
)"

zip="$(mktemp)"
curl -o "$zip" "$qsv_x64_url" -L -s

mkdir -p "$HOME/.local/bin"
unzip -j -q -d "$HOME/.local/bin" "$zip" qsv
chmod +x "$HOME/.local/bin/qsv"

$HOME/.local/bin/qsv --version
