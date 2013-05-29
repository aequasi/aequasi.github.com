#!/bin/bash
die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "1 argument required, $# provided"

rake generate && rake deploy && git add . && git commit -m "$1" && git push origin source
