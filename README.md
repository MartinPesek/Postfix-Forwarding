# Postfix forwarding

Mail forwarding from custom domain to, for example, gmail.

Image is based on *alpine:3.5* linux and the resulting size is around 60 MB.

## Generating docker image

To generate docker image execute from root directory:
```
docker build -t local/mail .
```

After that a new image should be available in your local docker repository as **local/mail**.

## Running a docker image

You need to provide few variables when creating a container:
* **HOSTNAME** - server's hostname - preferably FQDN one, example: awesome-server.somedomain.com
* **DOMAINS** - virtual alias domains that you want to forward mails for, example: example.com somedomain.com
* **EMAILS** - rules for forwarding, example *(you can use some-email@example.com if you want to forward just one specific email instead of using a catch all rule)*: @example.com myemail@gmail.com\n@somedomain.com myemail@gmail.com\n

Whole command could like this:
```
docker run -d -p 25:25 -e HOSTNAME=awesome-server.somedomain.com -e "DOMAINS=example.com somedomain.com" -e "EMAILS=@example.com myemail@gmail.com\n@somedomain.com myemail@gmail.com\n" --name mail local/mail
```
