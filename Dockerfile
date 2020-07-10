FROM tomcat:9
COPY target/java-hello-world.war /usr/local/tomcat/webapps/java-hello-world.war
EXPOSE 8080 
