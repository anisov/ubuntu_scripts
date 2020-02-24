echo -e "\033[32mGit username: \033[0m"
read gituser

echo -e "\033[32mGit email: \033[0m"
read gitemail

PG_VERSION='10'
echo -e "\033[32mВведи номер нужной версии postgres [$PG_VERSION]: \033[0m"
read pg_version
if [[ -z $pg_version ]]
then
    pg_version=$PG_VERSION
fi

sudo apt -y update && apt -y upgrade
echo -e "\033[32mUPDATED && UPGRADED\033[0m"

sudo apt -y install apt-transport-https ca-certificates wget gnome-tweaks nano mc vim htop net-tools apt-utils openssl
echo -e "\033[32mInstalled: apt-transport-https ca-certificates wget gnome-tweaks, nano, mc, vim, htop, net-tools, apt-utils, openssl\033[0m"

echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
wget https://dl.google.com/linux/linux_signing_key.pub
sudo apt-key add linux_signing_key.pub
sudo apt -y update
sudo apt -y install google-chrome-stable
echo -e "\033[32mInstalled: Chrome\033[0m"

sudo apt -y install git
git config --global user.name $gituser
git config --global user.email $gitemail
echo -e "\033[32mInstalled: GIT\033[0m"

sudo apt install -y curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get -y update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -a -G docker dmitriy
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo -e "\033[32mInstalled: Docker + docker-compose\033[0m"

ssh-keygen -q -N ""
echo -e "\033[32mInstalled: ssh generated\033[0m"

sudo apt -y install python-pip python3-pip
echo -e "\033[32mInstalled: pip/pip3\033[0m"

sudo apt -y install build-essential libssl-dev libffi-dev python3-dev
echo -e "\033[32mInstalled: build-essential libssl-dev libffi-dev python3-dev\033[0m"

sudo pip3 install virtualenvwrapper
echo "export VIRTUALENVWRAPPER_PYTHON=`which python3`
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel 
source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
source ~/.bashrc
echo -e "\033[32mInstalled: virtualenvwrapper\033[0m"

sudo apt -y install postgresql-$pg_version mongodb redis-server rabbitmq-server nginx nodejs
echo -e "\033[32mInstalled: postgresql, mongodb, redis, rabbitmq-server, nginx, nodejs\033[0m"

curl -L https://npmjs.org/install.sh | sudo sh
echo -e "\033[32mInstalled: npm\033[0m"

echo -e "\033[32mAll done!\033[0m"
