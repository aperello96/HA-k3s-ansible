Instala el repo de helm:
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

2. Crea un namespace:
```
kubectl create ns monitoring
```

3. Crea un archivo con las credenciales que vamos a usar:

```
echo -n 'adminuser' > ./admin-user # change your username
echo -n 'p@ssword!' > ./admin-password # change your password
```
y crea el secret:
```
 kubectl create secret generic grafana-admin-credentials --from-file=./admin-user --from-file=admin-password -n monitoring
```
Verifica si estan bien las credenciales y borra los archivos creados

4. Instalamos prometheus:
```
helm install -n monitoring prometheus prometheus-community/kube-prometheus-stack -f values.yaml
```

fuente: https://technotim.live/posts/kube-grafana-prometheus/