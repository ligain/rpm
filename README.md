# RPM build  practice
The project consists of two parts:
1) Compile and run `nginx` inside a vagrant machine and then create a repo of rpm packages based on `nginx`
2) Create custom `nginx` docker image and push it into the Docker Cloud

# Compile nginx inside Vagrant  

0) `vagrant`  should be installed on your system
```
$ vagrant -v
Vagrant 2.2.5
```
1) Clone this repository
```bash  
$ git clone https://github.com/ligain/rpm.git  
``` 
2) Go to project folder
```bash  
$ cd rpm/
```  
3) Run vagrant
```bash  
$ vagrant up
```  
# Build custom docker image with nginx
0) `docker`  should be installed on your system
```
$ docker --version
Docker version 17.05.0-ce, build 89658be
```
1) Clone this repository
```bash  
$ git clone https://github.com/ligain/rpm.git  
``` 
2) Go to project folder
```bash  
$ cd rpm/
```  
3) Build an image
```bash  
$ docker build . -t custom-nginx:1.14.1
```  
4) Run container
```bash  
$ docker run --name cust-nginx -p 8080:80 -d custom-nginx:1.14.1
```  
5) Test `nginx`  welcome page on the host machine
```bash  
$ curl localhost:8080
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
``` 
5) Also you can pull this image from Docker Cloud
```
$ docker pull linder/custom-nginx
```

# Project Goals 
The code is written for educational purposes.