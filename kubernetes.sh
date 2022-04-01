#!/bin/bash


kub_pre=$(kubectl get pods -o wide |grep ip-172-31-25-163.ap-south-1.compute.internal | awk '{print $6}' | tail -1)

echo $kub_pre

kubectl delete -f /home/ec2-user/deploy.yml

sleep 20s

kubectl apply -f /home/ec2-user/deploy.yml

sleep 20s

kub_post=$(kubectl get pods -o wide |grep ip-172-31-25-163.ap-south-1.compute.internal | awk '{print $6}' | tail -1)


echo $kub_post


sed -i "s#$kub_pre#$kub_post#g" /etc/nginx/conf.d/kube.conf


service nginx restart

echo "app started"
