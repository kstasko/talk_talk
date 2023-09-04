### USEFUL COMMANDS

--- 

`gh issue develop <issue-number> -n <issue-number> -c`  
*This command opens a new branch with the name of the branch being the issue number 
and then checkouts the branch.*

--- 

### GENERAL
#### LOCAL DEPLOYMENT
*prerequisite : CLI access to an aws account*

```bash
cd infra && \
terraform fmt && \
terraform init && \
terraform plan && \
terraform apply
```