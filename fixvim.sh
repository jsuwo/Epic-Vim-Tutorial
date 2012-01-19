#!/bin/bash

###############################################################################
#
# fixvim.sh - Fix vim and terminal annoyances on GAUL
#
# Author: Jeff Shantz <x@y, x = jshantz4, y=csd.uwo.ca>
# Date  : June 12, 2011
#
# Fixes annoyances in vim, such as:
#
# * Not having colour syntax highlighting
# * Not being able to use the backspace and delete keys properly
# * Not being able to use the arrow keys
# * Not being able to use the PgUp / PgDown keys
#
# In addition to the above fixes in vim, it also solves the following
# issues at the command line:
#
# * Not being able to use the Delete key (i.e. it prints ~ every time you do)
# * Not being able to use the Home / End keys
# * Not being able to use the PgUp / PgDown keys in utilities like 'less'
#
###############################################################################

echo "fixvim.sh is fixing your vim and terminal woes!"
echo 

# Check if we have already sourced $HOME/.hacksrc
# in our $HOME/.tcshrc file.  If so, delete that line
# since we're going to add it below.

touch $HOME/.tcshrc
sed '/hacksrc/d' $HOME/.tcshrc > $HOME/tchsrc.tmp
mv $HOME/tchsrc.tmp $HOME/.tcshrc

# Add a line to $HOME/.tcshrc to source $HOME/.hacksrc

echo 'source $HOME/.hacksrc' >> $HOME/.tcshrc

# Add the TERMINFO definition and binding for the delete key
# to .hacksrc

touch $HOME/.hacksrc
cat << "EOF" >> $HOME/.hacksrc

#--------------------------------------
# Hack 3 - Fixing vim Annoyances
#--------------------------------------

setenv TERMINFO $HOME/.local/lib/terminfo
bindkey ^[[3~ delete-char

EOF

# Check if we have already sourced $HOME/.hacks.login
# in our $HOME/.login file.  If so, delete that line
# since we're going to add it below.

touch $HOME/.login
sed '/hacks.login/d' $HOME/.login > $HOME/login.tmp
mv $HOME/login.tmp $HOME/.login

# Add a line to $HOME/.login to source $HOME/.hacks.login

echo 'source $HOME/.hacks.login' >> $HOME/.login

# Setup the GAUL Hacks login script.  The stty erase
# command needs to be in a .login script and not a
# .rc script since it should only be run in an interactive
# terminal session.  Otherwise, you'll get the error
# "stty: : Invalid argument" next time you scp a file to
# obelix from your home computer.

touch $HOME/.hacks.login
cat <<EOF >> $HOME/.hacks.login

#--------------------------------------
# Hack 3 - Fixing vim Annoyances
#--------------------------------------

stty erase 

EOF

# Get the .vimrc file and the terminfo data from the bottom of 
# this script, decode it, and extract it to the user's root 
# directory.  Note: this will overwrite the user's .vimrc file.
# Most students will likely have never customized their .vimrc,
# so this won't be an issue.  However, just in case, we'll make
# a backup of the existing one.

if [[ -a $HOME/.vimrc ]]
then
	echo "An existing .vimrc file was found in your home directory"
	echo "This file has been backed up as .vimrc.bak"
	echo
	mv $HOME/.vimrc $HOME/.vimrc.bak
fi

payload_start=$(grep -n TERMINFO_PAYLOAD fixvim.sh | tail -1 | awk -F: '{print $1}')
payload_start=$((payload_start + 1))
tail +$payload_start $0 | uudecode -p fixvim.sh | gtar zxf - -C $HOME/ 2>&1 >/dev/null

cat << "EOF"
Fixes are complete.  Please logout, log back in, and enjoy!

If you have any questions, please free free to contact
Jeff Shantz at <x@y, x = jshantz4, y = csd.uwo.ca>.

Also, be sure to check out the GAUL Hacks video series at
http://bit.ly/gaulhacks

EOF

exit 0

TERMINFO_PAYLOAD:
begin-base64 600 fixvim.tar.gz
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
AA==
====
