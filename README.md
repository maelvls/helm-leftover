# Helm 2 removes old objects

Just a quick test that shows that Helm 2 is able to remove objects that
have been deleted in the new release. `test/` contains a release that has
an ingress; `test2` contains the same release except the ingress has been
removed.

To test it, first get helm2 and kind and create a cluster with tiller:

```sh
GO111MODULE="on" go get sigs.k8s.io/kind@v0.9.0
kind create cluster

curl -L https://get.helm.sh/helm-v2.16.9-linux-amd64.tar.gz | tar xz -C /tmp && install /tmp/linux-amd64/helm ~/go/bin/helm2

helm2 init
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
```

Then, let's install the chart with the ingress enabled. If we disable the
ingress, the object disappears from the cluster:

```sh
# The first release has an ingress.
helm2 install --name test ./test --set ingress.enabled=true --set ingress.enabled=true --set "ingress.hosts[0].paths[0]=/"
kubectl get ingress

# The second one doesn't have an ingress.
helm2 upgrade test ./test --set ingress.enabled=false
kubectl get ingress
```
