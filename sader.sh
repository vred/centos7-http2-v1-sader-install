#!/bin/sh
# centos7-http2-sh-v1-sader-install.sh
# Val Red’s CentOS 7 python-based (python/OpenSSL/nginx) partial-Stack Automated DeployER
#	Version 1 “SADER” (20160515) 
#
#                  `       ```                     
#               `,   `.`........`:`                
#              ,  ..................:`             
#               `.....................``           
#              ,........................:          
#         `,.............................,         
#       ,.................................:        
#      ,.........,.............,........,.`   `    
#     ,..: `............,.......`...........  :    
#    :.: `.......`......,.......,........;..       
#   ;.:  ........................`.......`...      
#  `.;  .........;...............:........;..  ,   
#  ..  ..........:.......`...................: `   
#  .   `..........`......;....................     
# ;.  `...........;.......`.......`........`..` `  
# .,  '...,.......;.......;.....`,:..:........: `  
#`.;  ............';......:...:,,,,,,,;.,:`,...    
#..`  ............,:...;.`,,,,,,,,,,,,,:...,...    
#..   .............::..,,,,,,,,,,,,,,.....`..,.`   
#..`  .............,,::,,,,,,,,,.,;;:  .;....:.; ` 
#..;  ..........:`:,,,,,,,,,,,,, ;::;  .:....:.,   
#`.,  `........,,,,,,,,,,,....    ;::  ``....,..   
# ..  ,...`...,,,,,,,,........:        ,.....,..   
# ,.  :.`..;,;,,,,,.`..........`      .``....,..   
# ..;  .;.:;,,..::   .........``,   .:```....,..   
#  ,:  ,,:.....;:;   ......``````````````....:..   
#        ...:.,::;   ..``````````````````....;..   
#        .`...      ;````````````````````:...:..   
#        `:..``    :`````````````````````;......   
#        :...:``:````````````````````````;...`..   
#        :....```````````````````````````,.....;   
#        `....````````````````````````````.....;   
#         ...`````````````````````````````......   
#         .`...``````````````,;;:````````;..:,.,,  
#         .:..;```````````.;;;;;;,```````,..,,:,,, 
#      `  ;;...``````````';;;`` , ``````,,..,,,,,,.
#      :  ,....,`````````,,````````````,,,.,,,,,,,,
#      .  `:....,````````` .`````````:,,,,,,,,,,,,:
#       ; :,....,,,``````` .````````.`,,,,,,,,,,,, 
#         ,,`.:`,,,`.````` ``````,...   .:,,,,,,,, 
#       ` ,,`.,,,,,    :,,:,::::;:`.,:,    ,,,,,:  
#       :. :,.,,,: `;.,.::,.:;;;;;.;.,,:       ,   
#           .,,,: :,,,,,,,,` .:;;;.,,,,,:          
#              , .,,,,,,,:````````,,,,,,,`         
#
# RUN THIS SCRIPT AS ROOT USER (su - / sudo -s before executing)
# Description: This is a mad ghetto OpenSSL-python3-nginx deployer for HTTP/2, with it 	
#	we assume we are using the minimal CentOS-7 install; it should have a
#	really old version of OpenSSL among other things we’ll replace while adding: 
# from yum: wget (w/e vers. yum has)	
# from yum: perl (w/e vers. yum has)	
# from yum: gcc  (w/e vers. yum has)	
# from src: OpenSSL 1.0.2h (20160503)
# from src: Python 3.5.1 (20151207)	
# from src: nginx version 1.10.0 (20160426)

# Hey, you need to be root. So let’s check if your EUID=0!
if [[ $EUID -ne 0 ]]; then
	echo “Must be root to run this!”
exit 1
fi 
##########################
# OpenSSL Version 1.0.2h #
##########################
yum -y install wget perl gcc 
cd /usr/local/src/
wget -O /usr/local/src/openssl-1.0.2h.tar.gz https://www.openssl.org/source/openssl-1.0.2h.tar.gz
tar -xzf openssl-1.0.2h.tar.gz
cd openssl-1.0.2h
./config 
make
make depend
make install
yum -y remove openssl # this removes the old, dumb version of OpenSSL; it’s a liability!
ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl 
##########################
# Python Version 3.5.1   #
##########################
# We need some libraries for openSSL, don’t freak out:
yum -y install openssl-devel
wget -O /usr/local/src/Python-3.5.1.tgz https://www.python.org/ftp/python/3.5.1/Python-3.5.1.tgz
cd /usr/local/src
tar -xzf /usr/local/src/Python-3.5.1.tgz
cd python-3.5.1 
./configure
make
make install 
##########################
# nginx version 1.10.0   #
##########################
useradd nginx
usermod -s /sbin/nologin nginx
wget -O /usr/local/src/nginx-1.10.0.tar.gz http://nginx.org/download/nginx-1.10.0.tar.gz
cd /usr/local/src/
tar -xzf nginx-1.10.0.tar.gz
cd nginx-1.10.0
# NOTE WE LOSE SPDY! DON’T USE SPDY CONFIGS!
./configure --user=nginx --group=nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log  --with-openssl=/usr/local/src/openssl-1.0.2h/ --with-http_ssl_module --with-http_v2_module
make
make install
