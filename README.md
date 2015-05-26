# Supported tags and respective `Dockerfile` links

-	[`4.4`](https://github.com/xjchengo/docker-nginx-php/blob/master/5.4/Dockerfile)
-	[`4.5`](https://github.com/xjchengo/docker-nginx-php/blob/master/5.5/Dockerfile)
-	[`4.6`](https://github.com/xjchengo/docker-nginx-php/blob/master/5.6/Dockerfile)

For more information about this image and its history, please head to [`xjchengo/docker-nginx-php` GitHub repo](https://github.com/xjchengo/docker-nginx-php).

# Introduction

This image is for hosting php project that provides you a wonderful deploying environment without requiring you to install PHP,  nginx. No more worrying about deploying your project for public access. With this image, a suitable environement can be ready in seconds. I also write a [command-line tool](https://packagist.org/packages/xjchen/alauda) for deploying this image on [alauda](https://www.alauda.cn).

# Included Software

-	Nginx 1.9
-	PHP(5.4, 5.5, 5.6)
-	openssh-server(mainly used for alauda host. Without it, it is hard to manage it on alauda now.)

# How to use this image

	docker run --name some-php --link some-mysql:mysql -e ROOT_PASSWORD=foo -d index.alauda.cn/xjchengo/php
	
The following environment variables are also honored for configuring your xjchengo/php instance:

-	`-e FRAMEWORK=laravel|thinkphp|reverse_proxy|others` (defaults to laravel. The image is tailored for thinkphp and laravel now. If your use other framework , you may edit nginx configuration a little.) 
-	`-e REPOSITORY_URL=...` (if you specify one, it will be cloned it to `/var/www/web`. Use git repository url starting with https please. Dependency installation tends to go wrong in China, so take care of dependency yourself.)
-	`-e DB_HOST=...` (defaults to the IP of the linked `mysql` container)
-	`-e DB_PORT=...` (defaults to 3306)
-	`-e DB_NAME=...` (will be created if not exists)
-	`-e DB_USER=...` (defaults to "root")
-	`-e DB_PASSWORD=...` (defaults to the value of the `MYSQL_ROOT_PASSWORD` environment variable from the linked `mysql` container or empty)

# Tips

-	Used as reverse proxy server. Sometimes when you are developing a project, your friend wants to see your amazing project. Because of not in same LAN, you have to say sorry. With this image, you can run it with `-e FRAMEWORK=reverse_proxy` on alauda. Then `ssh -R 8080:localhost:80 -p yourport root@alaudahostnameforyou` on your local machine. Now your project can access by http://alaudahostnameforyou .

