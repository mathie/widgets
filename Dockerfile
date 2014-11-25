FROM phusion/baseimage
MAINTAINER Graeme Mathieson <mathie@woss.name>

ENV RAILS_ENV production
ENV PORT 5000

EXPOSE ${PORT}

CMD ["/sbin/my_init"]

# Install system dependencies
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update && apt-get dist-upgrade -qq -y
RUN apt-get install -qq -y ruby-switch ruby2.1 build-essential ruby2.1-dev libpq-dev nodejs
RUN ruby-switch --set ruby2.1

# Update Rubygems and install a couple of system-wide gems.
RUN gem update --system --no-rdoc --no-ri
RUN gem update --no-rdoc --no-ri
RUN gem install --no-rdoc --no-ri bundler foreman

# Install the app
RUN adduser --system --group widgets
COPY . /srv/widgets
RUN chown -R widgets:widgets /srv/widgets
RUN cd /srv/widgets && /sbin/setuser widgets bundle install --deployment --without development:test

# Setup runit to run the app
RUN mkdir /etc/service/widgets
ADD config/deploy/widgets.sh /etc/service/widgets/run

# Clean up afterwards.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*