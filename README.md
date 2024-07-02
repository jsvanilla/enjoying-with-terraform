# "Hello World" Enjoying-with-terraform

Dado que la prueba técnica es mas una demostración de skills técnicos que de cumplir un requerimiento de negocio especifico, me di a la libertad de adaptarla para demostrar conocimientos en: 

- Kubernetes en EKS, RBAC, Roles y RoleBiding, Services
- Monitoreo y Observabilidad con AWS CloudWatch configurado desde terraform (al igual que toda la infra)
- Microservicios publicos y privados con virtual networks, vpn, security rules, y su relación con los distintos services en Kubernetes
- El puerto publico se agregó usando Amazon API Gateway en lugar de usar un ingress controller
- Bases de datos relacionales y no relacionales con RDS y Dynamo DB
- Provisionamiento de servidores usando Ansible con los Jobs de Kubernetes


Cada silaba del “Hola Mundo” se extrae de diferentes microservicios conectados por Amazon SQS. Algunos de los cuales hacen request a instancias de RDS y Dynamo DB con la configuración de seguridad mas optima posible

## TODA LA INFRA SE CREO USANDO UNA SESION TEMPORAL DE SANDBOX DE KODEKLOUD, POR LO QUE AUNQUE ESTA ENCRIPTADO PARA PROPOSITOS PRACTICOS, HAY QUE CAMBIAR LAS VARIABLES PARA CORRER LA INFRA: 

Comandos para desencriptar el Ansible Vault:
Contraseña: josedevops
```
ansible-vault decrypt roles/python_server/vars/vault.yml

ansible-vault decrypt roles/nodejs_server/vars/vault.yml

ansible-vault decrypt roles/go_server/vars/vault.yml
```

## Se usó kubeseal para encriptar los deployments yml y se colocó en el gitignore el archivo sectrets.yml

## Cosas que faltaron en este ejercicio:
- Distintos ambientes (test/dev/stagging)
- Gitflow con políticas de branching en dev y main
- 4 ambientes productivos en lugar de solo 1 (dev, test, stagging, main)
- Que cada backend tenga su propio repo mas el repo de la infra
- Implementación de Argo CD
- Solo hay pipelines de CI del servidor de python, una vez que pasa los test y la aprobacion de sonarcloud, se corre en CD el pipeline completo de infra
- La infra se corrió en local, y no se han añadido las variables de entorno para correr los 2 pipelines