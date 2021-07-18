#!/bin/bash
#OS

IP=$(wget -qO- ipv4.icanhazip.com);
if [[ "$IP" = "" ]]; then
    IP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | grep -v '192.168'`;
fi

if [[ -e /etc/debian_version ]]; then
VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID")
fi
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣ 🔘🔘🔘 ตั้งค่าและติดตั้ง web panel 🔘🔘🔘      "
echo " ┈╰━━━┳━━━━━━━━━━━┳━━━━━━╯"
echo " ┈╭━━━┻━━━━━━━━━━━┻━━━━━━╮"
echo " ┈┣ 1. ติดตั้งเว็บ web panel      "
echo " ┈┣━━━━━━━━━━━━━━━┫"
echo " ┈┣ 2. เพิ่มไฟล์ OpenVPN ลงในเว็บ       "
echo " ┈┣━━━━━━━━━━━━━━━━━━━━━━╯"
read -p " ┈┣ พิมพ์เลข : " opcao
case $opcao in
1 )
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="9"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
panel() {
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━━╮"
echo " ┈ 🔘🔘🔘 ข้อมูลติดตั้ง web panel  🔘🔘🔘"
echo " ┈╰━━┳━━━━━━━━━━┳━━━━━━━━╯"
echo " ┈╭━━┻━━━━━━━━━━┻━━━━━━━━╮"
echo " ┈┣ 🔖🔖 ลิ้งติดตั้ง web panel   "
echo " ┈┣ 🔖🔖 http://$IP:81/install    "
echo " ┈┣━━━━━━━━━━━━━━━━━┫"
echo " ┈┣ 🔖🔖 ข้อมูลติดตั้ง     "
echo " ┈┣ 🔖🔖 username : root     "
echo " ┈┣ 🔖🔖 password : ที่กำหนดใว้ตอนรัน        "
echo " ┈┣ 🔖🔖 Database Name : Kguza          "
echo " ┈╰━━┳━━━━━━━━━━┳━━━━━━━━╯"
echo " ┈╭━━┻━━━━━━━━━━┻━━━━━━━━╮"
echo " ┈┣ 🔖🔖 ลิ้งเข้าเว็บเมื่อติดตั้งเสร็จ               "
echo " ┈┣ 🔖🔖 http://$IP/login/login "
echo " ┈╰━━┳━━━━━━━━━━┳━━━━━━━━╯"
echo " ┈╭━━┻━━━━━━━━━━┻━━━━━━━━╮"
echo " ┈┣ 🔖🔖 ลิ้งติดตั้ง ขั้นสูง ผ่านphpmy_admin               "
echo " ┈┣ 🔖🔖 ไม่แนะนำ 🔞🔞🔞🔞🔞            "
echo " ┈┣ 🔖🔖 http://$IP/kguza_admin   "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━━╯"
        exit
        }
        
if [ -d /home/vps/public_html/application ]; then
panel
else
apt update
apt-get install -qy php5-mysql
apt-get install -qy mysql-server
mysql_secure_installation
apt-get install -qy phpmyadmin
apt-get install -qy unzip
cd /home/vps/public_html/
wget -q -O Ocs-Panel-Thai.tar http://kguza.net/scrip/u-d/openvpn/conf/Ocs-Panel-Thai.tar
tar xf Ocs-Panel-Thai.tar
echo "NoInstall" > application/config/database.php
chmod 777 application/config/database.php
rm -f Ocs-Panel-Thai.tar
rm -f index.html
wget -q -O admin.zip https://files.phpmyadmin.net/phpMyAdmin/4.8.3/phpMyAdmin-4.8.3-all-languages.zip
unzip admin.zip > /dev/null 2>&1
rm -f admin.zip
mv phpMyAdmin-4.8.3-all-languages kguza_admin
apt-get install -y curl
apt-get install -qy php5-curl
panel
fi
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
clear
cr
echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สามารถติดตั้งได้แค่ OS Debian7-8 Ubuntu14.4
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯
 "

fi
exit
;;
2)
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣ ติดตั้งไฟล์ Ovpn ลง Panel      "
echo " ┈╰━┳━━━━━━━━━┳━━━━━━━╯"
echo " ┈╭━┻━━━━━━━━━┻━━━━━━━╮"
echo " ┈┣  กำหนดค่าไฟล์Openvpn    "
echo " ┈╰━━━━━━━━━━━━━━━━━━━╯"
read -p " ┈┣ Host/IP    : " IPSM
read -p " ┈┣ ใส่เพโหลด  : " -e -i :1194@connect.facebook.net payload
read -p " ┈┣ ตั้งชื่อไฟล์   : " name
read -p " ┈┣ ต้องการบันทึกหรือไม่ y/n  : " Edit
if [[ "$Edit" = "y" || "$Edit" = "Y" ]]; then
mkdir -p /home/vps/public_html/ovpn
cat > /home/vps/public_html/ovpn/$name.ovpn << SMILE
client
dev tun
proto tcp
port 1194
connect-retry 1
connect-timeout 120
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
persist-remote-ip
mute-replay-warnings
verb 2

tcp-queue-limit 128
txqueuelen 2000
tcp-nodelay
sndbuf 393216
rcvbuf 393216 
push "sndbuf 393216"
push "rcvbuf 393216"

auth-user-pass
cipher none
comp-lzo
script-security 3
remote $IPSM$payload
http-proxy $IPSM 8080
resolv-retry infinite

<key>
$(cat /etc/openvpn/client-key.pem)
</key>
<cert>
$(cat /etc/openvpn/client-cert.pem)
</cert>
<ca>
$(cat /etc/openvpn/ca.pem)
</ca>
SMILE
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━╮  "
echo " ┈┣ บันทึกเรียบร้อย   "
echo " ┈┣━━━━━━━━━━━━━━━━━━━╯   "
echo " ┈┣ ลิ้งใช้งาน "
echo " ┈┣━━━━━━━━━━━━━━┫"
echo " ┈┣ http://$IP:81/ovpn/$name.ovpn  "
echo " ┈╰━━━━━━━━━━━━━━━━━━━╯   "
exit
elif [[ "$Edit" = "$Edit" || "$Edit" = "$Edit" ]]; then
echo " ┈╭━━━━━━━━━━━━━━━━╮"
echo " ┈┣ ❎❎ ยกเลิกการบันทึก ❎❎   "
echo " ┈╰━━━━━━━━━━━━━━━━╯"
   exit
fi
;; 
esac
