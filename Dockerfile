FROM centos:6.7

MAINTAINER Fábio Luciano <fabio.goisl@ctis.com.br>

RUN yum groupinstall 'Development Tools' -y && yum install -y httpd php php-pear php-common php-opcache php-mbstring php-opcache php-mcrypt php-intl php-devel php-gd php-ldap php-mysql php-pdo php-pgsql php-xml initscripts &&  yum clean all

# PHP Related
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY config/definepath.sh /etc/profile.d/definepath.sh

COPY packages/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm /tmp/
COPY packages/oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm /tmp/
COPY packages/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm /tmp/
RUN yum install -y /tmp/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
RUN yum install -y /tmp/oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm
RUN yum install -y /tmp/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm

RUN printf "\n" | pecl install oci8-2.0.11
RUN echo "extension=oci8.so" > /etc/php.d/oci8.ini

EXPOSE 80
