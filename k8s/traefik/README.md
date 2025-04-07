Install traefik with the following command within the same folder:
```bash
helm install traefik traefik/traefik --namespace traefik --create-namespace --values traefik-values.yml
```

Then apply the middleware file to allow redirection from http to https automatically:
```
kubectl apply -f middleware.yml
```

For testing if everything is working correctly, apply the nginx-test.yml file and check you can access the web. Remind set DNS before!!

```
kubectl apply -f nginx-test.yml
```

