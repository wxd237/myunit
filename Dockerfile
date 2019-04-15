FROM centos:7

RUN yum -y update 
RUN yum -y install  gcc git 
RUN yum -y install  which make

RUN  git clone https://gitee.com/mirrors/Nginx-Unit unit
WORKDIR /unit
RUN  ./configure --tests --debug  --prefix=/usr
RUN  make   ;make tests;  make install

RUN  echo $'{         						\n\
    "listeners": {     						\n\
        "*:8300": {    						\n\
            "pass": "applications/blogs"    			\n\
        }   							\n\
    },   							\n\
    "applications": {   					\n\
        "blogs": {      					\n\
            "type": "external",    				\n\
            "processes": 2,       				\n\
            "executable": "unit_app_test",    			\n\
            "working_directory": "/Users/wangxidi/unit/build"   \n\
        }   							\n\
    }   							\n\

 }' >/1.json

ADD apprun.sh /apprun.sh
RUN  chmod +x /apprun.sh
expose 8300


ENTRYPOINT ["/apprun.sh"]
CMD ["appstart"]
#CMD ['unitd; curl -X PUT -d@/1.json --unix-socket /usr/control.unit.sock http://localhost/config/;  exec "$@"']
#CMD ['/usr/sbin/unitd; curl -X PUT -d\@/1.json --unix-socket /usr/control.unit.sock http://localhost/config/']


