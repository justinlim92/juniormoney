#!/bin/bash
# shellcheck source=shell_functions.sh
source shell_functions.sh loginfo

files=("aws_functions.sh" "lint.sh" "shell_functions.sh")

lint() {
    loginfo "Linting ${1}"
    if shellcheck -x "$1"; then
        echo "---[ Linting ${1} passed"
    else
        echo "Linting ${1} failed."
        exit 1
    fi
}

for file in "${files[@]}"; do
    lint "${file}"
done

echo "Linting completed successfully for all files."
