# Deployment
```
docker volume rm mitmproxy-docker
docker run -ti -v mitmproxy-docker:/root/.mitmproxy mitmproxy-docker --name mitmproxy-docker --options
docker cp mitmproxy-docker:/root/.mitmproxy/mitmproxy-ca-cert.pem /usr/local/share/ca-certificates/mitmproxy-ca-cert.crt
docker rm mitmproxy-docker
update-ca-certificates
/etc/init.d/docker restart
docker run -d --restart unless-stopped  --name mitmproxy-docker --network host --volume mitmproxy-docker:/root/.mitmproxy -e GITHUB_USER="" -e GITHUB_TOKEN=""  mitmproxy-docker
```