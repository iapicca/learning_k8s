
#IaC 

### install tools

- brew install [opentofu]( https://github.com/opentofu/opentofu)
- brew install [age](https://github.com/FiloSottile/age)
- brew install [sops](https://github.com/getsops/sops)

### setup

- create a encryption key\
    `age-keygen -o ~/.sops/key.txt`
- add file location to .zshrc (or whatever)\
    `echo "export SOPS_AGE_KEY_FILE='$HOME/.sops/key.txt'" >> ~/.zshrc`
- copy age public key into `.sops.yaml`\
    `sed -i '' "s/age_key/$(sed -n 's/# public key: //p' $SOPS_AGE_KEY_FILE)/" .sops.yaml`
