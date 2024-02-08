
```console
docker -d \
  -p 8211:8211/udp \
  --restart unless-stopped \
  -v palworld-data:/home/palworld/Steam/steamapps/common \
  --name palworld \
  ghcr.io/itay-grudev/palworld
```
