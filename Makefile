
ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
THRIFT_DIR := ${ROOT_DIR}files
GEN_DIR =${ROOT_DIR}gen-java
thrift_files = $(wildcard $(THRIFT_DIR:%=%/*.thrift))
BIN := bin
thrift = C:\thrift\thrift.exe



ifeq ($(OS),Windows_NT)
	SHELL := powershell.exe
	.SHELLFLAGS := -NoProfile -Command
	RM_F_CMD = Remove-Item -erroraction silentlycontinue -Force
    RM_RF_CMD = ${RM_F_CMD} -Recurse

else
	SHELL := bash
	RM_F_CMD = rm -f
	RM_RF_CMD = ${RM_F_CMD} -r

endif

build:
	echo "Generating sources for every thrift files in separate folders"
	$(foreach var,$(thrift_files),mkdir $(basename $(var));cd $(basename $(var));$(thrift) -r --gen java $(var) ; cd ..;echo "================End of  $(var)================";)
   
gen:
	echo "Generating sources for every thrift files in single folder"
	$(foreach var,$(thrift_files),$(thrift) -r --gen java $(var) ;echo "================End of  $(var)================";)

cleangen:
	${RM_RF_CMD} ${GEN_DIR}*


clean:
	$(foreach var,$(thrift_files),${RM_RF_CMD} $(basename $(var));echo "================Deleted $(basename $(var))================";)

all: build
.DEFAULT_GOAL := all
git:
	git status
	git add .
	git status
	git commit -m ${m}
	git push
