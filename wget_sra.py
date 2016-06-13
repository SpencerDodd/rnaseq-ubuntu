#!/bin/python
import subprocess

"""
This script grabs files from the NCBI's SRA db using wget
"""
files_to_get = [
	"SRR1039508", # success
	"SRR1039509", 
	"SRR1039512",
	"SRR1039513",
	"SRR1039516",
	"SRR1039517",
	"SRR1039520",
	"SRR1039521"
] 

def get_files(files_to_get):
	for file in files_to_get:
		command = "ftp ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/{}/{}/{}.sra".format(file[:6], file, file)
		subprocess.Popen(command, shell=True)

def main():
	get_files(files_to_get)

if __name__ == "__main__":
	main()