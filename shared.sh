#!/bin/bash

alias sharr="vi /tools/shared.sh"
alias sss="source ~/.bashrc && echo sourced"

function sel(){
printf "Please select folder:\n"
select d in */; do test -n "$d" && break; echo ">>> Invalid Selection"; done
cd "$d/public_html" && ls && pwd
}

alias web="cd /home/rat/web && sel"

function savee(){
	local curr = $(pwd)
	cd /tools/
	git add .
	git commit -m "auto_update"
	git push
	source ~/.bashrc
	cd "$curr"
}

alias savescript="git add . && git commit -m 'auto update' && git push && source ~/.bashrc"
