# Deployment of a FortiGate-VM(BYOL/PAYG) on the Azure

## Introduction

A Terraform script to deploy a FortiGate-VM(BYOL/PAYG) on Azure

## Requirements

* [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) >= 1.0.7
* Terraform Provider AzureRM >= 2.78.0
* Terraform Provider Template >= 2.2.0
* Terraform Provider Random >= 3.1.0

## Deployment overview

Terraform deploys the following components:

* Azure Virtual Network with 2 subnets
* One FortiGate-VM instances with 2 NICs
* Two firewall rules: one for external, one for internal.

## Deployment

To deploy the FortiGate-VM to Azure:

1. Clone the repository.
1. Customize variables in the `variables.tf` file as needed.

1. Initialize the providers and modules:

   ```sh
   cd XXXXX
   terraform init
   ```

1. Submit the Terraform plan:

   ```sh
   terraform plan
   ```

1. Verify output.

1. Confirm and apply the plan:

   ```sh
   terraform apply
   ```

1. If output is satisfactory, type `yes`.

Output will include the information necessary to log in to the FortiGate-VM instances:

```sh
FGTPublicIP = <FGT Public IP>
Password = <FGT Password>
ResourceGroup = <Resource Group>
Username = <FGT Username>
```

## Destroy the instance

To destroy the instance, use the command:

```sh
terraform destroy
```

## Support

Fortinet-provided scripts in this and other GitHub projects do not fall under the regular Fortinet technical support scope and are not supported by FortiCare Support Services.
For direct issues, please refer to the [Issues](https://github.com/fortinet/fortigate-terraform-deploy/issues) tab of this GitHub project.
For other questions related to this project, contact [github@fortinet.com](mailto:github@fortinet.com).

## License

[License](https://github.com/fortinet/fortigate-terraform-deploy/blob/master/LICENSE) © Fortinet Technologies. All rights reserved.
