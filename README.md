# Helm 2 removes old objects

Just a quick test that shows that Helm 2 is able to remove objects that
have been deleted in the new release. `test/` contains a release that has
an ingress; `test2` contains the same release except the ingress has been
removed.

To test it:

```sh
./setup-helm2-and-tiller.sh

# The first release has an ingress.
helm2 install --name test ./test --set ingress.enabled=true --set ingress.enabled=true --set "ingress.hosts[0].paths[0]=/"
kubectl get ingress

# The second one doesn't have an ingress.
helm2 upgrade test ./test --set ingress.enabled=false
kubectl get ingress
```
