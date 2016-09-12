#!/usr/bin/env bash

declare -r SCRIPT_VERSION='0.1';
declare -r SCAN_DATE="$( date '+%a, %d.%m.%Y %H:%M:%S"' )"
declare -r SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

start_scan() {
    scan_setup;
    scan_kernel;
    scan_envvar;
    scan_network;
}

scan_setup() {
    source qscan-helpers.sh;
    source colors.sh;

    qtitle "Linux Quickscan ${SCRIPT_VERSION}";
    printf 'Run Date: %s\n' "${SCAN_DATE}";

    if [ !-z ${*+x} ]; then
        for v in "${*}"; do
            printf "${v}";
        done
    fi

}

scan_kernel() {
    qtitle 'KERNEL / DISTRO VERSIONS'

    printf 'Kernel Version ==> "%s"\n' "$( uname -r )";

}

scan_envvar() {
    qtitle 'ENVIRONMENT VARIABLES'

    declare -a env_vars;
    env_vars=( 'PATH' 'HOME' 'SHELL' 'DESKTOP_SESSION' );

    for var in "${env_vars[@]}"; do
        # if var is null
        if [ -z ${var+x} ]; then
            printf '%s is not set.\n' "${var}" > qdetailed.log;
        else
            printf '%s ==> "%s"' "${var}" "${!var}" ;
            echo;
        fi
    done

}

scan_network() {
    qtitle 'INTERNET';

    test_ip='8.8.8.8';
    test_url='https://google.com';

    ping -c 1 "${}" > qdetailed.log;
    if [ "$?" ]; then
        echo 'Ping 8.8.8.8 ==> success'
    fi

    curl 'https://google.com' > /dev/null

}





main() {
    start_scan;
}

# invoke main method
main $*;

