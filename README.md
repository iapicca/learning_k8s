
# OpenTofu Kubernetes Cluster setup

## install tools

- brew install [opentofu]( https://github.com/opentofu/opentofu)
- brew install [age](https://github.com/FiloSottile/age)
- brew install [sops](https://github.com/getsops/sops)
- brew install [go-task](https://taskfile.dev/)

## ssh setup

- create `.ssh` folder in the home directory and add permissions \
    `mkdir -p ~/.ssh && chmod 700 ~/.ssh`

- add key to zsh\
    ```
    echo 'export DIGITAL_OCEAN_PRIVATE_KEY=$HOME"/.ssh/do_ssh_key"' >> ~/.zshrc && \
    echo 'export DIGITAL_OCEAN_PUBLIC_KEY=$DIGITAL_OCEAN_PRIVATE_KEY".pub"' >> ~/.zshrc
    ```

- create ssh key
    `ssh-keygen -t ed25519 -C "francesco@yakforward.com" -f "$(echo $DIGITAL_OCEAN_PRIVATE_KEY)"`

- copy the location of the public key in `main.tf`
    `sed -i '' "s|digitalocean_public_key_location|\"${DIGITAL_OCEAN_PUBLIC_KEY}\"|g" main.tf`

- copy the location of the private key in `main.tf`
    `sed -i '' "s|digitalocean_private_key_location|\"${DIGITAL_OCEAN_PRIVATE_KEY}\"|g" main.tf`

## digital toven token setup

- create a encryption key\
    `age-keygen -o ~/.sops/key.txt`
- add file location to .zshrc (or whatever)\
    `echo "export SOPS_AGE_KEY_FILE='$HOME/.sops/key.txt'" >> ~/.zshrc`
- copy age public key into `.sops.yaml`\
    `sed -i '' "s/age_public_key/$(sed -n 's/# public key: //p' $SOPS_AGE_KEY_FILE)/" .sops.yaml`

### encrypt

- run `sops --encrypt secrets.tfvars.json > encrypted.tfvars.json`

### decrypt

- run `sops --decrypt encrypted.tfvars.json > secrets.tfvars.json`

### NOTES
- sops doesn't support *.ftvars, so just use *.ftvars.json

## OPENTOFU 

- tofu init

- tofu apply -var-file="secrets.tfvars.json"

- tofu destroy -var-file="secrets.tfvars.json"

## Login in remote server

- ssh -i $DIGITAL_OCEAN_PRIVATE_KEY root@{{ip address here}}