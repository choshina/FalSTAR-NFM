import sys,os
str = sys.argv[1]
print(str)
command = 'cp src/all/*' + str + '* src/benchmarks/'
print(command)
os.system(command)
