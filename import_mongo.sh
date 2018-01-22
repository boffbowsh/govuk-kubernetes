#! /bin/bash

if [ -z $2 ]; then
  echo "Usage: ./import_mongo.sh <full path to db directory> <target db name>"
  exit 1
fi

read -r -d '' OVERRIDE <<EOF
{
  "apiVersion": "batch/v1",
  "kind": "Job",
  "spec": {
    "template": {
      "spec": {
        "containers": [
          {
            "name": "mongo-import-data",
            "image": "bitnami/mongodb:3.4.5-r0",
            "volumeMounts": [{
              "mountPath": "/replication",
              "name": "replication"
            }],
            "command": [
              "mongorestore",
              "--host=govuk-mongodb",
              "--db=$2",
              "/replication"
            ]
          }
        ],
        "volumes": [{
          "name":"replication",
          "hostPath":{
            "path": "$1"
          }
        }]
      }
    }
  }
}
EOF

kubectl run -i --rm --tty --generator job/v1 --overrides="$OVERRIDE" \
  mongo-import-data \
  --image=bitnami/mongodb:3.4.5-r0 --restart=Never -- \
  mongorestore --host=govuk-mongodb --db=$2 /replication

