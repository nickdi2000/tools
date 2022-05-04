#!/bin/bash

alias sharr="vi /tools/shared.sh"
alias sss="source ~/.bashrc && echo sourced"

function sel(){
printf "Please select folder:\n"
select d in */; do test -n "$d" && break; echo ">>> Invalid Selection"; done
cd "$d" && pwd
}

alias savescript="git add . && git commit -m 'auto update' && git push && source ~/.bashrc"
