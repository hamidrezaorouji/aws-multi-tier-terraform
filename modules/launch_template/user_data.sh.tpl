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

# CloudWatch Agent installieren
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i amazon-cloudwatch-agent.deb

# Konfigurationsdatei fuer Logs
cat <<EOF > /opt/aws/amazon-cloudwatch-agent/bin/config.json
${cloudwatch_config}
EOF

# CloudWatch Agent starten
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json \
  -s

systemctl enable nginx
systemctl restart nginx

