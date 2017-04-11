# Pull base image.
FROM postgres

EXPOSE 5432

# Copy files
COPY ./database_setup /docker-entrypoint-initdb.d
