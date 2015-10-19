FROM ubuntu:latest

MAINTAINER James Barlow <james@phillymozdesign.com>

RUN apt-get update

RUN apt-get -qy install nginx-full

RUN rm -f /etc/nginx/sites-enabled/default

# Tell nginx not to daemonize
RUN sed -i "1i daemon off;" /etc/nginx/nginx.conf

RUN mkdir -p /var/cache/npm/data
RUN mkdir -p /var/cache/npm/tmp

ADD files/etc/nginx/conf.d/npm.conf           /etc/nginx/conf.d/npm.conf
ADD files/etc/nginx/sites-available/npm_cache /etc/nginx/sites-available/npm_cache
ADD files/etc/nginx/sites-enabled/npm_cache   /etc/nginx/sites-enabled/npm_cache

CMD "/usr/sbin/nginx"

# Install base packages
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install nodejs nodejs-legacy npm imagemagick git -y

# Install nodebb
RUN cd /opt/nodebb && git clone -b v0.6.x https://github.com/NodeBB/NodeBB nodebb
RUN cd /opt/nodebb && npm install

# Create a mountable volume
VOLUME /opt/nodebb

# Define working directory.
WORKDIR /var/www/mynodebb/htdocs

# Expose ports
EXPOSE 80
EXPOSE 443
EXPOSE 4567

# Define default command.
CMD ["node", "app.js"]
