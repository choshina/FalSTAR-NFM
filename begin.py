import sys,os
str = sys.argv[1]
print(str)
os.system('rm src/benchmarks/*')
command = 'cp src/all/*' + str + '* src/benchmarks/'
print(command)
os.system(command)
