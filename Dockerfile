FROM maven as build
WORKDIR /sriram_java_app_cicd@2
COPY . . 
RUN mvn install
RUN apt-get update && apt-get install -y git

FROM openjdk:11.0
WORKDIR /sriram_java_app_cicd@2
COPY --from=build /sriram_java_app_cicd@2/target/devops-integration.jar /sriram_java_app_cicd@2/
EXPOSE 8080
CMD ["java","-jar","devops-integration.jar"]