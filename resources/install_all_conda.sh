#!/usr/bin/env bash

# This runs everyting for assignment 1
# Author: nirbenz
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
sudo dpkg-reconfigure -f noninteractive locales
sudo apt-get install -y unzip zip
# wget http://cs231n.stanford.edu/assignments/2017/spring1617_assignment1.zip && unzip spring1617_assignment1.zip
wget http://cs231n.github.io/assignments/2018/spring1718_assignment1.zip && unzip spring1718_assignment1.zip
cd assignment1 && \

# This is the set-up script for Google Cloud, edited to taste by nir
sudo apt-get update
sudo apt-get install -y libncurses5-dev
sudo apt-get install -y libjpeg8-dev
sudo ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib
# sudo apt-get install -y libjpeg8 libjpeg62-dev libfreetype6 libfreetype6-dev
# install miniconda
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3 && \
echo "export PATH=$HOME/miniconda3/bin:\$PATH" >> ~/.bashrc && \
source ~/.bashrc
# create env
conda create --yes -n cs231n-a1 python=3.6
# activate env
source activate cs231n-a1
conda install --yes pillow pil
# install all packages in conda unless unavailable there
echo "**************************************************"
echo "Installing conda packages, this might take a while."
echo "**************************************************"
while read requirement; do conda install --yes $requirement || pip install $requirement; done < requirements.txt
source deactivate
echo "**************************************************"
echo "*****  End of Google Cloud Set-up Script  ********"
echo "**************************************************"
echo ""
echo "If you had no errors, You can proceed to work with your virtualenv as normal."
echo "(run 'source .env/bin/activate' in your assignment directory to load the venv,"
echo " and run 'deactivate' to exit the venv. See assignment handout for details.)"