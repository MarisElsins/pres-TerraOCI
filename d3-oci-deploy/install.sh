#!/bin/bash

if [ $# -lt 2 ]
then
  echo "Usage: `basename $0` [dev|uat|prod] [plan|apply|destroy]"
  exit 1
fi

p_env=$1
p_action=$2

terraform workspace new ${p_env} > /dev/null 2>&1
terraform workspace select ${p_env}

RND1=$((1 + RANDOM % 20))
RND2=$((1 + RANDOM % 20))
RNDSUM=$(expr ${RND1} + ${RND2})

if [ ${p_env} == "prod" ] && ( [ "${p_action}" == "destroy" ] || [ "${p_action}" == "apply" ]) 
then
  echo "you're making a change in prod. Please respond to the following question:"
  read -p "${RND1} + ${RND2} = " SUMCHECK
  if [ ${RNDSUM} -ne ${SUMCHECK} ]
  then
    echo "ERROR: Sorry, you're math skills don't allow you to make changes in prod."
    exit 1
  fi
fi

terraform ${p_action}
