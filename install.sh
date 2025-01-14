#!/bin/sh

# script to automatically do the following steps:
#   - install the dependencies to compile the program, i.e. install 'gcc', 'make' and 'libhidapi-dev'
#     remark: once the program is compiled, 'libhidapi-dev' isn't required any more, only 'libhidapi-libusb0' is
#   - compile the program
#   - move the program 'msiklm' to '/usr/local/bin/msiklm'
#   - run 'msiklm' with 'test' option to check if the keyboard is detected

echo "Installation script for MSIKLM - MSI Keyboard Light Manager"
echo "###########################################################"
sleep 1

echo "Installing dependencies..."
sleep 2

if (sudo apt install -y gcc make libhidapi-dev); then
    echo "Dependencies successfully installed"
    sleep 2
elif (sudo dnf install -y gcc make hidapi-devel); then
    echo "Dependencies successfully installed"
    sleep 2
elif (sudo yum install -y gcc make hidapi-devel); then
    echo "Dependencies successfully installed"
    sleep 2
elif (sudo pacman -S --noconfirm gcc make hidapi); then
    echo "Dependencies successfully installed"
    sleep 2
elif (sudo zypper install gcc make libhidapi-devel); then
    echo "Dependencies successfully installed"
    sleep 2
else
    echo "Dependencies could not be installed"
    exit 1
fi

echo "Compiling MSIKLM..."
sleep 2

# compile
if (make); then
    echo "Compiling finished successfully"
    sleep 2
else
    echo "Compiling failed"
    exit 1
fi

# install 'msiklm' to '/usr/local/bin/msiklm' which also makes it callable via the msiklm command
if (sudo make install); then
    make delete
    echo "Installation of MSIKLM finished successfully"
    sleep 2
else
    echo "Installation of MSIKLM failed"
    exit 1
fi;

echo "Testing MSIKLM..."
sleep 1

if (sudo msiklm test); then
    echo "To configure the keyboard run 'msiklm' with your configuartion of choice, for a list of valid commands run 'msiklm help'."
    echo "If you want to enable the autostart, run 'autostart.sh' with your configuartion of choice, to uninstall 'msiklm' run 'uninstall.sh'."
    echo "Thank you for using MSIKLM and have fun with it! :-)"
else
    echo "Testing of MSIKLM failed"
fi
