# Quick-Nginx-ListHost

 Config files for a quick deployment of NGINX that hosts a dynamic list of AWS service IP addresses that are updated daily.

## Usage

**WARNING:** This is meant to run in Red Hat Enterprise Linux 8. It has not been tested on any other OS. There is an option to run this on Debian based systems, but it has not been tested.

This is a quick and dirty way to get a list of AWS service IP addresses into NGINX.  It is not meant to be a production ready solution.  It is meant to be a quick way to get a list of AWS service IP addresses into NGINX.

1. Clone this repo
2. run `install-ngnix.sh`
3. open [http://localhost/](http://localhost/) in your browser

