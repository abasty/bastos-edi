#!/bin/bash

if [[ -d bin ]]; then
    export PATH=$PATH:$(realpath bin)
fi

cleanup() {
    # try to find websocat listening on port 1967 and kill it
    if command -v lsof >/dev/null 2>&1; then
        pids=$(lsof -tiTCP:1967 -sTCP:LISTEN)
    else
        pids=$(pgrep -f "websocat .*127.0.0.1:1967" || true)
    fi
    if [ -n "$pids" ]; then
        kill $pids 2>/dev/null || true
        wait $pids 2>/dev/null || true
    fi
}

trap cleanup EXIT INT TERM

websocat -t -E --no-line ws-l:127.0.0.1:1967 exec:bastos &
./bastos-edi.py
