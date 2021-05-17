+++
title = "Generating and using self-signed certificates for local developing"
date = "2021-05-17"
description = ""
tags = [
    "ssl",
    "http",
    "certificates",
    "localhost"
]
draft = true
toc = false
share = true
+++

## Generating the self-signed certificate

Generate a self-signed certificate using the **openssl** command:

```bash
openssl req -nodes -new -x509 -keyout localhost.pem -out localhost.pem -days 365
```

In this case the key and the certificate itself will be in the same **./localhost.pem** file.

## Installing the new certificate using ca-certificates

Copy the certificate to **/usr/share/ca-certificates/localhost.crt**, then set the correct permission. Then use the **dpkg-reconfigure** to list and enable the certificate.

```bash
sudo cp ./localhost.pem /usr/share/ca-certificates/localhost.crt
sudo chown $USER /usr/share/ca-certificates/localhost.crt
sudo dpkg-reconfigure ca-certificates
```

## Using the certificate

Now you can normally use the certificate, below an example of HTTP server using the **ssl** module in Python.

```python
import http.server, ssl

server_address = ('localhost', 443)
httpd = http.server.HTTPServer(server_address, http.server.SimpleHTTPRequestHandler)
httpd.socket = ssl.wrap_socket(httpd.socket,
        server_side=True,
        certfile='/usr/share/ca-certificates/localhost.crt',
        keyfile='/usr/share/ca-certificates/localhost.crt',
        ssl_version=ssl.PROTOCOL_TLS)
print('Running server at https://localhost')
httpd.serve_forever()
```

Save this to **server.py** then execute it.

```bash
sudo python3 ./server.py
# Running server at https://localhost
```

Then call the server, it will show you a directory listing of the root server directory.

```bash
curl https://localhost

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Directory listing for /</title>
</head>
<body>
...
```
