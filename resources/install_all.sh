#!/usr/bin/env bash

# This runs everyting for assignment 1
# Author: nirbenz
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
sudo dpkg-reconfigure -f noninteractive locales
sudo apt-get install -y unzip zip
# wget http://cs231n.stanford.edu/assignments/2017/spring1617_assignment1.zip && unzip spring1617_assignment1.zip
wget http://cs231n.github.io/assignments/2018/spring1718_assignment1.zip && unzip spring1718_assignment1.zip
cd assignment1
# cp setup_googlecloud.sh setup_googlecloud_orig.sh
# sed -i 's/sudo apt-get install /sudo apt-get install -y /g' setup_googlecloud.sh 
# sed -i 's/sudo apt-get build-dep /sudo apt-get build-dep -y /g' setup_googlecloud.sh 
# ./setup_googlecloud.sh


# This is the set-up script for Google Cloud, edited to taste by nir
sudo apt-get update
sudo apt-get install -y libncurses5-dev
PYTHON_VERSIONS="2.7 3.5"
sudo apt-get install -y python-dev python3-dev
# sudo apt-get install -y python-pip python3-pip
wget https://bootstrap.pypa.io/get-pip.py && \
    for VERSION in ${PYTHON_VERSIONS}; do sudo python$VERSION get-pip.py; done && \
    rm get-pip.py
for VERSION in ${PYTHON_VERSIONS}; do pip$VERSION install --upgrade pip; done
#
sudo apt-get install -y libjpeg8-dev
sudo ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib
sudo apt-get build-dep -y python-imaging
sudo apt-get install -y libjpeg8 libjpeg62-dev libfreetype6 libfreetype6-dev
sudo pip install virtualenv && sudo pip3 install virtualenv
virtualenv .env                  # Create a virtual environment
source .env/bin/activate         # Activate the virtual environment
# pip install -r requirements.txt  # Install dependencies
pip install pillow && pip3 install pillow
for VERSION in ${PYTHON_VERSIONS}; do pip$VERSION install -r requirements.txt; done && \
    rm requirements.txt
deactivate
# add some shortcuts
echo "bind '\"\e[B\": history-search-forward'" >> ~/.bashrc
echo "bind '\"\e[A\": history-search-backward'" >> ~/.bashrc
echo "alias course='source $PWD/.env/bin/activate'" >> ~/.bashrc
source ~/.bashrc
# done
echo "**************************************************"
echo "*****  End of Google Cloud Set-up Script  ********"
echo "**************************************************"
echo ""
echo "If you had no errors, You can proceed to work with your virtualenv as normal."
echo "(run 'source .env/bin/activate' in your assignment directory to load the venv,"
echo " and run 'deactivate' to exit the venv. See assignment handout for details.)"