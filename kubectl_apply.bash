kubectl apply -f namespaces/backend-namespace.yml

kubectl apply -f configmap-ansible-playbooks.yml
kubectl apply -f configmap-ansible-roles.yml

kubectl apply -f deployments/python-server-deployment.yml
kubectl apply -f deployments/nodejs-server-deployment.yml
kubectl apply -f deployments/go-server-deployment.yml

kubectl apply -f services/python-server-service.yml
kubectl apply -f services/nodejs-server-service.yml
kubectl apply -f services/go-server-service.yml

kubectl apply -f jobs/python-server-job.yml
kubectl apply -f jobs/nodejs-server-job.yml
kubectl apply -f jobs/go-server-job.yml

kubectl apply -f roles/role.yml
kubectl apply -f roles/rolebinding.yml

kubectl apply -f hpa/python-server-hpa.yml
kubectl apply -f hpa/nodejs-server-hpa.yml
kubectl apply -f hpa/go-server-hpa.yml