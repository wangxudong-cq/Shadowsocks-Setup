# Shadowsocks-Setup
Shadowsocks 服务器配置一键安装脚本（含BBR加速）

### 适用平台

脚本配套于[Vultr](https://my.vultr.com/)进行编写，理论上也适用于其他平台。

### 使用说明

#### 服务器建立

以Vultr平台为例，新建一服务器，选项如下：
- Server Location: 任意
- Server Type: Ubuntu 18.04 x64
- Server Size: 任意（不支持IPv6不要选择IPv6 Only的）
- Addition Features: 若网络环境支持IPv6的话可勾选 Enable IPv6, 其他无需选择。

#### SSH连接

Windows平台可使用[Putty](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html),输入服务器IP地址和密码即可连接。
Linux可直接使用 ```SSH root@[服务器IP地址]```，输入密码后可连接

#### 服务器配置

连接成功后，输入
```
git clone https://github.com/Joinn99/Shadowsocks-Setup && cd Shadowsocks-Setup
bash setup.sh
```
即可按默认方式完成配置，可以使用shadowsocks客户端尝试连接。

若希望手动配置，则将```bash setup.sh```改为```bash setup.sh custom```，根据提示设置密码、端口号、加密方式（输入为空是仍采用默认配置）

#### 参考
[Ubuntu 16.04下Shadowsocks服务器端安装及优化](https://www.polarxiong.com/archives/Ubuntu-16-04%E4%B8%8BShadowsocks%E6%9C%8D%E5%8A%A1%E5%99%A8%E7%AB%AF%E5%AE%89%E8%A3%85%E5%8F%8A%E4%BC%98%E5%8C%96.html)
# Shadowsocks-Setup
