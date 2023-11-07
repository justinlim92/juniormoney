#!/bin/bash
gen_ssl () {
	openssl req \
		-x509  \
		-newkey rsa:4096 \
		-sha256 \
		-nodes \
		-keyout "$1"."$2".key \
		-out "$1"."$2".crt \
		-subj "/CN=$1.$2" \
		-days 365
}

# Returns a log message in the form of $function_name: $message
loginfo() {
    echo "${FUNCNAME[1]} : $1"
}

random() {
    echo "random"
}
