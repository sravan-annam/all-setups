#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc

#! /bin/bash
#add access_key & secrete key from excel Sheet
aws configure
#used to download kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
#used to download kops
wget https://github.com/kubernetes/kops/releases/download/v1.25.0/kops-linux-amd64
#giving the permissions
chmod +x kops-linux-amd64 kubectl
mv kubectl /usr/local/bin/kubectl
mv kops-linux-amd64 /usr/local/bin/kops
#creating a buckets and configure with cluster
aws s3api create-bucket --bucket sravan.annam --region us-east-1
aws s3api put-bucket-versioning --bucket sravan.annam --region us-east-1 --versioning-configuration Status=Enabled
export KOPS_STATE_STORE=s3://sravan.annam
#creating the cluster
kops create cluster --name sravan.k8s.local --zones us-east-1a,us-east-1b --master-size t2.medium --master-count 1 --master-volume-size 40 --node-size t2.micro --node-count 2 --node-volume-size 40
kops update cluster --name sravan.k8s.local --yes --admin
