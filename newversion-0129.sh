docker rm -f mina
sleep 2
rm -rf $HOME/.coda-config
sudo apt-get remove -y mina-testnet-postake-medium-curves
sleep 2
echo "deb [trusted=yes] http://packages.o1test.net release main" | sudo tee /etc/apt/sources.list.d/mina.list
sleep 2
sudo apt-get update
sleep 2
sudo apt-get install -y curl unzip mina-testnet-postake-medium-curves=0.2.11-d075f83
sleep 2
wget -O ~/peers.txt https://raw.githubusercontent.com/MinaProtocol/coda-automation/bug-bounty-net/terraform/testnets/testworld/peers.txt
sleep 2
coda version
sleep 2
source .profile
sudo docker run --name mina -d --restart always -p 8301-8305:8301-8305 -v $(pwd)/peers.txt:/root/peers.txt -v $(pwd)/keys:/root/keys:ro -v $(pwd)/.coda-config:/root/.coda-config minaprotocol/mina-daemon-baked:0.2.11-d075f83-testworld-d075f83 daemon -peer-list-file $HOME/peers.txt -block-producer-key $KEYPATH -block-producer-password $MINA_PRIVKEY_PASS -insecure-rest-server -file-log-level Info -log-level Info -super-catchup
sleep 2
sudo docker exec -it mina coda client status
sleep 2
sudo docker logs --tail 1000 mina -f
