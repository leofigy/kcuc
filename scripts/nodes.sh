#!/usr/bin/env bash

echo "creating vms"
multipass launch -c 1 -m 1G -d 5G -n k3s-master 18.04
multipass launch -c 1 -m 1G -d 5G -n k3s-worker1 18.04
multipass launch -c 1 -m 1G -d 5G -n k3s-worker2 18.04

echo "setting k3s"
multipass exec k3s-master -- bash -c "curl -sfL https://get.k3s.io | sh -"

echo "getting token"
TOKEN=$(multipass exec k3s-master -- bash -c "sudo cat /var/lib/rancher/k3s/server/node-token")
echo $TOKEN

echo "getting master ip"
IP=$(multipass info k3s-master | grep IPv4 | awk '{print $2}')
echo $IP

 for f in 1 2; do
     multipass exec k3s-worker$f -- bash -c "curl -sfL https://get.k3s.io | K3S_URL=\"https://$IP:6443\" K3S_TOKEN=\"$TOKEN\" sh -"
 done