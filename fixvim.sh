#!/bin/bash

###############################################################################
#
# fixvim.sh - Fix vim and terminal annoyances on GAUL
#
# Author       : Jeff Shantz <x@y, x = jshantz4, y=csd.uwo.ca>
# Created      : June 12, 2011
# Last Updated : April 21, 2012
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
# * Getting an error 'Type xterm-256color unknown' each time you SSH in from
#   a Mac
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
# to .hacksrc, along with a kludge for OS X users
touch $HOME/.hacksrc
cat << "EOF" >> $HOME/.hacksrc

#--------------------------------------
# Hack 3 - Fixing vim Annoyances
#--------------------------------------

# Kludge for OS X -- see .hacks.login
if ($TERM == xterm-256color) then
    setenv OLDTERM $TERM
    setenv TERM xterm
endif

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
cat << "EOF" >> $HOME/.hacks.login

#--------------------------------------
# Hack 3 - Fixing vim Annoyances
#--------------------------------------

stty erase 

if ($?OLDTERM) then
    if ($OLDTERM == xterm-256color) then
        setenv TERM $OLDTERM
    endif
    unsetenv OLDTERM
endif

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
/aAT3v2yX/bLftkv+2W/SP8HnJnB7ABQAAA=
====


