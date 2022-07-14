useradd -m admin
adduser admin sudo
echo 'admin:admin' | sudo chpasswd
read -p "Paste Ngrok Authtoken: " CRP
sudo apt update -y > /dev/null 2>&1
sleep 1
echo "======================="
echo "Download ngrok"
echo "======================="
wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
unzip ngrok.zip > /dev/null 2>&1
chmod +x ngrok
./ngrok authtoken $CRP 
nohup ./ngrok tcp --region ap 3389 & sleep 2
echo "================================"
sudo apt-get install -y lxde > /dev/null 2>&1
echo "===========40%"
sudo apt install -y xrdp > /dev/null 2>&1
sudo sed -i.bak '/fi/a lxde-session \n' /etc/xrdp/startwm.sh > /dev/null 2>&1
echo "===============60%"
echo "==============="
echo "Chrome"
echo "==============="
sudo apt install -y apt-transport-https curl > /dev/null 2>&1
sudo apt update > /dev/null 2>&1
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb > /dev/null 2>&1
sudo apt install ./google-chrome-stable_current_amd64.deb > /dev/null 2>&1
wget -q -O tes.deb https://github.com/robiot/xclicker/releases/download/v1.4.0/xclicker_1.4.0_amd64.deb && dpkg -i tes.deb
mkdir /etc/opt/chrome
mkdir /etc/opt/chrome/policies
mkdir /etc/opt/chrome/policies/managed
mkdir /etc/opt/chrome/policies/recommended
chmod -w /etc/opt/chrome/policies/managed
cd /etc/opt/chrome/policies/managed
echo '
{
	"ExtensionInstallForcelist": ["gcbalfbdmfieckjlnblleoemohcganoc;https://clients2.google.com/service/update2/crx"]
}
' > test_policy.json
echo "==============="
echo "===================80%"
sleep 1
sudo service xrdp start > /dev/null 2>&1
echo "=======================100%"
echo XRDP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo "===================================="
echo "Don't close tab colab to keep rdp running 12 hours"
echo "===================================="
sleep 43000
