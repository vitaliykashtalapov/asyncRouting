#!/bin/sh

source /mnt/systo1/scripts/routing/vars.sh

mysql -u $routing_db_user -p$routing_db_pass -D $routing_db -Ns -e "SELECT domain FROM domains;" | while read domain
do
  ip=$(nslookup $domain $dns1 | awk 'NR>2 && /Address*/ && /\<[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\>/ {print $3}')
  if [ -n "$ip" ]; then
    set -- $ip
    while [ "$1" != "" ]; do
      mysql -u $routing_db_user -p$routing_db_pass -D $routing_db -e "INSERT INTO nslookup (ip, comment, timemark) VALUES (INET_ATON('$1'), '$domain\n$dns1\n$1', now());"
      shift
    done
  else
    mysql -u $routing_db_user -p$routing_db_pass -D $routing_db -e "INSERT INTO nslookup (ip, comment, timemark) VALUES ('0', '$domain\nERROR', now());"
  fi
done

mysql -u $routing_db_user -p$routing_db_pass -D $routing_db -Ns -e "CALL combine_ips ('nslookup');"

#sh /mnt/systo1/scripts/routing/addIPsets.sh
