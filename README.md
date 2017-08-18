# Docker LAMP 5.5

![N|Solid](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2015/08/docker-logo-240.png)

Docker LAMP 5.5 is an image based on "linode/lamp" (LAMP on Ubuntu 14.04.1 LTS Container, https://hub.docker.com/r/linode/lamp/) that provide the following stack:
- Linux Ubuntu 14.04.1.
- Apache 2.4.
- Mysql 5.
- PHP 5.5.


## Requirements
- Docker: https://docs.docker.com/engine/installation/
- Docker Compose: https://docs.docker.com/compose/


## Installation
- Move to the target folder, which contains a local copy of the repo, for instance the following path:
```sh
$ cd /path/to/your-folder
```

- Clone repo from Git:

Via SSH:
```sh
$ git clone git@github.com:henrycv/docker-lamp-5.5.git
```
Via HTTPS:
```sh
$ git clone https://github.com/henrycv/docker-lamp-5.5.git
```

- Move into your local repository:
```sh
$ cd docker-lamp-5.5/
```

- To start a previous containers generated, or to build and run the image and generate them:
```sh
$ docker-compose up -d
```

- To stop all containers:
```sh
$ docker-compose down
```

- When you check the containers generated, you could see thing like the bellow snippet output:
```sh
$ docker ps
CONTAINER ID        IMAGE                     STATUS        PORTS                NAMES
068241f3049d        docker-lamp-5.5    Up XX minutes 0.0.0.0:80->80/tcp   docker-lamp-5.5

```

- You can login into to the container:
```sh
$ docker exec -it docker-lamp-5.5 /bin/bash
```

- Enable the virtuahost from PHP/Apache containers to host machine, it should be added to "/etc/hosts" in the host machine and it should be  point to the PHP/Apache container IP address. For instance:
```sh
## File: /etc/hosts
## For example, if the PHP/Apache container has the IP address: 172.25.0.4
172.25.0.4  docker-lamp-5.5.com
```


## Usage
A tutorial for using this LAMP image is at:

https://www.linode.com/docs/applications/containers/linode-lamp-container-docker
Configured using the Linode "Hosting a Website" guide:

https://www.linode.com/docs/websites/hosting-a-website
Apache Configuration:

Changes to the Apache /etc/apache2/apache2.conf file are:

i. "KeepAlive Off" instead of on

ii. Module added to end of file: <IfModule mpm_prefork_module> StartServers 2 MinSpareServers 6 MaxSpareServers 12 MaxClients 30 MaxRequestsPerChild 3000 </IfModule>

iii. Hostname added to end of file: ServerName localhost


MySQL Configuration:

Temporary root password: "Admin2015" Change immediately!

Ran mysql_secure_installation :
i. Removed anonymous user accounts
ii. Disable remote root login
iii. Removed the test database

MySQL configuration file at /etc/mysql/my.cnf
i. Changed settings:

   max_connections = 75
   key_buffer = 32M
   max_allowed_packet = 1M
   thread_stack = 128K
   table_cache = 32

Example database: exampleDB

Example user: example_user

Example user password: Admin2015

You can create another accounts
```sh
CREATE USER 'any_user'@'%' IDENTIFIED BY 'any_pass';
GRANT ALL ON any_db.* TO 'any_user'@'%';

FLUSH PRIVILEGES;
```


PHP Configuration:

PHP configuration file at /etc/php5/apache2/php.ini

i. Changed settings: max_execution_time = 30 memory_limit = 128M error_reporting = E_COMPILE_ERROR|E_RECOVERABLE_ERROR|E_ERROR|E_CORE_ERROR display_errors = Off log_errors = On error_log = /var/log/php/error.log register_globals = Off

Created directory: /var/log/php

Changed /var/log/php ownership to www-data

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

TODO: Write history

## Credits

- Henry Carbajal https://about.me/henrycv <entidad.estelar@gmail.com>

## License

Code released under the MIT license. Docs released under Creative Commons.