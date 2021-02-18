docker rm -f mina
sleep 2
rm -rf $HOME/.coda-config
sudo apt-get remove -y mina-testnet-postake-medium-curves
echo "deb [trusted=yes] http://packages.o1test.net release main" | sudo tee /etc/apt/sources.list.d/mina.list
sudo apt-get update
sudo apt-get install -y curl unzip mina-testnet-postake-medium-curves=0.4.2-245a3f7
sleep 2
coda daemon --generate-genesis-proof true --peer-list-url https://storage.googleapis.com/seed-lists/zenith_seeds.txt
sleep 2
coda version
sleep 2
source .profile
sudo docker run --name mina -d --restart always -p 8301-8305:8301-8305 -v $(pwd)/peers.txt:/root/peers.txt -v $(pwd)/keys:/root/keys:ro -v $(pwd)/.coda-config:/root/.coda-config gcr.io/o1labs-192920/coda-daemon-baked:0.4.2-245a3f7-zenith-7a89538 daemon -peer-list-file $HOME/peers.txt -block-producer-key $KEYPATH -block-producer-password $MINA_PRIVKEY_PASS -insecure-rest-server -file-log-level Info -log-level Info -super-catchup
sleep 2
sudo docker exec -it mina coda client status
sleep 2
sudo docker logs --tail 1000 mina -f
