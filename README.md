# FalSTAR-NFM
An artifact for submission of NFM 2021


# Install
## System requirement

- Operating system: Linux or MacOS;

- Matlab version: >= 2017.


## Installation
1. make sure that Matlab directory is in your system path.

Mac OS:  write to ~/.bash_profile

Linux:  write to ~/.bashrc

'export PATH=$PATH:[your Matlab path]/bin'

and restart the console.

sanity check: type 'matlab -nodesktop' in a terminal and then you can use Matlab in commandline

2. git clone https://github.com/choshina/FalSTAR-NFM.git

3. "git submodule init" and then "git submodule update" to obtain breach

### Installing Breach

1. Open Matlab;

2. Install breach following instructions in https://github.com/decyphir/breach, which consists in

- setup a C/C++ compiler using command ’mex -setup’
– Please check here for instructions on how to select the compiler for different
operating systems: https://www.mathworks.com/help/matlab/matlab_
external/changing-default-compiler.html

- run ’InstallBreach’
