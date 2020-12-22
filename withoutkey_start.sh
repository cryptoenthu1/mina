sudo apt-get remove mina-testnet-postake-medium-curves
sleep 5
echo "deb [trusted=yes] http://packages.o1test.net release main" | sudo tee /etc/apt/sources.list.d/mina.list
sleep 5
sudo apt-get update
sleep 5
sudo apt-get install -y curl mina-testnet-postake-medium-curves=0.1.1+-temporary-qa-staging-ci-wait-cf2b767
sleep 5
wget -O ~/peers.txt https://raw.githubusercontent.com/MinaProtocol/coda-automation/bug-bounty-net/terraform/testnets/testworld/peers.txt
sleep 5
cp .profile .profile_bkp
sleep 5
echo "export KEYPATH=$HOME/keys/my-wallet" >> .profile
echo "export MINA_PUBLIC_KEY=$(cat $HOME/keys/my-wallet.pub)" >> .profile
echo "export CODA_PRIVKEY_PASS=admin" >> .profile
source .profile
sleep 3
cd ~ 
chmod 700 ~/keys
chmod 600 ~/keys/my-wallet
sleep 3
sudo apt update && sudo apt upgrade -y
sleep 3 
sudo apt install docker.io curl -y
sleep 3
sudo systemctl start docker
sudo systemctl enable docker
sleep 3
source .profile
sleep 3
source .profile
sudo docker run --name mina -d --restart always -p 8301-8305:8301-8305 -v $(pwd)/peers.txt:/root/peers.txt -v $(pwd)/keys:/root/keys:ro -v $(pwd)/.coda-config:/root/.coda-config gcr.io/o1labs-192920/coda-daemon-baked:0.1.1-temporary-qa-staging-ci-wait-cf2b767-testworld-f226fed daemon -peer-list-file $HOME/peers.txt -block-producer-key $KEYPATH -block-producer-password $CODA_PRIVKEY_PASS -insecure-rest-server -file-log-level Debug -log-level Info
sleep 5
sudo docker exec -it mina coda client status
sleep 10
sudo docker logs --tail 1000 mina -f
