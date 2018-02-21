# authorizedkeys

[![Deploy to Docker Cloud](https://files.cloud.docker.com/images/deploy-to-dockercloud.svg)](https://cloud.docker.com/stack/deploy/)

Adds a user public SSH key to the host's `.ssh/authorized_keys` using a container.


## Usage

    $ docker run -v /root:/user -e AUTHORIZED_KEYS="ssh-rsa ..." interaction/dockercloud-authorizedkeys

With multiple keys (comma separated):

    $ docker run -v /root:/user -e AUTHORIZED_KEYS="ssh-rsa 1...,ssh-rsa 2..." interaction/dockercloud-authorizedkeys

With multiple keys (newline separated):

    $ docker run -v /root:/user -e AUTHORIZED_KEYS="ssh-rsa 1...
    > ssh-rsa 2..." interaction/dockercloud-authorizedkeys

Adding the key to a user other than `root`:

    $ docker run -v /home/myuser:/user -e AUTHORIZED_KEYS="ssh-rsa ..." interaction/dockercloud-authorizedkeys


## Usage in Docker Cloud

We recommend using this image in Docker Cloud as follows:

    authorizedkeys:
      image: interaction/dockercloud-authorizedkeys
      deployment_strategy: every_node
      autodestroy: always
      environment:
        - |
          AUTHORIZED_KEYS=
          ssh-rsa 1...
          ssh-rsa 2...
      volumes:
        - /root:/user:rw
