ARG BUILDER_IMAGE=ghcr.io/carto-run/mirror/maven
ARG RUNTIME_IMAGE=gcr.io/distroless/java17-debian11


FROM $BUILDER_IMAGE AS build

        ADD . .
        RUN sleep 600
        RUN unset MAVEN_CONFIG && ./mvnw clean package -B -DskipTests


FROM $RUNTIME_IMAGE AS runtime

        COPY --from=build /target/demo-0.0.1-SNAPSHOT.jar /demo.jar
        CMD [ "/demo.jar" ]
