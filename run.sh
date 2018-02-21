#!/bin/sh
mkdir -p /user/.ssh
chmod 700 /user/.ssh
rm -f /user/.ssh/authorized_keys

if [ -n "$AUTHORIZED_KEYS" ]; then
	# Replace comma separator with newline.
	AUTHORIZED_KEYS="$(echo "$AUTHORIZED_KEYS" | tr ',' '\n')"
	# Split "words" (keys) on newline.
	IFS=$'\n'
	for key in $AUTHORIZED_KEYS; do
		# Strip leading and trailing whitespace.
		key="$(echo "$key" | sed -e 's/^ *//' -e 's/ *$//')"
		if [ -n "$key" ]; then
			echo "=> Adding public key:"
			echo "$key"
			echo "$key" >> /user/.ssh/authorized_keys
		fi
	done
	chmod 600 /user/.ssh/authorized_keys
else
	>&2 echo 'ERROR: $AUTHORIZED_KEYS is empty'
	exit 1
fi
