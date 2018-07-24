# SendGrid stuffs 
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# python
export PATH=~/Library/Python/2.7/bin/:$PATH

# go
export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/opt/go/libexec/bin
alias gopath='export PATH=$PATH:$GOPATH/bin'

# update chefdk
#eval "$(chef shell-init bash)"

# gem
export GEMPATH=/Users/asingh/.gem/ruby/2.0.0/bin
export PATH=$PATH:/Users/asingh/.gem/ruby/2.0.0/bin


# terraform
export PATH=$PATH:/Users/asingh/go/src/github.com/sendgrid/terraform_binary/
export TF_VAR_user_name="-ash"
export TF_VAR_aws_region="us-west-2"
export TF_VAR_snowflake_username=""
export TF_VAR_snowflake_password=""
export TF_VAR_snowflake_db_name=""
export TF_VAR_snowflake_schema_name=""
export TF_VAR_snowflake_warehouse_name=""
export TF_VAR_snowflake_contacts_table_name=""
export TF_VAR_snowflake_update_contacts_table_name=""
export TF_VAR_aws_key_id=ASIAI524IBN72NUZHYIQ
export TF_VAR_aws_secret_key=JXVaeQqVWpWt0AJtrY/w6TsL8YKsZ68GzZr5HYO2
export AWS_DEFAULT_REGION="us-west-2"
export AWS_PROFILE='preprod_eng-mc-data'

# coloration
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagaced

# colors
export COLOR_NC='\e[0m' # No Color
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[0;33m'
export COLOR_GRAY='\e[0;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'

# customize prompt
source ~/.git-prompt.sh
export PS1="\[${COLOR_PURPLE}\]\u@\h\[${COLOR_GREEN}\] \w \[${COLOR_YELLOW}\]\t\[${COLOR_RED}\]\$(__git_ps1)\n\[${COLOR_NC}\]$ " 

# ussh
export USSH_USER=asingh
export POD1='chef_environment:production* AND pod:1 AND sendgrid_tags:mc_data'
export POD2='chef_environment:production* AND pod:2 AND sendgrid_tags:mc_data'
export POD3='chef_environment:production* AND pod:3 AND sendgrid_tags:mc_data'
export POD4='chef_environment:production* AND pod:4 AND sendgrid_tags:mc_data'
export POD5='chef_environment:production* AND pod:5 AND sendgrid_tags:mc_data'
export POD6='chef_environment:production* AND pod:6 AND sendgrid_tags:mc_data'
export POD7='chef_environment:production* AND pod:7 AND sendgrid_tags:mc_data'

# aliases
alias l="ls"
alias ll="ls -la"

# SG aliases
alias sendgrid="cd ~/go/src/github.com/sendgrid/"
alias mc-contacts="cd ~/go/src/github.com/sendgrid/mc-contacts"
alias goseg="cd ~/go/src/github.com/sendgrid/go_segment"
alias github="cd ~/go/src/github.com/"

# history stuffs
export HISTCONTROL=ignoreboth:erasedups

# knife helpers
function ksn() {
	if [ "$#" -ne 2 ]; then
                echo "usage: role env"
                return
        fi
	knife search node "role:${1} AND chef_environment:${2}" -i
}
function kssh() {
	if [ "$#" -ne 3 ]; then
		echo "usage: role env \"cmd\""
		return
	fi
	knife ssh "role:${1} AND chef_environment:${2}" "${3}" -xahoyle
}

# clean up docker stuff
function danglebegone() {
	docker rmi $(docker images -f "dangling=true" -q)
	docker kill $(docker ps -q); docker rm -vf $(docker ps -aq)
	docker run -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker --rm martin/docker-cleanup-volumes
}
function pushNlvxTag() {
	if [ "$#" -ne 2 ]; then
		echo "usage: <nlvx_stage_sha> <rpm_tag> i.e. 1.2.3-4.el6"
		return
	fi
	nlvx # cd to nlvx dir
	git fetch --all --tags
	git tag -fa "${2}" -m 'new nlvx version' "${1}"
	git push origin "${2}" -f
}
function dbash() {
  docker exec -ti `docker ps | grep $1 | awk '{ print $1 }'` bash
}

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

