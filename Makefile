# For local builds these versions are supplied here, else github actions takes care of this.
OPENJRE_VERSIONS=8
# for 8 minimal jre is 8-jre-base and is headless for 11 onwards
CASSANDRA_VERSIONS=4.0.1

image:
	for openjre in ${OPENJRE_VERSIONS}; do \
		for cassa in ${CASSANDRA_VERSIONS}; do \
			docker build \
			--build-arg OPENJRE_VERSION=$$openjre \
			--build-arg CASSANDRA_VERSION=$$cassa \
			-t vsapan/cassandra:$$cassa-$$openjre \
			-f DockerfileLocal \
			.; \
		done;\
	done
