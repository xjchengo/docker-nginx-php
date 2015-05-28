# Docker，巨好玩！

“Docker，巨好玩”活动由[云雀科技](https://www.alauda.cn/)主办，旨在普及 Docker 知识，推动 Docker 技术在中国的影响力，为 Docker 爱好者和使用者们提供一个实战平台。我本次的参赛作品信息如下：

# 面向 PHP 开发者的 Nginx+PHP 环境镜像

## 参赛作品

-	Docker Image[`index.alauda.cn/xjchengo/php`](https://github.com/xjchengo/docker-nginx-php)
-	Alauda Command-line Client[`xjchengo/alauda`](https://github.com/xjchengo/alauda-php)

## 作品说明

[`index.alauda.cn/xjchengo/php` 镜像](https://github.com/xjchengo/docker-nginx-php)主要面向 PHP 开发者，旨在使 PHP 开发者更方便的使用 Docker 搭建开发环境。它有如下特点：

- 为 PHP 框架而生。不同于其它镜像，本镜像的目标是内置最火的十套 PHP 框架的网站配置文件，让使用这十套框架的 PHP 用户不再担心环境问题，同时支持自定义配置，方便其它框架使用者使用。目前已支持国内主流框架 Thinkphp 和 国外主流框架 Laravel。不同框架对服务器的要求主要区别在 HTTP Server(Nging or Apache) 的配置和 PHP 模块的依赖。本镜像设置了 config 目录，用于存放不同框架的 HTTP Server 配置，同时本身是基于[官方 `php` 镜像](https://github.com/docker-library/docs/tree/master/php), 可以很方便的安装新的PHP 模块。
