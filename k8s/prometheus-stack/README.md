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

5. Agregamos una configuracion extra para poder ver logs que estan deshabilitados en k3s:

Vamos nodo a nodo y ejecutamos lo siguiente:

```
sudo systemctl edit k3s
```

En las lineas de ExecStart agregamos lo siguiente al final despues de traefik: --kube-controller-manager-arg bind-address=0.0.0.0 --kube-proxy-arg metrics-bind-address=0.0.0.0 --kube-scheduler-arg bind-address=0.0.0.0 --etcd-expose-metrics=true --kubelet-arg containerd=/run/k3s/containerd/containerd.sock

Quedaria asi:

```
### Editing /etc/systemd/system/k3s.service.d/override.conf
### Anything between here and the comment below will become the contents of the drop-in file



### Edits below this comment will be discarded


### /etc/systemd/system/k3s.service
# [Unit]
# Description=Lightweight Kubernetes
# Documentation=https://k3s.io
# After=network-online.target
#
# [Service]
# Type=notify
# ExecStartPre=-/sbin/modprobe br_netfilter
# ExecStartPre=-/sbin/modprobe overlay
# ExecStart=/usr/local/bin/k3s server --flannel-iface=bond0 --node-ip=10.10.10.10   --tls-san 10.10.10.20 --disable servicelb --disable traefik
# KillMode=process
# Delegate=yes
# # Having non-zero Limit*s causes performance problems due to accounting overhead
# # in the kernel. We recommend using cgroups to do container-local accounting.
# LimitNOFILE=1048576
# LimitNPROC=infinity
# LimitCORE=infinity
# TasksMax=infinity
# TimeoutStartSec=0
# Restart=always
# RestartSec=5s
#
# [Install]
# WantedBy=multi-user.target
```

Finalmente ejecutamos:

```
sudo systemctl daemon-reload
sudo systemctl restart k3s
```

fuente: https://technotim.live/posts/kube-grafana-prometheus/