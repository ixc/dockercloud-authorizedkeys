#!/bin/bash
rm -rf .test
mkdir .test

AUTHORIZED_KEYS=$(cat <<-EOF
	ssh-rsa 1...
	ssh-rsa 2..., ssh-rsa 3...
	EOF
)

docker build -t interaction/dockercloud-authorizedkeys:test .
docker run --rm -v "$PWD/.test:/user" -e AUTHORIZED_KEYS="$AUTHORIZED_KEYS" interaction/dockercloud-authorizedkeys:test
docker rmi interaction/dockercloud-authorizedkeys:test

for i in 1 2 3; do
	if ! grep -q "^ssh-rsa $i...\$" .test/.ssh/authorized_keys; then
		>&2 cat <<-EOF
		=> TEST FAILED: '^ssh-rsa $i...\$' not found in '.test/.ssh/authorized_keys':
		$(cat .test/.ssh/authorized_keys)
		EOF
		exit 1
	fi
done

echo "=> TEST PASSED"
