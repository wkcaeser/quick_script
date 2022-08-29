echo -e "for centos system"

echo -e "start romove old docker component ..."

sudo yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
                  
echo -e "update yum-utils"
                  
sudo yum install -y yum-utils

echo -e "replace yum source to aliyun"

sudo yum-config-manager -y \
    --add-repo \
    https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    
sudo sed -i 's/download.docker.com/mirrors.aliyun.com\/docker-ce/g' /etc/yum.repos.d/docker-ce.repo

echo -e "start install docker-ce"

sudo yum install -y docker-ce docker-ce-cli containerd.io

echo -e "start docekr auto background"

sudo systemctl enable docker
sudo systemctl start docker
sudo groupadd docker
sudo usermod -aG docker $USER

echo -e "test docker"
docker run --rm hello-world
