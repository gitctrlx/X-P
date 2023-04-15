# X-Environment Configuration

## 概述

这是用来快速配置环境的bash/shell脚本。



## 安装

```
git clone https://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@github.com/1438802682/X.git && cd X && bash _i.sh
```



## 如何使用

### 基础环境

#### 使用v.sh进行加速

##### pip加速

pip一般情况下会自动读取系统代理的设置，但是pip不一定会自动读取系统代理的设置，因此可能需要手动设置pip的代理，直接使用第二个步骤进行下载。

具体的步骤如下：

1. 打开终端，输入以下命令来配置环境变量：（如果在`v.sh`中已经开启全局代理则可以跳过）

   ```py
   export http_proxy=http://127.0.0.1:10809
   export https_proxy=http://127.0.0.1:10809
   ```

   这里将http和https代理都配置为本地的v2ray服务地址和端口（默认为127.0.0.1:10809），这样通过代理访问网络时就会使用v2ray进行加速。

2. 使用pip下载包时，在pip命令后添加"--proxy"选项，指定代理地址和端口：

   ```py
   pip install --user --proxy http://127.0.0.1:10809 <package_name>
   ```

   这里将pip代理配置为本地的v2ray服务地址和端口（默认为127.0.0.1:10809），这样使用pip下载包时就会通过v2ray进行加速。

需要注意的是，如果系统代理设置为v2ray的本地服务地址和端口（已在`v.sh`中已经开启全局代理，下面同理，不再文字赘述），那么第一步中的环境变量可以省略，因为pip会自动读取系统代理的设置。但是，如果pip无法自动读取系统代理的设置，就需要手动设置pip的代理。

##### conda加速

如果您已经将v2ray的服务端口设置为系统的全局代理，那么conda会自动读取系统代理的设置，无需手动配置conda的代理，如果无法正确读取则需要手动配置：

具体的方法有如下两种：

1. 配置conda代理：打开终端，输入以下命令来配置conda代理：（只在当前会话有效）

   ```sh
   conda config --set proxy_servers.http http://127.0.0.1:10809
   conda config --set proxy_servers.https http://127.0.0.1:10809
   ```

   这里将http和https代理都配置为本地的v2ray服务地址和端口（默认为127.0.0.1:10809），这样通过代理访问网络时就会使用v2ray进行加速。

   这是临时的配置。这种方式设置的代理只在当前终端会话中生效，并不是永久生效的。当您关闭终端或重启系统后，这些代理配置会被清除。

   如果希望永久配置conda代理，可以将这些配置添加到conda的配置文件中。conda的配置文件通常位于用户主目录下的".condarc"文件中。您可以编辑".condarc"文件，在其中添加如下内容：

   ```sh
   proxy_servers:
     http: http://127.0.0.1:10809
     https: http://127.0.0.1:10809
   ```

   这样，在下次使用conda时，就会自动读取这些代理配置，以使用v2ray进行加速。

   

需要注意的是，如果系统代理设置为v2ray的本地服务地址和端口，即已经在v.sh中开启了全局模式，那么第一步中的conda配置命令可以省略，因为conda会自动读取系统代理的设置。但是，如果conda无法自动读取系统代理的设置，就需要手动设置conda的代理。

##### wget加速

可以通过设置环境变量来为wget配置代理，以使用v2ray进行加速。具体的操作步骤如下：

1. 配置环境变量：打开终端，输入以下命令来配置环境变量：

   ```sh
   export http_proxy=http://127.0.0.1:10809
   export https_proxy=http://127.0.0.1:10809
   ```

   这里将http和https代理都配置为本地的v2ray服务地址和端口（默认为127.0.0.1:10809），这样通过代理访问网络时就会使用v2ray进行加速。

2. 使用wget下载文件时，在wget命令后添加"--proxy"选项，指定代理地址和端口：

   ```sh
   wget --proxy=http://127.0.0.1:10809 <download_url>
   ```

   这里将wget代理配置为本地的v2ray服务地址和端口（默认为127.0.0.1:10809），这样使用wget下载文件时就会通过v2ray进行加速。

需要注意的是，如果系统代理设置为v2ray的本地服务地址和端口，那么第一步中的环境变量可以省略，因为wget会自动读取系统代理的设置。但是，如果wget无法自动读取系统代理的设置，就需要手动设置wget的代理。

##### curl加速

可以通过设置环境变量来为curl配置代理，以使用v2ray进行加速。具体的操作步骤如下：

1. 配置环境变量：打开终端，输入以下命令来配置环境变量：

   ```sh
   export http_proxy=http://127.0.0.1:10809
   export https_proxy=http://127.0.0.1:10809
   ```

   这里将http和https代理都配置为本地的v2ray服务地址和端口（默认为127.0.0.1:10809），这样通过代理访问网络时就会使用v2ray进行加速。

2. 使用curl访问网址时，在curl命令后添加"-x"选项，指定代理地址和端口：

   ```sh
   curl -x http://127.0.0.1:10809 <url>
   ```

   这里将curl代理配置为本地的v2ray服务地址和端口（默认为127.0.0.1:10809），这样使用curl访问网址时就会通过v2ray进行加速。

需要注意的是，如果系统代理设置为v2ray的本地服务地址和端口，那么第一步中的环境变量可以省略，因为curl会自动读取系统代理的设置。但是，如果curl无法自动读取系统代理的设置，就需要手动设置curl的代理。

##### apt加速

是的，Ubuntu系统使用`apt`命令下载包或更新时也可以使用v2ray加速。

可以按照以下步骤进行配置：

1. 打开`/etc/apt/apt.conf`文件，如果该文件不存在，则创建一个新文件，并添加以下内容：

   ```sh
   Acquire::http::proxy "http://127.0.0.1:10809/";
   Acquire::https::proxy "http://127.0.0.1:10809/";
   ```

   这里将`http`和`https`代理都配置为本地的v2ray服务地址和端口（默认为127.0.0.1:10809），这样通过代理访问网络时就会使用v2ray进行加速。

2. 使用`sudo apt update`或`sudo apt install <package_name>`等命令下载或更新包时，系统会自动读取`apt.conf`文件中的代理配置，从而使用v2ray进行加速。

需要注意的是，如果系统代理设置为v2ray的本地服务地址和端口，那么第一步中的`apt.conf`文件配置可以省略，因为`apt`命令会自动读取系统代理的设置。但是，如果`apt`命令无法自动读取系统代理的设置，就需要手动配置`apt.conf`文件。

### 特殊环境

#### DL



## 环境配置

### 文件架构

#### 基础环境

```sh
X/
├── _i.sh
├── _x.sh
├── v.sh
├── config/
│   └── .json
```

#### 特殊环境

```
X/
└── DL/
    ├── _mm.sh
    └── _trt.sh

```

注：环境配置脚本前带有`_`标识符，常用程序脚本不带该表示符。

### 详细功能

#### 基础环境

##### `_i.sh`

**作用：**

1. 添加仓库路径到环境变量
2. 为所有 `.sh` 脚本添加执行权限

**补充：**

- 检测脚本是否都获得了运行权限是可选项，当脚本数量过多时检测可能会消耗大量时间



##### `_x.sh`

**作用：**

1. 安装编译工具（gcc、g++等）
2. 安装miniconda环境

**补充：**

- 无法自动拉去最新版本，需要手动更新下载源
- 自动检测Linux系统类别：Debian/rhel
- 自动检测是否已安装conda，如果已安装则会询问是否要安装最新版本
- 自动检测是否已将conda添加到环境变量中



##### `v.sh`

**作用：**

1. 配置v2ray

**补充：**

- 自动拉取最新版本进行安装，无需手动更新安装源
- 自动检测是否已安装v2ray
- 支持多节点切换（config文件夹存放配置文件）
- 自动检测配置文件是否存在
- 自动检测配置文件是否有效
- 询问用户是否开启全局模式（全局模式/手动模式）
- 自动检查并开启防火墙端口
- 支持后台运行，且自动记录与检测日志信息
- 开启服务后自动验证代理的有效性



#### 特殊环境



## 补充

**为什么我的`_i.sh`没有执行权限，但是当我运行`bash _i.sh`的时候能成功运行呢？而运行`./_i.sh`就不行呢**

当你运行 `bash i.sh` 时，你是在告诉系统使用 `bash` 命令来解释并执行 `i.sh` 脚本。在这种情况下，不需要对脚本文件本身设置执行权限，因为 `bash` 本身就有执行权限。

然而，当你使用 `./i.sh` 来运行脚本时，你实际上是在尝试直接执行这个文件。这就要求文件本身具有执行权限。如果文件没有执行权限，你会收到一个类似于 `Permission denied` 的错误。

要给 `i.sh` 脚本添加执行权限，你可以使用 `chmod` 命令：

```
chmod +x i.sh
```

现在，你应该可以使用 `./i.sh` 命令来运行脚本。



**`chmod +x i.sh && ./i.sh` `chmod +x i.sh ; ./i.sh` 上面这两种写法有何区别**

这两种写法的区别在于命令的执行逻辑：

1. `chmod +x i.sh && ./i.sh`：在这种写法中，`&&` 符号表示逻辑“与”。这意味着只有当 `chmod +x i.sh` 命令成功执行（返回值为0）时，才会执行 `./i.sh` 命令。如果第一个命令失败，那么第二个命令将不会执行。
2. `chmod +x i.sh ; ./i.sh`：在这种写法中，`;` 符号表示顺序执行。这意味着无论 `chmod +x i.sh` 命令是否成功执行，接下来都会执行 `./i.sh` 命令。这里的执行顺序不依赖于前一个命令的成功与否。

综上，这两种写法的主要区别在于，使用 `&&` 时，只有在前一个命令成功执行的情况下，才会执行后一个命令；而使用 `;` 时，无论前一个命令是否成功，后一个命令都会执行。



**curl与wget如何选择**

`curl`是一款非常常用的命令行工具，常用来进行HTTP请求和数据传输，具有以下常见的用途：

1. 下载文件：`curl`可以通过HTTP或FTP协议下载文件，支持断点续传和HTTP代理，可以使用`-o`选项将下载的内容保存到指定文件。
2. 调试HTTP请求：`curl`可以发送HTTP请求，并打印出服务器响应的HTTP头和内容，可以用于调试和测试API接口。
3. 上传文件：`curl`可以通过HTTP或FTP协议上传文件，可以使用`-F`选项上传文件或表单数据。
4. 自定义HTTP请求头：`curl`可以通过`-H`选项自定义HTTP请求头，如添加User-Agent、Authorization等信息。
5. 转发HTTP请求：`curl`可以将一个HTTP请求转发到另一个服务器上，可以用于搭建反向代理或负载均衡。
6. 发送邮件：`curl`可以通过SMTP协议发送邮件，可以使用`-s`选项禁止输出信息。
7. 测试网络连接：`curl`可以通过TCP或UDP协议测试网络连接，可以使用`-I`选项只返回HTTP头信息。
8. 传输数据：`curl`可以通过HTTP或FTP协议传输数据，支持多种编码方式和数据格式，可以使用`-d`选项传输数据。

需要注意的是，`curl`功能非常强大，但也非常灵活，对于不同的用途可能需要使用不同的选项和参数来进行定制。



`wget`是一款非常常用的命令行工具，主要用于从网络上下载文件或资源，具有以下常见的用途：

1. 下载文件：`wget`可以通过HTTP、HTTPS和FTP协议下载文件，支持断点续传和HTTP代理，可以使用`-O`选项将下载的内容保存到指定文件。
2. 递归下载：`wget`可以递归下载某个目录下的所有文件，可以使用`-r`选项进行递归下载。
3. 断点续传：`wget`可以在下载过程中中断，并在下次下载时继续未完成的部分，可以使用`-c`选项实现断点续传。
4. 镜像站同步：`wget`可以使用`-m`选项实现镜像站同步，可以将一个FTP或HTTP站点完整地下载到本地。
5. 下载限速：`wget`可以使用`--limit-rate`选项限制下载速度，避免对网络带宽造成过大影响。
6. 用户认证：`wget`可以通过HTTP基本认证或FTP认证登录受保护的站点，可以使用`--user`和`--password`选项进行用户认证。
7. 批量下载：`wget`可以通过`-i`选项从一个文件中读取URL列表，并下载这些URL指向的文件。

需要注意的是，`wget`功能比较简单，但也非常实用，对于从网络上下载文件或资源非常方便，能够快速完成下载任务。



**`git pull` 和`git fetch`有什么区别**

`git pull` 和 `git fetch` 都是用来更新本地仓库的，但是它们有一些区别。

`git pull` 会从远程仓库拉取代码并尝试合并（merge）到当前分支。它等同于执行了 `git fetch` 和 `git merge` 两个命令。

`git fetch` 会从远程仓库拉取代码，但是并不会自动合并到当前分支，而是将代码更新保存在本地仓库的远程分支（remote-tracking branch）上。如果需要将这些更新合并到当前分支，需要手动执行 `git merge` 或者 `git rebase` 命令。

因此，`git fetch` 更加安全，因为它不会自动修改本地分支。同时，`git fetch` 可以让你先查看远程仓库的更新情况，再决定是否要将其合并到本地仓库。而 `git pull` 则可能会自动进行合并，如果合并出现冲突，需要手动解决冲突。

`git fetch` 和 `git fetch --all` 都是用来从远程仓库获取更新的命令，不同之处在于：

- `git fetch`：默认只会从远程仓库拉取当前所在分支的更新，如果想要更新其他分支的内容需要显式指定分支名称。比如：`git fetch origin master` 表示从远程仓库 `origin` 拉取 `master` 分支的更新。
- `git fetch --all`：表示从所有远程仓库拉取更新，相当于依次执行 `git fetch` 命令获取所有远程仓库的更新。

需要注意的是，`git fetch` 和 `git fetch --all` 都只会将远程仓库的更新下载到本地仓库，并不会自动合并到当前分支。如果想要将远程仓库的更新合并到当前分支，需要再执行 `git merge` 或 `git rebase` 命令。