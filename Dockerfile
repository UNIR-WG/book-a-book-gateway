#
# Build del proyecto (Multi-Stage)
# --------------------------------
#
# Usamos una imagen de Maven para hacer build de proyecto con Java 17
# Llamaremos a este sub-entorno "build"
# Copiamos todo el contenido del repositorio
# Ejecutamos el comando mvn clean package (Generara un archivo JAR para el despliegue)
FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN mvn clean package

# Usamos una imagen de Openjdk v17
# Exponemos el puerto que nuestro componente va a usar para escuchar peticiones
# Copiamos desde "build" el JAR generado (la ruta de generacion es la misma que veriamos en local) y lo movemos y renombramos en destino como 
# Marcamos el punto de arranque de la imagen con el comando "java -jar app.jar" que ejecutará nuestro componente.
FROM openjdk:17
EXPOSE 8763
COPY --from=build /target/book-a-book-gateway.jar app.jar

# Set the application profile in order to change the config of DB location
ENV spring_profiles_active=prod

ENTRYPOINT ["java", "-jar", "/app.jar"]