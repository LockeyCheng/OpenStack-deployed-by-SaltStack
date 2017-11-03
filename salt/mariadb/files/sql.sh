#!/bin/sh
mysql -e "create database keystone;" &&\
mysql -e "grant all on keystone.* to keystone@'localhost' identified by 'keystone';"&&\
mysql -e "grant all on keystone.* to keystone@'%' identified by 'keystone';"&&\
mysql -e "create database glance;"&&\
mysql -e "grant all on glance.* to glance@'localhost' identified by 'glance';"&&\
mysql -e "grant all on glance.* to glance@'%' identified by 'glance';"&&\
mysql -e "create database nova;"&&\
mysql -e "CREATE DATABASE nova_api;"&&\
mysql -e "grant all on nova.* to nova@'localhost' identified by 'nova';"&&\
mysql -e "grant all on nova.* to nova@'%' identified by 'nova';"&&\
mysql -e "GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'localhost' IDENTIFIED BY 'nova';"&&\
mysql -e "GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'%'    IDENTIFIED BY 'nova';"&&\
mysql -e "create database neutron;"&&\
mysql -e "grant all on neutron.* to neutron@'localhost' identified by 'neutron';"&&\
mysql -e "grant all on neutron.* to neutron@'%' identified by 'neutron';"&&\
mysql -e "create database cinder;"&&\
mysql -e "grant all on cinder.* to cinder@'localhost' identified by 'cinder';"&&\
mysql -e "grant all on cinder.* to cinder@'%' identified by 'cinder';"&&\
/usr/bin/mysqladmin -u root password redhat
