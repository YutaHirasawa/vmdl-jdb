#!/bin/bash

VMDL_DIR="../ejs/vmdl"
BUILD_DIR="../ejs/build"

current_dir=`pwd`
target_args=(`echo $1 | sed -r 's/\s+/ /g'`)
exec_args=""
for arg in ${target_args[@]}
do
  if [ ${arg} = "java" ] || [ ${arg} = "-jar" ] || [[ ${arg} = *"/vmdlc.jar" ]]; then
    continue
  elif [[ ${arg} = "-"* ]] || [ -z `echo ${arg} | grep "/"` ]; then
    exec_args="${exec_args} ${arg}"
  else
    exec_args="${exec_args} ${BUILD_DIR}/${arg}"
  fi
done
echo ${exec_args}

cd ${VMDL_DIR}
ant compile
cd ${current_dir}
jdb -classpath ${VMDL_DIR}/bin vmdlc.Main ${exec_args}