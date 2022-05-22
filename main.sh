#!/bin/bash

delimiter=','
folders=($1)

IFS=","
read -a strarr <<< "$folders"

# NOTE: the following does not work on mac
# readarray -d , -t folders <<< "$folders"

echo "${folders[@]}"
echo "${#folders[@]}"

all_tf_folders=`find . -type f -name '*.tf' | sed 's#/[^/]*$##' | sed 's/.\///'| sort | uniq`
echo 
echo "ALL tf files"
echo $all_tf_folders
echo "${all_tf_folders[@]}"
echo "${#all_tf_folders[@]}"

list=()
# IMPORTANT:
# add this to scan_type option
for folder in "${folders[@]}"
do
    # NOTE: https://unix.stackexchange.com/questions/111949/get-list-of-subdirectories-which-contain-a-file-whose-name-contains-a-string 
    # all_tf_folders=`find $folder -name '*.tf' -printf '%h\n' | sort -u`
    all_tf_folders_subfolders=`find $folder -type f -name '*.tf' | sed -r 's|/[^/]+$||' | sort | uniq`
    echo
    echo "TF files exist in $folder"
    list+=("$all_tf_folders_subfolders")
done

uniq_list=($(for item in "${list[@]}"; do echo "${item}"; done | sort -u))

echo "${uniq_list[@]}"
echo "${#uniq_list[@]}"

# Q: why is the value of this not 4 if it contains this many elements, does it matter?
i=0
for thing in "${uniq_list[@]}"
do
    echo "$thing = $i"
done