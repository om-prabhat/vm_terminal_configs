#!/usr/bin/env bash

token=<TOKEN_HERE>

MACHINE_NAME=$(curl -X 'GET' "https://labs.hackthebox.com/api/v4/machine/active" -H 'accept: application/json' -H "Authorization: Bearer $token" | jq .info.name | tr -d '"')

IP=$(curl -X 'GET' "https://labs.hackthebox.com/api/v4/machine/profile/$MACHINE_NAME" -H 'accept: application/json' -H "Authorization: Bearer $token" | jq .info.ip | tr -d '"')
