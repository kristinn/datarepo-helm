#!/bin/bash

charts=("gcloud-sqlproxy" "datarepo-api" "datarepo-ui" "oidc-proxy")
chartpath=../

for i in "${charts[@]}"
do
#  sed -e "s/.Values/.Values./g templates/datarepo-api/api-deployment.yaml
  cp -rv ${chartpath}/${i}/templates/*.yaml templates/${i}/.
  yq m -x -i values.yaml ${chartpath}/${i}/values.yaml
done
