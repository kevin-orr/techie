Using KeyCloak with `Aleph` is great - simple and easy except for one thing.

The `ALEPH_OAUTH_METADATA_URL` is used in the auth flow to discover well known endpoints that `Aleph` will use to authorize etc., keycloak in this case.

However, I found that I had to set the `ALEPH_OAUTH_METADATA_URL` with my `IP` address - using `localhost` or `127.0.0.1` didn't work, the `Aleph` `API` just hung.


`ALEPH_OAUTH_METADATA_URL=http://<my-ip-address>:8080/realms/aleph/.well-known/openid-configuration`
