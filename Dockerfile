FROM azul/zulu-openjdk-alpine:17 as builder
RUN mkdir my_code
COPY . /my_code
WORKDIR /my_code
RUN apk add maven git
RUN mvn clean package spring-boot:repackage -DskipTests

FROM azul/zulu-openjdk-alpine:17-jre as runner
RUN mkdir /my_app
WORKDIR /my_app
COPY --from=builder /my_code/target/springboot-pubsub-0.0.1-SNAPSHOT.jar /my_app/app.jar
ENTRYPOINT  ["java", "-jar", "/my_app/app.jar"]