#! /bin/sh

curl -L https://get.helm.sh/helm-v2.16.9-linux-amd64.tar.gz | tar xz -C /tmp && install /tmp/linux-amd64/helm ~/go/bin/helm2

helm2 init
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
