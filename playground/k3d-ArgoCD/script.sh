sudo apt install net-tools > /dev/null 2>&1

echo '--------------------- 1. Installing Docker. ---------------------'
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker vagrant
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

echo '--------------------- 5. Creating a cluster & Installing ArgoCD ---------------------'
k3d cluster create dev-cluster
mkdir /home/vagrant/.kube && k3d kubeconfig get dev-cluster > /home/vagrant/.kube/config 
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl -n argocd rollout status deployment argocd-server

echo '--------------------- 6.  Deploying argoCD APP ---------------------'
kubectl apply -n argocd -f /vagrant/application.yaml


echo '--------------------- 7.  Exposing Argocd Server  ---------------------'
IP=$(hostname -I | awk '{print $1}')
export ARGOCD_USER=admin
export ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
kubectl port-forward svc/argocd-server -n argocd 8080:443 --address 0.0.0.0 > /dev/null 2>&1 &
echo "Server running on: $(hostname -I | awk '{print $1}'):8080"
echo "USERNAME: $ARGOCD_USER"
echo "PASSWORD: $ARGOCD_PASSWORD"