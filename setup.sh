#!/bin/bash
if [ $1x == 'custom'x ]; then
    echo "Your password(Default: yourpswd):"
    read PASSWORD
    echo "Remote port(1-65535, Default:9807):"
    read PORT
    echo "Encrypt Method(Defult: aes-256-cfb):"
    read ENCRYPT
fi
if [ -z "$PASSWORD" ]; then
    PASSWORD="yourpswd"
fi
if [ -z "$PORT" ]; then
    PORT="9807"
fi
if [ -z "$ENCRYPT" ]; then
    ENCRYPT="aes-256-cfb"
fi
sed -e '3c\\t"server_port":"'$PORT'",' ./config.json -i
sed -e '6c\\t"password":"'$PASSWORD'",' ./config.json -i
sed -e '8c\\t"method":"'$ENCRYPT'",' ./config.json -i

yes|apt-get install python3-pip
yes|apt-get install python3-setuptools
yes|pip3 install qrcode-terminal --no-cache-dir
yes|apt-get install shadowsocks
sudo mv -f ./config.json /etc/shadowsocks/
sudo mv -f ./shadowsocks-server.service /etc/systemd/system/

modprobe tcp_bbr
echo "tcp_bbr" >> /etc/modules-load.d/modules.conf
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
sudo mv -f ./local.conf /etc/sysctl.d/
sysctl --system
sudo systemctl daemon-reload
sudo systemctl start shadowsocks-server
sudo systemctl enable shadowsocks-server

V4ADDR=$(ifconfig |grep 'inet '|awk {'print $2'}|grep -v '127.0.0.1')
V6ADDR=$(ifconfig |grep 'inet6 '|grep -v 'link'|grep -v 'host'|awk {'print $2'})
if [ -z "$V4ADDR" ]; then
    V4ADDR="IPv4 unsupported"
else
    QRCODE4="ss://"$(echo -n $ENCRYPT":"$PASSWORD | base64)"@"$V4ADDR":"$PORT"#Vultr-IPv4"
fi
if [ -z "$V6ADDR" ]; then
    V6ADDR="IPv6 unsupported"
else
    QRCODE6="ss://"$(echo -n $ENCRYPT":"$PASSWORD | base64)"@["$V6ADDR"]:"$PORT"#Vultr-IPv6"
fi
reset
echo "Server configuration complete."
echo "IPv4 Server Address: "$V4ADDR
echo "IPv6 Server Address: "$V6ADDR
echo "Password: "$PASSWORD
echo "Server port: "$PORT
echo "Encrypt method: "$ENCRYPT
if [ -z "$QRCODE4" ]; then
    echo "IPv4 not supported."
else
    qrcode-terminal-py -d $QRCODE4 -s S
    echo "IPv4 Server Qrcode"
fi
if [ -z "$QRCODE6" ]; then
    echo "IPv6 not supported."
else
    qrcode-terminal-py -d $QRCODE6 -s S
    echo "IPv6 Server Qrcode"
fi
