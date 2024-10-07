sudo apt install net-tools > /dev/null 2>&1

echo '--------------------- 1. Installing Docker. ---------------------'
curl -fsSL https://get.docker.com | sh

echo '--------------------- 2. Configuring Docker. ---------------------'

echo '------------------------- 2.1 Create the docker group. ---------------------'
sudo groupadd docker
groups

echo '------------------------- 2.2 Add vagrant user to the docker group. ---------------------'
sudo usermod -aG docker vagrant
groups vagrant

echo '------------------------- 2.3 Activate the changes to groups. ---------------------'
newgrp docker

echo '------------------------- 2.4 Configure Docker to start on boot. ---------------------'
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

echo '--------------------- 3. Installing Kubectl. ---------------------'
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin
kubectl version --client
rm -f kubectl

echo '--------------------- 4. Installing K3D. ---------------------'
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
k3d --version

echo '--------------------- 5. Creating a cluster. ---------------------'
k3d cluster create mycluster
mkdir /home/vagrant/.kube && k3d kubeconfig get mycluster > /home/vagrant/.kube/config 
kubectl get node
