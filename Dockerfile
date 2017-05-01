FROM ubuntu
# Install dependencies
RUN apt-get update -y
RUN apt-get install -y git curl vim apache2 php7.0 libapache2-mod-php7.0 php7.0-mcrypt php7.0-mysql vim

# Install app
RUN rm -rf /var/www/*
RUN mkdir /var/www/html
ADD app/ /var/www/html
ADD apache2.conf /etc/apache2/apache2.conf

# Configure apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www/html
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
EXPOSE 80
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
