#!/bin/sh

max=$DAYS
namespace=$NAMESPACE

thres=$(date -d '- '$max' days' -Ins --utc | sed 's/+0000/Z/')
echo "delete '$namespace' deployments"
kubectl -n $namespace get deploy -o go-template --template '{{range .items}}{{.metadata.name}} {{.metadata.creationTimestamp}}{{"\n"}}{{end}}' | awk '$2 <= $thes { print $1 }' | xargs --no-run-if-empty kubectl -n $namespace delete deploy

echo "delete '$namespace' services"
kubectl get svc -n $namespace -o go-template='{{range .items}}{{ $save := . }}{{range.spec.ports}}{{if .nodePort}}{{$save.metadata.name}} {{$save.metadata.creationTimestamp}}{{"\n"}}{{end}}{{end}}{{end}}' | awk '$2 <= $thres { print $1 }' | xargs --no-run-if-empty kubectl -n $namespace delete svc
