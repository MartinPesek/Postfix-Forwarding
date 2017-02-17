#!/bin/bash

echo -en "${EMAILS}" > /etc/postfix/virtual

postconf -e smtputf8_enable=no

postconf -e myhostname=${HOSTNAME}

# disable local delivery
postconf -e mydestination=

# don't relay for any domains
postconf -e relay_domains=

# reject invalid HELOs
postconf -e smtpd_delay_reject=yes
postconf -e smtpd_helo_required=yes
postconf -e "smtpd_helo_restrictions=permit_mynetworks,reject_invalid_helo_hostname,permit"

postconf -e "smtpd_relay_restrictions=permit_mynetworks permit_sasl_authenticated defer_unauth_destination"
postconf -e mynetworks_style=host
postconf -e mailbox_size_limit=0

# use TLS
postconf -e smtp_use_tls=yes
postconf -e smtp_tls_CAfile=/etc/ssl/certs/ca-certificates.crt

postconf -e "virtual_alias_domains=${DOMAINS}"
postconf -e virtual_alias_maps=hash:/etc/postfix/virtual

# stop complaining about missing /etc/postfix/aliases.db file
postalias /etc/postfix/aliases

postmap /etc/postfix/virtual
/usr/sbin/postfix -c /etc/postfix start
