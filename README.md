# "Hello World" Enjoying-with-terraform

Since the technical test is more of a demonstration of technical skills rather than fulfilling a specific business requirement, I took the liberty to adapt it to demonstrate knowledge in: 

- Kubernetes on EKS, RBAC, Roles and RoleBinding, Services
- Monitoring and Observability with AWS CloudWatch configured via Terraform (as well as all the infrastructure)
- Public and private microservices using virtual networks, VPN, security rules, and their relation to different services in Kubernetes
- The public port was added using Amazon API Gateway instead of using an ingress controller
- Relational and non-relational databases with RDS and Dynamo DB
- Server provisioning using Ansible with Kubernetes Jobs
- Secrets encryption using kubeseal and ansible vault

Each syllable of the “Hello World” message is retrieved from different microservices connected via Amazon SQS. Some of these services make requests to RDS and Dynamo DB instances with the most optimal security configuration possible.

## ALL THE INFRASTRUCTURE WAS CREATED USING A TEMPORARY SANDBOX SESSION FROM KODEKLOUD, SO EVEN THOUGH IT IS ENCRYPTED FOR PRACTICAL PURPOSES, YOU NEED TO CHANGE THE VARIABLES TO RUN THE INFRASTRUCTURE: 

Commands to decrypt the Ansible Vault:
Password: josedevops
```
ansible-vault decrypt roles/python_server/vars/vault.yml

ansible-vault decrypt roles/nodejs_server/vars/vault.yml

ansible-vault decrypt roles/go_server/vars/vault.yml
```

## Kubeseal was used to encrypt the deployment YAMLs, and the secrets.yml file was added to the gitignore.

## Things that were missing in this exercise:
- Different environments (test/dev/staging)
- Gitflow with branching policies for dev and main
- 4 production environments instead of just 1 (dev, test, staging, main)
- Each backend having its own repository plus the infra repository
- Argo CD implementation
- There are only CI pipelines for the Python server; once it passes the tests and SonarCloud approval, the full infra CD pipeline runs
- The infrastructure was run locally, and the environment variables to run the two pipelines haven't been added
