#!/bin/bash -xe

### All functions prefaced with "aws"
### *_list() fucntions all return a list
### *_get() functions return a single value

aws_list_all_regions() {

    ### Uses the default region set inside your aws keychain
    ### Either set aws_default_region in your credentials file at ~/.aws/credentials
    ### Or set the region key in your ~/.aws/config for the profile you're using

    aws ec2 describe-regions \
        --query "Regions[*].RegionName"
}

aws_list_all_asgs_in_region() {

    local _region=$1

    aws autoscaling describe-auto-scaling-groups \
        --region "${_region}" \
        --query "AutoScalingGroups[*].AutoScalingGroupName" \
        --output json

}

### TODO: Get the comparison working in the JMESPATH query
aws_list_asg_containing() {

    local _asg_search_string=$1
    local _region=$2

    for _asg in $(aws autoscaling describe-auto-scaling-groups \
                --region "${_region}" \
                --query "AutoScalingGroups[*].AutoScalingGroupName" \
                --output text); do

                    if [[ "${_asg}" =~ ${_asg_search_string} ]]; then
                        echo "${_asg}"
                    fi
    done
}

aws_list_private_ip_by_tag() {

    local _key=$1
    local _value=$2
    local _region=$3

    aws ec2 describe-instances \
        --filter Name=tag:"${_key}",Values="${_value}" \
        --region "${_region}" \
        --query "Reservations[*].Instances[*].PrivateIpAddress" \
        --output text
}

aws_list_public_ip_by_tag() {

    local _key=$1
    local _value=$2
    local _region=$3

    aws ec2 describe-instances \
        --filter Name=tag:"${_key}",Values="${_value}" \
        --region "${_region}" \
        --query "Reservations[*].Instances[*].PublicIpAddress" \
        --output text
}
