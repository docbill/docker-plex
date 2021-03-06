# docker-plex
Plex in a docker container.  This image uses supervisord.

## Getting Started

To start your plex server, use:
	docker run -d -P --restart=always --name plex -v /config/:/config/:z -v /media/:/media/:z --net=host docker-plex

If the :z flag is not recognized then just try:
	docker run -d -P --restart=always --name plex -v /config/:/config/ -v /media/:/media/ --net=host docker-plex

Your media can be stored anywhere.  You can also change where it is mounted in the folder.  This can be useful if you are using an existing config folder, with a particular path...  For example, if you are migrating from a server where your media was in /mnt/share but is not mount as /data then you would use:

	docker run -d -P --restart=always --name plex -v /config/:/config/:z -v /data:/mnt/share/:z --net=host docker-plex

This way you can freely move your data and keep your plex config intact.

Plex will run as the owner of the /config directory.

## Build

Building is straight forward:

	docker build --rm -t docker-plex .

