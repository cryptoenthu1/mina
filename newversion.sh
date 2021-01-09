sudo apt-get remove mina-testnet-postake-medium-curves
sleep 2
echo "deb [trusted=yes] http://packages.o1test.net release main" | sudo tee /etc/apt/sources.list.d/mina.list
sleep 2
sudo apt-get update
sleep 2
sudo apt-get install -y curl unzip mina-testnet-postake-medium-curves=0.2.2-1-b14e324 --allow-downgrades
sleep 2
wget -O ~/peers.txt https://raw.githubusercontent.com/MinaProtocol/coda-automation/bug-bounty-net/terraform/testnets/testworld/peers.txt
sleep 2
coda version
