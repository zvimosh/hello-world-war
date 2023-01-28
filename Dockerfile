FROM tomcat:9.0 
ADD ./mvnfiles/*.war /usr/local/tomcat/webapps/
ENTRYPOINT ["catalina.sh", "run"]

