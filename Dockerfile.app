FROM phusion/baseimage
MAINTAINER Graeme Mathieson <mathie@woss.name>

# Install system dependencies
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update && apt-get dist-upgrade -qq -y
RUN apt-get install -qq -y ruby-switch ruby2.1 \
  build-essential ruby2.1-dev libpq-dev \
  nodejs
RUN ruby-switch --set ruby2.1

# Update Rubygems and install a couple of system-wide gems.
RUN gem update --system --no-rdoc --no-ri
RUN gem update --no-rdoc --no-ri
RUN gem install --no-rdoc --no-ri bundler

# Configure the environment for the app to run in.
ENV RAILS_ENV production
ENV PORT 5000
ENV SECRET_KEY_BASE b744596ed1322953135343fa49485db1b14725c21074d96f2507df8730556d064cb28d18ec97dfdf5a2cd27315e941606085e483cabd1902d3068c3f32903907

EXPOSE ${PORT}

# Setup runit to run the app
RUN mkdir /etc/service/widgets
COPY config/deploy/widgets.sh /etc/service/widgets/run

# Install the app
RUN adduser --system --group widgets
COPY . /srv/widgets
RUN chown -R widgets:widgets /srv/widgets
RUN cd /srv/widgets && \
  /sbin/setuser widgets bundle install \
    --deployment \
    --without development:test

# Clean up afterwards.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*