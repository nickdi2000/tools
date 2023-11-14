#!/bin/bash

alias sharr="vi /tools/shared.sh"
alias sss="source ~/.bashrc && echo sourced"

function sel(){
printf "Please select folder:\n"
COLUMNS=0
select d in */; do test -n "$d" && break; echo ">>> Invalid Selection"; done
cd "$d/public_html" && ls && pwd
}

alias web="cd /home/rat/web && sel"

alias sc="node -e \"console.log(require('./package.json').scripts)\""

#adding a new alias
newal() {
    echo -n "Enter the alias shortcut key: "
    read alias_key
    echo -n "Enter the command it should execute: "
    read alias_command
    echo "alias $alias_key='$alias_command'" >> ~/.zshrc
    echo "Alias added. Reload your zsh configuration or restart the terminal for it to take effect."
}


# Help alias script
function help_menu() {
    echo "Select a command to execute:"
    echo "1) Generate a Certbot SSL certificate"
    echo "2) Show Nginx logs"
    echo "3) Check disk space usage"
    echo "4) Show current memory usage"
    echo "5) List active processes"
    read -p "Enter your choice (or any other key to exit): " choice

    case $choice in
        1) sudo certbot --nginx ;;  # Modify as per your Certbot usage
        2) sudo tail -f /var/log/nginx/access.log ;;  # Adjust log path if necessary
        3) df -h ;;
        4) free -m ;;
        5) top ;;
        *) echo "Exiting help menu." && return ;;
    esac
}

alias h=help_menu


function sslme(){
	sudo systemctl stop nginx
	sudo certbot certonly --standalone --agree-tos --preferred-challenges http -d $*
	sudo systemctl start nginx
	sudo certbot --nginx --agree-tos --preferred-challenges http -d $*
}

function doo(){
	echo "Which Command to Run?"
options=(
"/etc/init.d/apache2 restart"
"sudo systemctl restart apache2.service"
"systemctl status hestia.service"
"sudo systemctl restart nginx"
)
select com in "${options[@]}";
do
echo $com
$com
done

}

function show(){
	echo sudo certbot --nginx -d example.com -d www.example.com ;
}

function savee(){
	local curr = $(pwd)
	cd /tools/
	git add .
	git commit -m "auto_update"
	git push
	source ~/.bashrc
	cd $curr
}

alias fixhestia="sed -i 's/8083/8099/' /usr/local/hestia/nginx/conf/nginx.conf"
alias savescript="git add . && git commit -m 'auto update' && git push && source ~/.bashrc"
alias htaccess="cp /tools/htaccess .htaccess && echo .htaccess copied"
alias rem="git remote show origin"
alias permfix="chmod -R 0755 . && chmod -R o+w"

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
