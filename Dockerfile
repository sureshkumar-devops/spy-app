FROM adoptopenjdk/openjdk11
EXPOSE 8080
ENV APP_HOME /urs/src/app
COPY target/*.jar $APP_HOME/app.jar
WORKDIR $APP_HOME
CMD ["java", "-jar", "app.jar"]
