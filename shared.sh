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

function sqlimport(){
	echo "Enter script name (with out .sql)"
	read script
	if test -z "$script"
	then
	      echo "\$script cannot be empty"
				exit 1
	fi
 	local db_username=$(node -p "require('dotenv').config();process.env.DB_USERNAME");
 	local db_password=$(node -p "require('dotenv').config();process.env.DB_PASSWORD");
 	local db_database=$(node -p "require('dotenv').config();process.env.DB_DATABASE");
 	echo mysql -u $db_username -p$db_password $db_database < $script.sql
	mysql -u $db_username -p$db_password $db_database < $script.sql
}


function db(){
        local db_username=$(node -p "require('dotenv').config();process.env.DB_USERNAME");
        local db_password=$(node -p "require('dotenv').config();process.env.DB_PASSWORD");
        local db_database=$(node -p "require('dotenv').config();process.env.DB_DATABASE");
        echo mysql -u $db_username -p$db_password $db_database
        mysql -u $db_username -p$db_password $db_database
}
