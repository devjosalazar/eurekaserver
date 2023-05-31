FROM openjdk:17-alpine

# Establecer el directorio de trabajo en la carpeta del proyecto
WORKDIR /eurekaserver
# Copiar el código fuente de Accounts al contenedor
COPY  ./target/eurekaserver-0.0.1-SNAPSHOT.jar .


# Comando para ejecutar el Eureka Server cuando se inicie el contenedor
ENTRYPOINT ["java", "-jar", "eurekaserver-0.0.1-SNAPSHOT.jar"]