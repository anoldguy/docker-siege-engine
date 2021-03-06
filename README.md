# Siege Engine

This docker image is a bit of glue around siege.  In an effort to avoid having
any credentials or URLs hard-coded, it reads them out of the environment.  

> **I CANNOT STRESS THIS ENOUGH:** *Yes*, this means that whatever container 
> coordination/management software you are using will see your session cookie,
> so only use this on staging environments where you control access.

## Important Variables
```bash
COUNT=1  # How many times to run siege
OPTIONS="-v -c 10 -i -d 1" # siege command line options
COOKIE="long-string"  # Gets used as -H "Cookie: ${COOKIE}" after the $OPTIONS
URLS="http://foo.bar/\nhttp://foo.bar/baz" # \n delimited list of URLs to hit
```

The script will loop forever, but will only run siege `$COUNT` times. The rest
of the time, it will simply sleep for a minute, and then print a sleeping
message.

## Launching your siege
The easiest way is with `docker run`:
```bash
docker run -e URLS="list of URLS" -e COOKIE="cookie string" -e COUNT=1 \
    -e OPTIONS="-v -c 10 -i -d 1" mrndrsn/siege-engine:latest
```

However, that's only going to give you one instance of siege, you may as well
just run it in your terminal.

To really amp things up, use something like Kubernetes or Amazon ECS to run the
task on multiple nodes in your cluster, and test from many endpoints at once!
