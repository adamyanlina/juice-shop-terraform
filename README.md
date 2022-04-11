# juice-shop-terraform
Terraform Infrastructure for Juice Shop

Configure environment securely, in the Google Cloud Platform.
SSH is only available to the bastion.

- You can only SSH to the bastion
- You can only connect to juice-shop-0 and juice-shop-1 from the bastion

## Getting started

Create project with id "tidy-etching-334517" in GCP.

Clone this repo and add your GOOGLE_CREDENTIALS file in GitHub secrets(although I think it's a good idea to store keys in Vault).

1. Generate SSH Key Pair
   ```sh
   ssh-keygen -t ed25519 -f ~/.ssh/ansbile_ed25519 -C ansible
   ```
2. Add SSH Key to GCP Project
   ```sh
   cat ~/.ssh/ansbile_ed25519.pub
   ```
3. Then run terraform workflow in Actions
