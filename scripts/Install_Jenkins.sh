#!/bin/bash

# Exit if any command fails
set -e

echo "🚀 Updating system..."
sudo apt update -y

echo "☕ Installing Java (OpenJDK 21)..."
sudo apt install -y fontconfig openjdk-21-jre

echo "✅ Java Version:"
java -version

echo "🔑 Adding Jenkins key..."
sudo mkdir -p /etc/apt/keyrings

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "📦 Adding Jenkins repository..."
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "🔄 Updating package list again..."
sudo apt update -y

echo "📥 Installing Jenkins..."
sudo apt install -y jenkins

echo "⚙️ Enabling Jenkins service..."
sudo systemctl enable jenkins

echo "▶️ Starting Jenkins..."
sudo systemctl start jenkins

echo "📊 Jenkins Status:"
sudo systemctl status jenkins --no-pager

echo "🌐 Access Jenkins at: http://<your-server-ip>:8080"

echo "🔐 Initial Admin Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword