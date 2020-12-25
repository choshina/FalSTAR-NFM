# FalSTAR-NFM
Artifact evaluation for NFM 2021 submission
"On the Effectiveness of Signal Rescaling in Hybrid System Falsification"
by Zhenya Zhang, Deyun Lyu, Paolo Arcaini, Lei Ma, Ichiro Hasuo and Jianjun Zhao


# Install
## System requirement

- Operating system: Linux or MacOS;

- Matlab version: >= 2017. (Matlab license needed)


## Installation
1. make sure that Matlab directory is in your system path.

	- Mac OS:  write to ~/.bash_profile

	- Linux:  write to ~/.bashrc

		'export PATH=$PATH:[your Matlab path]/bin' and restart the console.

	- sanity check: type 'matlab -nodesktop' in a terminal and then you can use Matlab in commandline

2. git clone https://github.com/choshina/FalSTAR-NFM.git

3. "git submodule init" and then "git submodule update" to obtain [breach](https://github.com/decyphir/breach)

### Installing Breach

Install Breach following instructions in https://github.com/decyphir/breach, which consists in

- setup a C/C++ compiler using command ’mex -setup’
– Please check [here](https://www.mathworks.com/help/matlab/matlab_external/changing-default-compiler.html) for instructions on how to select the compiler for different operating systems.

- run ’InstallBreach’

# Usage:
## Reproduce the experiments reported in Table 2 (RQ1 and RQ2) of the paper

- In order to reproduce the results of a given "specification ID" of Table 2 of the paper, run the following command:
```bash
$ python begin.py [specification ID]
```
The specificaition IDs used in the experiments of the paper are: AT1, AT2, AT3, AT4, AT5, AT6, AT7, AT8, AT9, AFC1, AFC2, AFC3.


> Note that the worst case running time for a single specification is 5 hours, due to our setting of timeout 600s and trials 30. However, it is usually not that long because successful trials return as soon as they find a falsifying input. If you want to reduce the timeout and/or the number of trials, you can customize the testing configuration as explained below.

## Customize the testing configuration

Customization of the testing configuration can be done via the following steps:

1. "vi src/scriptgen/config/breach/[a configuration file]", e.g., breach_at.conf 

2. Change parameters, e.g., to run less trials rather than 30, it can be modified to "10"

3. "cd src/scriptgen/" and "python breach_test.py config/breach/[the configuration file modified in step 1]"

4. Go back to the root folder and run "make"

## Reproduce the experiments reported in Fig. 1 and RQ3 of the paper

- Go to the directory "RQ3" and run "main" in Matlab. 

- Configure main.m for running different models and specifications.
