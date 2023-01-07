<p align="center">
  <a href="https://www.terraform.io/" target="blank"><img src="https://www.vectorlogo.zone/logos/terraformio/terraformio-icon.svg" width="120" alt="Terraform" /></a>
  <a href="https://www.terraform.io/" target="blank"><img src="https://www.vectorlogo.zone/logos/kubernetes/kubernetes-icon.svg" width="120" alt="Terraform" /></a>
</p>

<p align="center">A terraform configuration file for quickly deploying k8s cluster to your Proxmox Infrastructure</p>


## Description

Terraform is an open-source infrastructure as code software tool that enables you to safely and predictably create, change, and improve infrastructure. Other than that terraform enables you to quickly deploy and reduce the overhead for manualy setup the infratrure from the Proxmox Web UI.

## Usage

Create a Terraform variable for the cluster and secrets configuration
```bash
touch credentials.auto.tfvars
```
```bash
touch cluster.auto.tfvars
```

Fill the required variables to configure the cluster. You can see the required variables inside the variable.tf file. 

Example for *credentials.auto.tfvars:*

```
proxmox_api_url          = "(proxmox api server url)"
proxmox_api_token_id     = "(token id)"
proxmox_api_token_secret = "(token secret)"
ciuser                   = "(user)"
cipassword               = "(pass)"
sshkeys = "(secrets)"
```

Example for *cluster.auto.tfvars:*

```
control-planes = {
    "control-plane-1" = {
        vmid        = '100'
        name        = 'control-planes-1'
        desc        = 'control-planes-1'
        target_node = 'SERVER-1'
        ipconfig0   = 'ip=10.35.10.20/24,gw=10.35.10.1'
    }
    "control-plane-2" = {
        vmid        = '101'
        name        = 'control-planes-2'
        desc        = 'control-planes-2'
        target_node = 'SERVER-1'
        ipconfig0   = 'ip=10.35.10.21/24,gw=10.35.10.1'
    }
}


workers = {
    "worker-1" = {
        vmid        = '102'
        name        = 'worker-1'
        desc        = 'worker-1'
        target_node = 'SERVER-1'
        ipconfig0   = 'ip=10.35.10.22/24,gw=10.35.10.1'
    }
    "worker-2" = {
        vmid        = '103'
        name        = 'worker-2'
        desc        = 'worker-2'
        target_node = 'SERVER-1'
        ipconfig0   = 'ip=10.35.10.23/24,gw=10.35.10.1'
    }
}
```

To start the deployment process you'll need to install the providers to communicate with the PROXMOX server. run the following command to download the providers
```bash
terraform init
```

Next you can deploy the cluster using:
```
terraform apply
```
