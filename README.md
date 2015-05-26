# Supported tags and respective `Dockerfile` links
-	[`4.4`](https://github.com/xjchengo/docker-nginx-php/blob/master/5.4/Dockerfile)
-	[`4.5`](https://github.com/xjchengo/docker-nginx-php/blob/master/5.5/Dockerfile)
-	[`4.6`](https://github.com/xjchengo/docker-nginx-php/blob/master/5.6/Dockerfile)

For more information about this image and its history, please head to [`xjchengo/docker-nginx-php` GitHub repo](https://github.com/xjchengo/docker-nginx-php).

# Introduction

This image is for hosting php project that provides you a wonderful deploying environment without requiring you to install PHP,  nginx. No more worrying about deploying your project for public access. With this image, a suitable environement can be ready in seconds. I also write a [command-line tool](https://packagist.org/packages/xjchen/alauda) for deploying this image on [alauda](https://www.alauda.cn).

# Included Software

- Nginx
- PHP(5.4, 5.5, 5.6)
- openssh-server(mainly used for alauda host. Without it, it is hard to manage it on alauda now.)

