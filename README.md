Palworld Server
===============

PalServer docker container based on a non-root `steamcmd` installation on Ubuntu 22.04.

The Docker container includes the PalServer pre-installed, but updates it whenever it's started. It's highly recommended to mount the whole `steamapps/common` directory, to avoid downloading updates every single time as that may take a while depending on your connection.

The game requires that you expose UDP port `8211`. Make sure to allow it through your firewall and/or NAT.

```console
docker run -d \
  -p 8211:8211/udp \
  --restart unless-stopped \
  -v palworld-data:/home/palworld/Steam/steamapps/common \
  --name palworld \
  ghcr.io/itay-grudev/palworld:latest
```

License
-------

The Dockerfile, related scripts and documentation are released under the terms of GPLv3. Refer to the `LICENSE` file for more information.
