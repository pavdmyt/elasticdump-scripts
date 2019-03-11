#!/bin/bash

ES_HOST="localhost"
ES_PORT="9202"


function restore () {
    local -r idx_name="$1"
    local -r out="http://${ES_HOST}:${ES_PORT}/${idx_name}"

    elasticdump \
        --input="./${idx_name}_mapping.json" \
        --output="$out" \
        --type=mapping

    elasticdump \
        --input="./${idx_name}.json" \
        --output="$out" \
        --type=data
}

function print_usage () {
    echo "usage: $0 <index-name>"
}

function main () {
    ## Arg parsing
    ##
    if [ -z ${1+x} ] || [[ ${1} = *"help"* ]]; then
        print_usage
        exit 1
    fi

    restore "$1"
}

main "${@}"
