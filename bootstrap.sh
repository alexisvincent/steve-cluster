# Inject ssh keys
mkdir -p .ssh
cat matchbox/assets/keys/bootstrapper.pub >> ~/.ssh/authorized_keys
./steve reload network
./steve reload services