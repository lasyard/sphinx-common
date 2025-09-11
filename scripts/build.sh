#!/usr/bin/env sh

if ! command -v sphinx-build >/dev/null 2>&1; then
    echo "sphinx-build not found, activating virtualenv if available"
    if ! ${VIRTUAL_ENV:-false}; then
        echo "Not in a virtualenv, attempting to activate .venv"
        if [ -f .venv/bin/activate ]; then
            . ./.venv/bin/activate
        fi
    fi
fi

SPHINX_COMMON_DIR=sphinx-common

case $1 in
clean)
    make clean
    make -f ${SPHINX_COMMON_DIR}/scripts/images.mk clean
    ;;
*)
    make -f ${SPHINX_COMMON_DIR}/scripts/images.mk
    make html
    ;;
esac
