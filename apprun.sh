#!/bin/sh
if [  $1  == "appstart" ];then
		/usr/sbin/unitd; curl -X PUT -d@/1.json --unix-socket /usr/control.unit.sock http://localhost/config/
	        exit 0
else
		exec "$@"
fi


