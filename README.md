```
    ___             __   _____          _
   / __\/\ /\ _ __ / /  /__   \___  ___| |_ ___ _ __
  / /  / / \ \ '__/ /     / /\/ _ \/ __| __/ _ \ '__|
 / /___\ \_/ / | / /___  / / |  __/\__ \ ||  __/ |
 \____/ \___/|_| \____/  \/   \___||___/\__\___|_|

```

# cult.sh

***CU***r***L*** ***T***ester - A simple REST testing framework for Shell Script.

This tool is an attempt to make test automation easy and human-readable in a non-graphical and non-proprietary
environment:

* Easy in the sense that you can find answers for your questions since the syntax is the same of its base tools.
* Human-readable to allow code review and maintenance, in other words, JSON and XML only for data and not for the script
  itself.
* Non-graphical, it should be possible to run its scripts in a remote computer over ssh or telnet without too much
  tooling.
* Non-proprietary, no need to explain.

## Intro

In the world of Shell Script, [curl](https://curl.se/) and [jq](https://stedolan.github.io/jq/)
are the common solution for making HTTP requests and verifying its JSON responses, ex:

```shell
curl --silent http://ifconfig.me/all.json | jq --exit-status '.ip_addr != null' > /dev/null && echo I have an IP, therefore I am.
```

*Cult* embeds both tools and adds to them more features, such as test labeling and report, variable extraction, status
validation and test script setup. The example below does the same as above but with a prettier output:

```shell
cult --test '.ip_addr != null' --print '"I have an IP, therefore I am."' http://ifconfig.me/all.json
```

To make assertions the `--test` argument is used, as shown above. Its content is used as `jq` filters over the response.

The `--print` argument is used to show some output, and it's not required. The idea is that there is nothing to be aware
on successes, but errors will be shown in details.

Note that the `--print` parameter is an escaped string as it uses the `jq` filters to show its content.

Implicitly *cult* will test the response status code for success (2XX). This behavior can be changed using the
argument `--expect` and passing to it the expected status code, ie: `--expect 500`. The argument for the `--expect`
parameter follow the `grep` regex syntax.

Other features are suited for scripts, so they will be shown this way.

## Test Script

A test script is nothing more than a Bash script that was set up by *cult*, ex:

```shell
#!/usr/bin/env bash
. cult
```

This simple line will reset *cult*, set Bash to quit on errors and enable *cult* reporting.

When needed, a "root" script can be used to call multiple sub scripts, the only requirement is the *cult* setup at the
beginning of each file.

### Labeling

Test labeling has informative purposes only and do not influence on the running tests. Tests are grouped in Scenarios,
Cases and Steps as shown below.

```shell
cult --scenario 'My test scenario' --case 'My test case' --step 'Yeah, I know =/'
```

Output example:

```
 ✔  Scenario: My test scenario
 ✔      Case: My test case
 ✔            Yeah, I know =/
```

### Request Body

Any data sent to *cult* will be parsed and added as *curl* `--raw-data` parameter. This approach was chooses to make
easy to pass the request body as [heredoc](https://tldp.org/LDP/abs/html/here-docs.html), ex:

```bash
cult http://example.com << EOF
    { "Hello": "World" }
EOF
```

### Variables

*Cult* can store response content into variables to future usage. Its first parameter is the variable name, and the
second is the `jq` filter that will be used to extract the response content.

```bash
cult --var my_ip .ip_addr http://ifconfig.me/all.json
```

Once the variable is extracted, it can be used as parameters and at the request body, any content found with the
variable name preceded by the dollar sign will be replaced by the variable value, ex:

```bash
cult --print $my_ip
```

### Random data

*Cult* makes use of [faker](https://faker.readthedocs.io/en/master/index.html) to put random data into the request body.
The exclamation mark at the beginning of the value indicates a `faker` method as shown bellow. If required arguments can
be passed to the method as a [python dictionary](https://docs.python.org/3/tutorial/datastructures.html#dictionaries)
after the method name, ex:

```bash
cult http://example.com << EOF
    {
        "username": "!user_name",
        "email": "!email",
        "value": "!random_int{'min': 100, 'max': 500}"
    }
EOF
```

## Installation

While distro packages aren't available, the simplest way to install it is using the provided Makefile, ex:

```shell
sudo make install
```

