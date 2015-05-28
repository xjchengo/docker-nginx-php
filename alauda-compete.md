# Docker，巨好玩！

“Docker，巨好玩”活动由[云雀科技](https://www.alauda.cn/)主办，旨在普及 Docker 知识，推动 Docker 技术在中国的影响力，为 Docker 爱好者和使用者们提供一个实战平台。我本次的参赛作品信息如下：

# 面向 PHP 开发者的 Nginx+PHP 环境镜像

## 参赛作品

-	Docker Image[`index.alauda.cn/xjchengo/php`](https://github.com/xjchengo/docker-nginx-php)
-	Alauda Command-line Client[`xjchengo/alauda`](https://github.com/xjchengo/alauda-php)

## 作品说明

[`index.alauda.cn/xjchengo/php` 镜像](https://github.com/xjchengo/docker-nginx-php)主要面向 PHP 开发者，旨在使 PHP 开发者更方便的使用 Docker 搭建开发环境。它有如下特点：

- 为 PHP 框架而生。不同于其它镜像，本镜像的目标是内置最火的十套 PHP 框架的网站配置文件，让使用这十套框架的 PHP 用户不再担心环境问题，同时支持自定义配置，方便其它框架使用者使用。目前已支持国内主流框架 Thinkphp 和 国外主流框架 Laravel。不同框架对服务器的要求主要区别在 HTTP Server(Nging or Apache) 的配置和 PHP 模块的依赖。本镜像设置了 config 目录，用于存放不同框架的 HTTP Server 配置，同时本身是基于[官方 `php` 镜像](https://github.com/docker-library/docs/tree/master/php), 可以很方便的安装新的PHP 模块。
- 支持设置 Git 仓库地址，可以自动从 Git 仓库安装项目
- 使用 Composer 管理的项目自动安装依赖（由于国内通过 Composer 安装依赖经常发生失败的情况，已注释掉入口文件中自动安装依赖的部分）
- 可以通过 SSH 访问。由于 alauda 等部署平台的局限性，如果服务不能通过 SSH 访问将很难管理。
- 多版本 PHP 支持。目前支持 `PHP 5.4, 5.5, 5.6`，能满足绝大部分 PHP 环境的需求。
- 已替换 apt 软件源内国内软件源，软件安装、更新速度更快
- 本地 Mysql 端口转发到链接的或指定的 Mysql Server 上。非常方便的一个功能，本地开发时我们在框架中一般指定使用本地3306端口的 Mysql Server，但部署到 Docker 容器中时，一般使用链接的 Mysql Server，这时一般需要修改框架中的 Mysql 配置。本镜像通过本地 Mysql 端口转发，避免了对代码的修改，使部署更省心。
- 内置反向代理功能。主要是为了开发过程中给非同一 Lan 下的朋友演示自己开发的网站。你是否遇到这样的问题，埋头本地开发，朋友、同学想看看自己的项目，但是本地环境又无法通过公网访问。通过在 Alauda 上使用本镜像搭建一个反向代理服务器，本地通过 ssh 连上代理服务器，就可以让公网的朋友看到本地开发的项目了。

Alauda命令行客户端[`xjchengo/alauda`](https://github.com/xjchengo/alauda-php)面向所有 Alauda 用户，安装后可以在命令行中查看账号信息、管理自己的仓库、服务及服务实例。![命令列表](http://7xjbct.com2.z0.glb.qiniucdn.com/cmd.png) 其中最有特色的功能为 up 和 service:create 。 up 命令秒秒钟为你在 Alauda 上部署[`index.alauda.cn/xjchengo/php` 镜像](https://github.com/xjchengo/docker-nginx-php)，使用场景为，项目需要阶段性部署时， up 一下，一切已在 Alauda 上。service:create 命令兼容 docker-compose 的配置，可直接读取 docker-compose.yml 文件，然后在 Alauda 上创建相应的服务。使用场景为：本地测试通过 docker-compose ，项目部署时 alauda service:create ，无缝切换。 

## 参赛心得

使用过 Alauda 和 DaoCloud 两家的服务，就我的使用感受，对比如下：

- 开放性。 Alauda 非常开放，不限制 expose 的端口，有 api。DaoCloud目前只支持 HTTP 端口，无开放 api。
- 镜像构建稳定性。 Alauda 上构建镜像时，偶尔会出现 Waiting... ，并持续很长世间。并且日志经常显示从 alauda 自己的仓库中 pull 镜像时失败，转向 index.docker.com 去 pull。既然是面向中国用户，服务器时区改为中国的时区更好。
- Web 界面的美观性和易用性不足，与 DaoCloud 一比，顿时占了下风。最明显的莫过于加速器的使用帮助，DaoCloud 好太多，加速器又是当前国内大部分 Docker 用户最核心的需求，有必要把加速器的使用帮助先完善。
