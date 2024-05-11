<p align="center">
  <a href=https://pegascape.sdsetup.com"><img src=https://i.imgur.com/H9ZLk33.png></a>
                                        </p>
                                        
## Why a docker image for PegaScape?

PegaScape Public DNS IP Addresses are no longer available.
To add more possibilities for users who still use deja-vu exploit to hack their 1.0.0 - 3.0.0 and 4.0.1 - 4.1.0 switch, this container image aims to make pegascape easily self-hostable. As a bonus, the execution of these exploits is quicker and more stable when used from a local appliance.

## What is PegaScape?

PegaScape is a user-friendly public frontend for common PegaSwitch scripts including Nereba, Caffeine, HBL and more.

## What can PegaScape be used for?

With PegaScape, you can easily reboot from a stock Switch console running firmwares between 1.0.0-3.0.0 and 4.0.1-4.1.0 into full custom firmware and emuMMC. You can also install the Fake News entrypoint to make accessing PegaScape easier, and access the Homebrew Menu without running full custom firmware if you prefer.

**This means an easy-to-use entrypoint to fully featured CFW on 4.1.0 IPATCHED units.**

## Which scripts are supported on what firmware versions?

Fake News | Installer |	Reboot to RCM |	Nereba | HBL | Caffeine
------------|:-----------:|:---------------:|:--------:|:------:|----------
1.0.0 |	**✓** |	**✓** |	**✓** |	**✓** |	✗
2.0.0-3.0.0 |	✗ |	✗ |	✗ |	**✓** |	**✓**
4.0.0 |	✗ |	✗ |	✗ |	✗† | 	✗
4.0.1-4.1.0 |	✗ |	✗ |	✗ |	**✓** | 	**✓**
Other |	✗ |	✗ |	✗ |	✗ | 	✗

† nvcore offsets missing for 4.0.0


Build image
Build pegascape image is as simple as using docker build.

`docker build .`

Launch container

`docker run -p 80:80 -p 53:53/udp -p 8100:8100 -e IP_ADDR=<YOUR_DOCKER_HOST_IP> --name pegascape -d -t bumblecito/pegascape`

Pegascape must be exposed on

`port 80`
in order to reach frontend

`port 53`
in order to expose a DNS server which forbidden access to nintendo services, and redirect switch to this container

`port 8100`
for exploit to work

`-t`
options is needed to attach a tty to container, in order to keep alive the node command

Configure switch to access pegascape
Modify your internet configuration on switch to use as primary and secondary the host IP of the machine which is used to launch pegascape. You won't be able to access to internet with this configuration, but pegascape will still be available in order to launch the deja-vu exploit.

You can install Fake News with <a href="https://github.com/noahc3/fakenews-injector/releases/latest">Fake News Injector</a>

## Running PegaScape and Al-Azif PS4/PS5 self-hosting exploits with macvlan driver network

You can run these images together in the same proyect on the same macvlan driver network with this compose.yml. Change the ip's to those of your router. E.g. `192.168.1.254` to `192.168.0.1`.



```yml
---
version: "3.8"
services:
  pegascape:
    image: bumblecito/pegascape:latest
    ports:
      - 80:80/tcp
      - 53:53/udp
      - 8100:8100/udp
    environment:
      IP_ADDR: 192.168.1.110
    tty: true
    restart: unless-stopped
    networks:
      lan:
       ipv4_address: 192.168.1.110 # Change me for some ip inside your macvlan subnet!
  dns:
    image: alazif/exploit-host-dns
    ports:
      - 53:53/tcp
      - 53:53/udp
    environment:
      REDIRECT_IPV4: 192.168.1.111 # Change me for ipv4_address
      # REDIRECT_IPV6:  # Set me if wanted and uncomment line
    restart: unless-stopped
    networks:
      lan:
       ipv4_address: 192.168.1.111 # Change me for some ip inside your macvlan subnet!
  http:
    image: alazif/exploit-host-http
    ports:
      - 80:80/tcp
      - 443:443/tcp
    environment:
      REDIRECT_TYPE: https # http or https
      ROOT_DOMAIN: github.com
      ROOT_DOMAIN_PATH: /Al-Azif/
      # HIJACK_URL: www.google.com
    restart: unless-stopped
    networks:
      lan:
       ipv4_address: 192.168.1.112 # Change me for some ip inside your macvlan subnet!
  watchtower:
    image: containrrr/watchtower
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    command: --cleanup --interval 300
    restart: unless-stopped
    networks:
      lan:
       ipv4_address: 192.168.1.113 # Change me for some ip inside your macvlan subnet!
networks:
  lan:
    driver: macvlan
    driver_opts:
      parent: eth0 # Change me if necessary!
    ipam:
      config:
        - subnet: "192.168.1.0/24"
          gateway: "192.168.1.1"  # Change me for your router lan ip!
```

## Credits

* ReSwitched, hexkyz and other contributors for PegaSwitch.
* Al-Azif for PS4/PS5 Exploit Host DNS
* Everyone who worked on smhax, nvhax, nspwn, etc.
* liuervehc for <a href="https://github.com/liuervehc/caffeine/">Caffeine</a>, bringing the first CFW to IPATCHED Switches, and dealing with my random support DMs.
* stuck_pixel for <a href="https://github.com/pixel-stuck/nereba/">Nereba</a> and <a href="https://github.com/pixel-stuck/reboot_to_rcm">reboot_to_rcm</a>.
* Switchbrew for <a href="https://github.com/switchbrew/nx-hbloader">nx-hbloader</a>.
* bernv3 for the sexy background art.
