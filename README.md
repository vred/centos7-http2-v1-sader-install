# CentOS 7 HTTP/2 partial-Stack Automated DeployER 
![Sader](https://farm8.staticflickr.com/7055/27031178825_7bd919d94b_o_d.gif "")
Version 1 (SADER) 2016 May 15
A crude but serviceable shell script for a partial stack automated install featuring stable builds of OpenSSL/Python3/nginx for supporting HTTP/2 (w/ APLN) to be used with recently installed CentOS 7 (minimal). For sysadmins who are staging for Python 3-based web frameworks and want HTTP/2 (h2 for short) compliance in Cent OS 7 without needing to worry about any Chrome browser client compatibility. You will most certainly lose SPDY, though, if you used it before deploying this; I would have applied the CloudFlare patch, but unfortunately, they had not applied the SPDY compatibility patch to nginx 1.10.0 but a previous mainline build. 

Why: The default CentOS 7 version of OpenSSL is way outdated. Simply using the default package manager to install these may not give you the versions that implement HTTP/2, either.  

Remember to run as root!

This is what you get out of the box with Version 1:

1. OpenSSL 1.0.2h (20160503) [version conducive for APLN & compliance with how Chrome clients support h2]
2. Python 3.5.1 (20151207)   [threw this in there because I personally use a Python-based stack]
3. nginx 1.10.0 (20160426)   [./configure will have flags for SSL and HTTP/2 support]

**NOTE: SSL certificates and additional configuration of nginx is required to implement h2. This script doesn't go *that* hard, although the configuration changes for nginx are literally just two words added to the listen line. Also, for further reading and secure configuration of HTTP/2: LetsEncrypt makes getting trusted, signed certs easy if you are applying this install towards a domain. Finally, remember to create your nginx.service file and run the 'systemctl enable nginx.service' since we are working with systemd here!**

This is not intended to be fully maintained, unfortunately, but meant to illustrate how simple it is for sysadmins to create HTTP/2-ready environments on CentOS 7.  The support might not be out-of-the-box, but this crude shell script did not take me long to write. 

I would prefer greater awareness for sysadmins to keep the more mainstream Linux distros as up-to-date and secure as possible in their online implementations, so without further ado, here's our WTFPL-2.0 "licensing"

Copyright & Licensing: 

Copyright © 2016 Val Red <vred@rutgers.edu>
This work is free. You can redistribute it and/or modify it under the
terms of the Do What The [redacted] You Want To Public License, Version 2,
as published by Sam Hocevar. See http://www.wtfpl.net/ for more details.
