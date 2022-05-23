#!/usr/bin/env bash

delimiter=','
folders=($1)

readarray -d , -t folders <<< "$folders"

all_tf_folders=`find . -type f -name '*.tf' | sed 's#/[^/]*$##' | sed 's/.\///'| sort | uniq`
echo 
echo "ALL tf files"
echo $all_tf_folders

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

echo "${list[@]}"
echo "${#list[@]}"

uniq_list=($(for item in "${list[@]}"; do echo "${item}"; done | sort -u))

echo "${uniq_list[@]}"
echo "${#uniq_list[@]}"
