FROM maven as build
WORKDIR /var/lib/jenkins/workspace/sriram_java_app_cicd@2
COPY . . 
RUN mvn install

FROM openjdk:11.0
WORKDIR /var/lib/jenkins/workspace/sriram_java_app_cicd@2
COPY --from=build /var/lib/jenkins/workspace/sriram_java_app_cicd@2target/devops-integration-jar /var/lib/jenkins/workspace/sriram_java_app_cicd@2/
EXPOSE 8080
CMD ["java","-jar","devops-integration-jar"]