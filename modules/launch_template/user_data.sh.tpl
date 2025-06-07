#!/bin/bash
apt update -y
apt install -y nginx curl

PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

hostnamectl set-hostname ${hostname}

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
  <head>
    <title>${project_name} | EC2-Instanz</title>
  </head>
  <body>
    <h1>Projekt: ${project_name}</h1>
    <p>Hostname: <strong>${hostname}</strong></p>
    <p>Private IP-Adresse: <strong>$PRIVATE_IP</strong></p>
  </body>
</html>
EOF

systemctl enable nginx
systemctl restart nginx

