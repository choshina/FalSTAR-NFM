# FalSTAR-NFM
An artifact for submission of NFM 2021


# Install
## System requirement

- Operating system: Linux or MacOS;

- Matlab version: >= 2017. (Matlab license needed)


## Installation
1. make sure that Matlab directory is in your system path.

Mac OS:  write to ~/.bash_profile

Linux:  write to ~/.bashrc

'export PATH=$PATH:[your Matlab path]/bin'

and restart the console.

sanity check: type 'matlab -nodesktop' in a terminal and then you can use Matlab in commandline

2. git clone https://github.com/choshina/FalSTAR-NFM.git

3. "git submodule init" and then "git submodule update" to obtain [breach](https://github.com/decyphir/breach)

### Installing Breach

1. Open Matlab;

2. Install breach following instructions in https://github.com/decyphir/breach, which consists in

- setup a C/C++ compiler using command ’mex -setup’
– Please check [here](https://www.mathworks.com/help/matlab/matlab_external/changing-default-compiler.html) for instructions on how to select the compiler for different operating systems.

- run ’InstallBreach’

# Usage:
## Reproducing experiments in Table 2

- run "python begin.py [specification ID]" in a terminal with a specification ID assigned. Then a column in Table 2 will run. 

## Customize testing

Customization of testing configuration can be done via the following steps:

1. "vi src/scriptgen/config/breach/[a configuration file]", e.g., breach_at.conf 

2. Change parameters, e.g., to run less trials rather than 30, it can be modified to "10"

3. "cd src/scriptgen/" and "python breach_test.py config/breach/[the configuration file modified]"

4. Go back to the root folder and run "make"

## Regarding RQ3

- Go to the directory "RQ3" and run "main" in Matlab. 
