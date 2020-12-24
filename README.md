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

sanity check: type 'matlab' in commandline and you can open Matlab

2. Python 2.7

### Installing Breach

1. Open Matlab;

2. clone Breach from https://github.com/decyphir/breach, and reset it to version 1.2.13. Put it under 'src/' and name it as 'breach_1213'.

3. move to folder “FalStar-MAB/src/breach 1213/” of the cloned repository (either
from command line or using the browsing facilities of the GUI);

4. setup a C/C++ compiler using command ’mex -setup’
– Please check here for instructions on how to select the compiler for different
operating systems: https://www.mathworks.com/help/matlab/matlab_
external/changing-default-compiler.html

5. run ’InstallBreach’
