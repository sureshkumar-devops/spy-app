FROM adoptopenjdk/openjdk11
RUN addgroup docker && adduser -S -G docker suresh
USER suresh
ENV APP_HOME /spy-app
WORKDIR $APP_HOME
COPY target/*.jar $APP_HOME/app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
