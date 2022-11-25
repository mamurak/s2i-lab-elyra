#!/bin/bash
set -x

replace_invalid_characters (){
  python -c 'import sys;print(sys.argv[1].translate ({ord(c): "-" for c in "!@#$%^&*()[]{};:,/<>?\|`~=_+"}))' "$1"
}


elyra-metadata install runtimes --schema_name=kfp \
                                --name=my_kfp \
                                --display_name=Default \
                                --auth_type=NO_AUTHENTICATION \
                                --api_endpoint=http://ds-pipeline-ui."$KF_DEPLOYMENT_NAMESPACE".svc.cluster.local:3000/pipeline \
                                --cos_endpoint=http://s3.openshift-storage.svc.cluster.local \
                                --cos_auth_type=USER_CREDENTIALS \
                                --cos_username="$AWS_ACCESS_KEY_ID" \
                                --cos_password="$AWS_SECRET_ACCESS_KEY" \
                                --cos_bucket="$COS_BUCKET" \
                                --engine=Tekton
