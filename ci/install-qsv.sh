#!/bin/bash

set -e
set -o pipefail
set -x

sudo apt install -y \
	curl jq unzip \
	libpython3.10

ua='bbnavi/gtfs-flex CI'
qsv_release='87693052' # 0.81.0
releases_url="https://api.github.com/repos/jqnatividad/qsv/releases/$qsv_release"
assets_url="$(
	curl "$releases_url" -H 'Accept: application/json' -H "User-Agent: $ua" -L -fsS \
	| jq -r '.assets_url'
)"
qsv_x64_url="$(
	curl "$assets_url" -H 'Accept: application/json' -H "User-Agent: $ua" -L -fsS \
	| jq -r '.[] | select(.name | test("qsv-[0-9.]+-x86_64-unknown-linux-gnu.zip")) | .browser_download_url'
)"

zip="$(mktemp)"
curl -o "$zip" "$qsv_x64_url" -H "User-Agent: $ua" -L -fsS

mkdir -p "$HOME/.local/bin"
unzip -j -q -d "$HOME/.local/bin" "$zip" qsv
chmod +x "$HOME/.local/bin/qsv"

$HOME/.local/bin/qsv --version
